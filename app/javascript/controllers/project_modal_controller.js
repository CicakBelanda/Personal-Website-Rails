import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { projects: Array }
  static targets = [
    "root", "backdrop", "dialog", "close", "scroll",
    "category", "status", "title", "short", "meta",
    "overview", "techSection", "tech",
    "problemSection", "problem", "solutionSection", "solution",
    "techDetailsSection", "techDetails", "featuresSection", "features",
    "metricsSection", "metrics", "gallerySection", "gallery", "actions", "cover",
    "caseStudy"
  ]

  connect() {
    this.lastFocused = null
    this.onKeydown = this.onKeydown.bind(this)
    document.addEventListener("keydown", this.onKeydown)
  }

  disconnect() {
    document.removeEventListener("keydown", this.onKeydown)
    this.unlockScroll()
  }

  // Capture the page scroll position on hover / touch-start — this fires BEFORE the click
  // that opens the modal, so it reflects where the user actually is (the native click
  // focus-scroll would otherwise shift the page and we could never observe the pre-click
  // value from inside the click handler).
  rememberPreScroll(event) {
    this._preScroll = window.scrollY
  }

  open(event) {
    event.preventDefault()
    const id = event.currentTarget.dataset.projectId
    const data = this.projectsValue.find(p => String(p.id) === String(id))
    if (!data) return
    this.lastFocused = event.currentTarget
    this.populate(data)
    this.show()
  }

  backdropClose(event) {
    // Only close if the click landed on the backdrop itself, not bubbled from the dialog.
    if (event.target === event.currentTarget) this.close()
  }

  close() {
    if (this.rootTarget.hidden) return
    const finish = () => {
      this.rootTarget.hidden = true
      this.rootTarget.classList.remove("is-open", "is-closing")
      this.dialogTarget.classList.remove("is-open", "is-closing")
      this.backdropTarget.classList.remove("is-open", "is-closing")
      this.unlockScroll()
      if (this.lastFocused && typeof this.lastFocused.focus === "function") {
        this.lastFocused.focus({ preventScroll: true })
      }
    }
    if (this.reducedMotion()) {
      finish()
    } else {
      this.rootTarget.classList.add("is-closing")
      this.dialogTarget.classList.add("is-closing")
      this.backdropTarget.classList.add("is-closing")
      setTimeout(finish, 320)
    }
  }

  // --- internals ---

  reducedMotion() {
    return window.matchMedia("(prefers-reduced-motion: reduce)").matches
  }

  show() {
    // Use the position captured on hover/touch (pre-click). If unavailable (keyboard
    // open), fall back to the live position.
    this.scrollY = (this._preScroll != null) ? this._preScroll : window.scrollY
    // The click may have focus-scrolled the card into view; snap straight back to the
    // captured position instantly so the page doesn't visibly shift when the modal opens.
    window.scrollTo({ top: this.scrollY, behavior: "instant" })
    this.rootTarget.hidden = false
    this.lockScroll()
    if (!this.reducedMotion()) {
      // force reflow so the transition runs
      void this.rootTarget.offsetWidth
      this.rootTarget.classList.add("is-open")
      this.dialogTarget.classList.add("is-open")
      this.backdropTarget.classList.add("is-open")
    }
    requestAnimationFrame(() => this.closeTarget.focus({ preventScroll: true }))
  }

  lockScroll() {
    // Lock scrolling by hiding overflow on the scroll container. This preserves the
    // current scroll position (unlike position:fixed, which resets it) so closing the
    // modal returns the page exactly where it was — no jump/refresh effect.
    document.documentElement.style.overflow = "hidden"
    document.body.style.overflow = "hidden"
    document.documentElement.classList.add("modal-open")
  }

  unlockScroll() {
    if (document.documentElement.classList.contains("modal-open")) {
      // Restore instantly while smooth-scroll is still disabled (modal-open), so the
      // page snaps back to the pre-open position with no animated slide.
      window.scrollTo({ top: this.scrollY || 0, behavior: "instant" })
      document.documentElement.classList.remove("modal-open")
      document.documentElement.style.overflow = ""
      document.body.style.overflow = ""
    }
  }

  onKeydown(e) {
    if (this.rootTarget.hidden) return
    if (e.key === "Escape") {
      this.close()
    } else if (e.key === "Tab") {
      this.trapFocus(e)
    }
  }

  trapFocus(e) {
    const focusables = this.focusable()
    if (!focusables.length) return
    const first = focusables[0]
    const last = focusables[focusables.length - 1]
    if (e.shiftKey && document.activeElement === first) {
      e.preventDefault(); last.focus()
    } else if (!e.shiftKey && document.activeElement === last) {
      e.preventDefault(); first.focus()
    }
  }

  focusable() {
    return Array.from(this.dialogTarget.querySelectorAll(
      'a[href], button:not([disabled]), [tabindex]:not([tabindex="-1"]), input, select, textarea'
    )).filter(el => el.offsetParent !== null)
  }

  // --- population (all data from DB; empty fields hidden) ---

  populate(d) {
    this.setText(this.categoryTarget, `${d.categoryLabel}${d.status ? " · " + d.status : ""}`)
    this.toggle(this.statusTarget, false) // status folded into category line
    this.setText(this.titleTarget, d.title)
    this.setText(this.shortTarget, d.shortDescription)
    this.setText(this.overviewTarget, d.description)

    // metadata line: date · location · role · client
    const meta = []
    if (d.date) meta.push(["Date", d.date])
    if (d.location) meta.push(["Location", d.location])
    if (d.role) meta.push(["Role", d.role])
    if (d.client) meta.push(["Client", d.client])
    this.metaTarget.innerHTML = ""
    meta.forEach(([k, v]) => {
      const li = document.createElement("li")
      li.innerHTML = `<span class="project-modal__meta-k">${k}</span><span class="project-modal__meta-v">${this.esc(v)}</span>`
      this.metaTarget.appendChild(li)
    })
    this.metaTarget.style.display = meta.length ? "" : "none"

    // tech stack chips
    this.renderChips(this.techTarget, d.techStack)
    this.toggle(this.techSectionTarget, Array.isArray(d.techStack) && d.techStack.length)

    this.renderText(this.problemSectionTarget, this.problemTarget, d.problem)
    this.renderText(this.solutionSectionTarget, this.solutionTarget, d.solution)
    this.renderText(this.techDetailsSectionTarget, this.techDetailsTarget, d.techDetails)
    this.renderList(this.featuresSectionTarget, this.featuresTarget, d.keyFeatures)
    this.renderMetrics(d.metrics)
    // Hide the entire Case Study block if none of its parts have content.
    const caseHas = [d.problem, d.solution].some(v => v && String(v).trim().length) ||
      (Array.isArray(d.metrics) && d.metrics.some(m => m && (m.value || m.label)))
    this.toggle(this.caseStudyTarget, caseHas)
    this.renderGallery(d)

    // actions (only existing urls)
    this.actionsTarget.innerHTML = ""
    if (d.demoUrl) this.actionsTarget.appendChild(this.linkBtn(d.demoUrl, d.demoUrl.includes("itunes.apple.com") ? "App Store" : "Live Demo", "btn-primary"))
    if (d.githubUrl) this.actionsTarget.appendChild(this.linkBtn(d.githubUrl, "View on GitHub", "btn-outline"))

    // cover image
    if (d.coverImage) {
      this.coverTarget.style.backgroundImage = `url('${d.coverImage}')`
      this.coverTarget.style.display = ""
    } else {
      this.coverTarget.style.display = "none"
    }
  }

  renderText(section, target, value) {
    const has = value && String(value).trim().length
    this.toggle(section, has)
    if (has) target.innerHTML = this.esc(value)
  }

  renderList(section, target, value) {
    const items = Array.isArray(value) ? value : (value ? [value] : [])
    this.toggle(section, items.length)
    target.innerHTML = ""
    items.forEach(it => {
      const li = document.createElement("li")
      li.textContent = it
      target.appendChild(li)
    })
  }

  renderChips(target, value) {
    const items = Array.isArray(value) ? value : (value ? [value] : [])
    target.innerHTML = ""
    items.forEach(it => {
      const span = document.createElement("span")
      span.className = "tech-badge"
      span.textContent = it
      target.appendChild(span)
    })
  }

  renderMetrics(value) {
    const items = Array.isArray(value) ? value : (value ? [value] : [])
    const valid = items.filter(m => m && (m.value || m.label))
    this.toggle(this.metricsSectionTarget, valid.length)
    this.metricsTarget.innerHTML = ""
    valid.forEach(m => {
      const div = document.createElement("div")
      div.className = "project-modal__metric"
      div.innerHTML = `<div class="project-modal__metric-value">${this.esc(m.value || "")}</div><div class="project-modal__metric-label">${this.esc(m.label || "")}</div>`
      this.metricsTarget.appendChild(div)
    })
  }

  renderGallery(d) {
    const imgs = []
    if (d.coverImage) imgs.push(d.coverImage)
    if (Array.isArray(d.gallery)) imgs.push(...d.gallery)
    const unique = [...new Set(imgs)].filter(Boolean)
    this.toggle(this.gallerySectionTarget, unique.length > 1)
    this.galleryTarget.innerHTML = ""
    if (unique.length <= 1) {
      // single image (or none): handled by cover; hide gallery section
      return
    }
    // primary (first) + supporting grid
    unique.forEach((src, i) => {
      const fig = document.createElement("figure")
      fig.className = i === 0 ? "project-modal__gallery-primary" : "project-modal__gallery-item"
      const im = document.createElement("img")
      im.loading = "lazy"
      im.decoding = "async"
      im.src = src
      im.alt = `${d.title} screenshot ${i + 1}`
      fig.appendChild(im)
      this.galleryTarget.appendChild(fig)
    })
  }

  linkBtn(href, label, variant) {
    const a = document.createElement("a")
    a.href = href
    a.target = "_blank"
    a.rel = "noopener noreferrer"
    a.className = `btn ${variant}`
    a.textContent = label
    return a
  }

  setText(target, value) {
    target.textContent = value || ""
  }

  toggle(target, show) {
    target.style.display = show ? "" : "none"
  }

  esc(s) {
    const d = document.createElement("div")
    d.textContent = s == null ? "" : String(s)
    return d.innerHTML
  }
}

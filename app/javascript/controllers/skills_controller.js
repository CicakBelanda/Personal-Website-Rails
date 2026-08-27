import { Controller } from "@hotwired/stimulus"

// Skills "Technical Ecosystem": three discipline branches with progressive
// disclosure of their technologies, plus a contextual detail panel that shows a
// technology's description and the real projects that use it (data from the DOM).
// Works with mouse, keyboard, and touch; respects prefers-reduced-motion.
export default class extends Controller {
  static targets = ["detail"]

  connect() {
    this.reduced = window.matchMedia("(prefers-reduced-motion: reduce)").matches
    this.lockedId = null
  }

  // Click / Enter on a discipline: toggle open. A second click on the open
  // discipline collapses it; clicking another discipline switches.
  toggle(e) {
    const branch = e.currentTarget.closest("[data-skill-branch]")
    const disc = branch.dataset.discipline
    const techs = branch.querySelector("[data-skill-techs]")
    if (!techs.hidden && this.lockedId === disc) {
      this.collapseAll()
      this.lockedId = null
    } else {
      this.collapseAll()
      this.openBranch(branch, techs)
      this.lockedId = disc
    }
  }

  // Hover / focus on a discipline: open it as a preview (non-locking) without
  // collapsing siblings unless nothing is locked.
  activate(e) {
    const branch = e.currentTarget.closest("[data-skill-branch]")
    const techs = branch.querySelector("[data-skill-techs]")
    if (techs.hidden) this.openBranch(branch, techs)
  }

  showTech(e) {
    const btn = e.currentTarget
    this.renderDetail(btn.dataset.name, btn.dataset.desc, this.parseProjects(btn.dataset.projects))
  }

  reset() {
    this.collapseAll()
    this.lockedId = null
    this.clearDetail()
  }

  // --- internals ---

  openBranch(branch, techs) {
    branch.classList.add("is-open")
    techs.hidden = false
    const btn = branch.querySelector("[data-skill-discipline]")
    btn.setAttribute("aria-expanded", "true")
    if (!this.reduced) {
      // Stagger the tech rows in for a calm, technical reveal.
      techs.querySelectorAll("[data-skill-tech]").forEach((el, i) => {
        el.style.transitionDelay = `${Math.min(i * 28, 280)}ms`
        requestAnimationFrame(() => el.classList.add("is-in"))
      })
    } else {
      techs.querySelectorAll("[data-skill-tech]").forEach((el) => el.classList.add("is-in"))
    }
  }

  collapseAll() {
    this.element.querySelectorAll("[data-skill-branch].is-open").forEach((branch) => {
      branch.classList.remove("is-open")
      const techs = branch.querySelector("[data-skill-techs]")
      techs.hidden = true
      techs.querySelectorAll("[data-skill-tech]").forEach((el) => {
        el.classList.remove("is-in")
        el.style.transitionDelay = ""
      })
      branch.querySelector("[data-skill-discipline]").setAttribute("aria-expanded", "false")
    })
  }

  parseProjects(raw) {
    try { return JSON.parse(raw || "[]") } catch { return [] }
  }

  renderDetail(name, desc, projects) {
    const used = projects.length
      ? `<div class="skill-detail__used">Used in</div>
         <ul class="skill-detail__projects">${projects
           .map((p) => `<li>${this.esc(p.title)}</li>`)
           .join("")}</ul>`
      : `<div class="skill-detail__used skill-detail__used--none">No linked projects yet</div>`

    this.detailTarget.innerHTML = `
      <div class="skill-detail__inner">
        <h3 class="skill-detail__name">${this.esc(name)}</h3>
        <p class="skill-detail__desc">${this.esc(desc)}</p>
        ${used}
      </div>`
    this.detailTarget.classList.add("is-active")
  }

  clearDetail() {
    this.detailTarget.innerHTML = `<div class="skill-detail__inner"><p class="skill-detail__placeholder">Select a technology to see how it is used.</p></div>`
    this.detailTarget.classList.remove("is-active")
  }

  esc(s) {
    return String(s).replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]))
  }
}

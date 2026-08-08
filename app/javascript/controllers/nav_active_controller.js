import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["nav", "link"]

  connect() {
    this.onScroll = this.handleScroll.bind(this)
    this.updateSpy = this.updateSpy.bind(this)
    window.addEventListener("scroll", this.onScroll, { passive: true })
    this.observer = new IntersectionObserver(this.updateSpy, {
      rootMargin: "-45% 0px -50% 0px",
      threshold: 0
    })
    this.linkTargets.forEach((link) => {
      const id = link.getAttribute("href")
      if (id && id.startsWith("#")) {
        const section = document.querySelector(id)
        if (section) this.observer.observe(section)
      }
    })
    this.handleScroll()
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll)
    if (this.observer) this.observer.disconnect()
  }

  handleScroll() {
    if (this.hasNavTarget) {
      this.navTarget.classList.toggle("is-scrolled", window.scrollY > 12)
    }
  }

  updateSpy(entries) {
    entries.forEach((entry) => {
      if (!entry.isIntersecting) return
      const id = "#" + entry.target.id
      this.linkTargets.forEach((link) => {
        link.classList.toggle("active", link.getAttribute("href") === id)
      })
    })
  }
}

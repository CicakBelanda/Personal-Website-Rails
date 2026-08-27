import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]

  connect() {
    this.items = this.itemTargets.length ? this.itemTargets : this.element.querySelectorAll(".reveal, .project-card")
    if (!this.items.length) return

    // Reveal as soon as any part of the element enters the viewport (no negative
    // bottom margin, so cards don't stay hidden until scrolled well past them).
    this.observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("is-visible")
          this.observer.unobserve(entry.target)
        }
      })
    }, { threshold: 0, rootMargin: "0px 0px 80px 0px" })

    this.items.forEach((el) => this.observer.observe(el))

    // Safety net: if an element is already in the viewport on load (or the
    // observer never fires for some reason), reveal it shortly after connect so
    // nothing stays invisible / non-interactive.
    this.safety = setTimeout(() => {
      this.items.forEach((el) => {
        const r = el.getBoundingClientRect()
        if (r.top < window.innerHeight && r.bottom > 0) el.classList.add("is-visible")
      })
    }, 1200)
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
    if (this.safety) clearTimeout(this.safety)
  }
}

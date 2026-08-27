import { Controller } from "@hotwired/stimulus"

// Interactive skills network (Phase 3, PRD §9).
// Skills are laid out server-side as an SVG constellation grouped by domain.
// Hovering a node highlights its whole domain cluster and dims the others;
// a label follows the pointer. Reduced motion / no JS falls back to the
// static chip panorama (handled in markup + CSS).
export default class extends Controller {
  static targets = ["svg", "label"]

  connect() {
    this.reduce = window.matchMedia("(prefers-reduced-motion: reduce)").matches
    this.element.classList.remove("no-js")
    if (this.reduce) return
    this.onMove = this.moveLabel.bind(this)
    this.svgTarget.addEventListener("pointermove", this.onMove, { passive: true })
  }

  // Hover a node -> activate its domain, dim the rest.
  activate(e) {
    const node = e.target.closest("[data-domain]")
    if (!node) return
    const domain = node.dataset.domain
    this.element.querySelectorAll("[data-domain]").forEach((el) => {
      const same = el.dataset.domain === domain
      el.classList.toggle("is-dim", !same)
      el.classList.toggle("is-active", same)
    })
    this.showLabel(node.dataset.name, node.dataset.domain)
  }

  reset() {
    this.element.querySelectorAll("[data-domain]").forEach((el) => {
      el.classList.remove("is-dim", "is-active")
    })
    this.labelTarget.classList.remove("is-visible")
  }

  showLabel(name, domain) {
    const colors = { ios: "#0a84ff", ds: "#22c55e", web: "#06b6d4" }
    this.labelTarget.textContent = name
    this.labelTarget.style.setProperty("--label-accent", colors[domain] || "var(--accent)")
    this.labelTarget.classList.add("is-visible")
  }

  moveLabel(e) {
    this.labelTarget.style.transform = `translate(${e.clientX + 16}px, ${e.clientY + 16}px)`
  }

  disconnect() {
    if (this.svgTarget) this.svgTarget.removeEventListener("pointermove", this.onMove)
  }
}

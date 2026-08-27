import { Controller } from "@hotwired/stimulus"

// Mobile navigation toggle. The floating pill nav shows a hamburger below
// 768px; tapping it reveals a dropdown panel. Closes on outside-click and
// Escape, and is fully keyboard operable (PRD §39 / §52).
export default class extends Controller {
  static targets = ["toggle", "menu"]

  connect() {
    this.onDocClick = this.handleDocClick.bind(this)
    this.onKey = this.handleKey.bind(this)
    document.addEventListener("click", this.onDocClick)
    document.addEventListener("keydown", this.onKey)
  }

  disconnect() {
    document.removeEventListener("click", this.onDocClick)
    document.removeEventListener("keydown", this.onKey)
  }

  toggle() {
    const open = this.menuTarget.classList.toggle("is-open")
    this.toggleTarget.setAttribute("aria-expanded", String(open))
  }

  close() {
    this.menuTarget.classList.remove("is-open")
    this.toggleTarget.setAttribute("aria-expanded", "false")
  }

  handleDocClick(event) {
    if (!this.menuTarget.classList.contains("is-open")) return
    if (this.element.contains(event.target)) return
    this.close()
  }

  handleKey(event) {
    if (event.key === "Escape" && this.menuTarget.classList.contains("is-open")) {
      this.close()
      this.toggleTarget.focus()
    }
  }
}

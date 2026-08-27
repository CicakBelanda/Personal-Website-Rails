import { Controller } from "@hotwired/stimulus"

// Accessible expand/collapse for cards (research, etc.). Toggles the body
// visibility and the aria-expanded state. Works with mouse, keyboard, and
// touch (the trigger is a <button>, PRD §39 / §52).
export default class extends Controller {
  static targets = ["body"]

  toggle() {
    const expanded = this.bodyTarget.hasAttribute("hidden")
    if (expanded) {
      this.bodyTarget.removeAttribute("hidden")
    } else {
      this.bodyTarget.setAttribute("hidden", "")
    }
    this.element
      .querySelector("[aria-expanded]")
      ?.setAttribute("aria-expanded", String(expanded))
    const chevron = this.element.querySelector(".research-card__chevron")
    if (chevron) chevron.textContent = expanded ? "–" : "+"
  }
}

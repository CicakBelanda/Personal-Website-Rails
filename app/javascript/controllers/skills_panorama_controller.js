import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["rows"]

  connect() {
    // JS works — drop the no-js fallback (which shows a static stacked layout).
    this.element.classList.remove("no-js")

    const reduce = window.matchMedia("(prefers-reduced-motion: reduce)").matches
    if (reduce || !this.hasRowsTarget) {
      this.element.classList.add("is-static")
      return
    }

    // Cache each row track + its slide direction from the data-dir attribute.
    this.rows = Array.from(
      this.rowsTarget.querySelectorAll("[data-skills-panorama-row]")
    ).map((row) => ({
      track: row.querySelector(".skills__row-track"),
      dir: parseFloat(row.dataset.dir || "-1"),
    })).filter((r) => r.track)

    this.onScroll = this.update.bind(this)
    window.addEventListener("scroll", this.onScroll, { passive: true })
    window.addEventListener("resize", this.onScroll, { passive: true })
    this.update()
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll)
    window.removeEventListener("resize", this.onScroll)
  }

  update() {
    const section = this.element
    const rect = section.getBoundingClientRect()
    const vh = window.innerHeight

    const distance = rect.height - vh
    if (distance <= 0) return

    // Progress 0 -> 1 as the section scrolls through the viewport.
    let progress = -rect.top / distance
    progress = Math.min(1, Math.max(0, progress))

    for (const row of this.rows) {
      const trackWidth = row.track.scrollWidth
      const parentWidth = row.track.parentElement.clientWidth
      const maxShift = Math.max(0, trackWidth - parentWidth)
      // dir -1 slides left (negative X), dir +1 slides right (positive X).
      const shift = -row.dir * progress * maxShift
      row.track.style.transform = `translate3d(${shift}px, 0, 0)`
    }
  }
}

import { Controller } from "@hotwired/stimulus"

// Premium custom cursor: a precise dot + a trailing ring that lags behind.
// Hovering interactive elements scales the ring. Fully disabled on touch
// devices and when the user prefers reduced motion (native cursor stays).
export default class extends Controller {
  static targets = ["dot", "ring"]

  connect() {
    this.reduce = window.matchMedia("(prefers-reduced-motion: reduce)").matches
    this.touch = window.matchMedia("(pointer: coarse)").matches
    if (this.reduce || this.touch) return

    this.element.classList.add("has-custom-cursor")
    this.x = window.innerWidth / 2
    this.y = window.innerHeight / 2
    this.ringX = this.x
    this.ringY = this.y
    this.hovering = false

    this.onMove = this.move.bind(this)
    this.onOver = this.over.bind(this)
    this.onOut = this.out.bind(this)
    this.onDown = () => this.ringTarget.classList.add("is-down")
    this.onUp = () => this.ringTarget.classList.remove("is-down")
    this.tick = this.render.bind(this)

    window.addEventListener("pointermove", this.onMove, { passive: true })
    document.addEventListener("pointerover", this.onOver, { passive: true })
    document.addEventListener("pointerout", this.onOut, { passive: true })
    window.addEventListener("pointerdown", this.onDown, { passive: true })
    window.addEventListener("pointerup", this.onUp, { passive: true })
    this.raf = requestAnimationFrame(this.tick)
  }

  move(e) {
    this.x = e.clientX
    this.y = e.clientY
    this.dotTarget.style.transform = `translate3d(${this.x}px, ${this.y}px, 0)`
  }

  over(e) {
    if (e.target.closest("a, button, [data-cursor='hover'], input, textarea, select, .skill-node, .skill-discipline, .skill-tech")) {
      this.hovering = true
      this.ringTarget.classList.add("is-hover")
    }
  }

  out(e) {
    if (e.target.closest("a, button, [data-cursor='hover'], input, textarea, select, .skill-node, .skill-discipline, .skill-tech")) {
      this.hovering = false
      this.ringTarget.classList.remove("is-hover")
    }
  }

  render() {
    // Ring eases toward the pointer for a trailing feel.
    this.ringX += (this.x - this.ringX) * 0.18
    this.ringY += (this.y - this.ringY) * 0.18
    this.ringTarget.style.transform = `translate3d(${this.ringX}px, ${this.ringY}px, 0)`
    this.raf = requestAnimationFrame(this.tick)
  }

  disconnect() {
    window.removeEventListener("pointermove", this.onMove)
    document.removeEventListener("pointerover", this.onOver)
    document.removeEventListener("pointerout", this.onOut)
    window.removeEventListener("pointerdown", this.onDown)
    window.removeEventListener("pointerup", this.onUp)
    if (this.raf) cancelAnimationFrame(this.raf)
    this.element.classList.remove("has-custom-cursor")
  }
}

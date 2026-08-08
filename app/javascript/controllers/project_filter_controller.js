import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["filterButton", "projectCard"]

  filter(event) {
    const filterValue = event.target.dataset.filter

    // Update active button
    this.filterButtonTargets.forEach(button => {
      button.classList.remove("active")
    })
    event.target.classList.add("active")

    // Filter projects
    this.projectCardTargets.forEach(card => {
      if (filterValue === "all") {
        card.style.display = ""
      } else {
        const category = card.dataset.projectCategory
        if (category === filterValue) {
          card.style.display = ""
        } else {
          card.style.display = "none"
        }
      }
    })
  }
}
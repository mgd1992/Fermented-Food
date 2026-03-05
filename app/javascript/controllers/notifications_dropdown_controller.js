import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "btn"]

  toggle() {
    this.menuTarget.classList.toggle("d-none")
  }

  connect() {
    this.clickOutside = (e) => {
      if (!this.element.contains(e.target)) {
        this.menuTarget.classList.add("d-none")
      }
    }
    document.addEventListener("click", this.clickOutside)
  }

  disconnect() {
    document.removeEventListener("click", this.clickOutside)
  }
}

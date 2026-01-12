import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    console.log("Navbar connected", this.menuTarget)

    window.addEventListener("resize", () => {
      this.closeMenuOnDesktop()
    })

    this.closeMenuOnDesktop()
  }

  toggle() {
    if (this.hasMenuTarget) {
      if (this.menuTarget.classList.contains("d-none")) {
        this.menuTarget.classList.remove("d-none")
        this.menuTarget.style.display = "flex"
      } else {
        this.menuTarget.classList.add("d-none")
        this.menuTarget.style.display = "none"
      }
    }
  }

  closeMenuOnDesktop() {
    if (window.innerWidth > 768 && this.hasMenuTarget) {
      this.menuTarget.classList.add("d-none")
      this.menuTarget.style.display = "none"
    }
  }
}

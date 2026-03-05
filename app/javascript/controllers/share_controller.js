import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["btn", "feedback"]
  static values = { url: String }

  copy() {
    navigator.clipboard.writeText(this.urlValue).then(() => {
      this.feedbackTarget.classList.remove("d-none")
      setTimeout(() => this.feedbackTarget.classList.add("d-none"), 2500)
    })
  }
}

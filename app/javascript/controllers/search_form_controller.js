import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "clearButton"]

  connect() {
    this.toggleButton()
  }

  search() {
    this.toggleButton()
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 400)
  }

  clear(e) {
    e.preventDefault()
    this.inputTarget.value = ""
    this.toggleButton()
    this.element.requestSubmit()
    this.inputTarget.focus()
  }

  toggleButton() {
    if (this.hasInputTarget && this.hasClearButtonTarget) {
      const isVisible = this.inputTarget.value.length > 0
      this.clearButtonTarget.classList.toggle("d-none", !isVisible)
    }
  }
}

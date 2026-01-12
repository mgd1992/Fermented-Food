import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"


export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      enableTime: false,
      dateFormat: "Y-m-d",
      altInput: true,
      altFormat: "j/m/Y"
    })
  }
}

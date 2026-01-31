import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu", "toggleBtn", "brand"];

  toggle() {
    const isOpened = this.menuTarget.classList.toggle("show");

    this.brandTarget.classList.toggle("nav-brand-hidden", isOpened);

    this.toggleBtnTarget.innerHTML = isOpened ? "✕" : "☰";
    document.body.style.overflow = isOpened ? "hidden" : "auto";
  }

  close() {
    this.menuTarget.classList.remove("show");
    this.brandTarget.classList.remove("nav-brand-hidden");
    this.toggleBtnTarget.innerHTML = "☰";
    document.body.style.overflow = "auto";
  }
}

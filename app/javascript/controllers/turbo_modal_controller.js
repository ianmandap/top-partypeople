import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  static targets = ["modal", "container"]

  // action: "turbo-modal#hideModal"
  hideModal() {
    // Remove src reference from the turbo-frame tag
    this.modalTarget.parentElement.removeAttribute("src")
    // Without this, turbo won't re-open the modal on subsequent click
    this.modalTarget.remove()
  }

  // hide modal on successful form submission
  // action: "turbo:submit-end->turbo-modal#submitEnd"
  submitEnd(e) {
    if (e.detail.success) {
      this.hideModal()
      window.location.reload(); // hacky workaround: not using Turbo Streams to update page
    }
  }

  // hide modal when clicking ESC
  // action: "keyup@window->turbo-modal#closeWithKeyboard"
  closeWithKeyboard(e) {
    if (e.code == "Escape") {
      this.hideModal()
    }
  }

  // hide modal when clicking outside of modal
  // action: "click@window->turbo-modal#closeBackground"
  closeBackground(e) {
    if (e && this.containerTarget.contains(e.target)) {
      return
    }
    this.hideModal()
  }
}
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  static targets = ["modal"]

  // action: "turbo-modal#hideModal"
  hideModal() {
    // Remove src reference from the turbo-frame tag
    this.modalTarget.parentElement.removeAttribute("src")
    // Without this, turbo won't re-open the modal on subsequent click
    this.modalTarget.remove()
  }
}
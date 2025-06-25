import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="events"
export default class extends Controller {
  static targets = ["anchor"]

  copyLink(e) {
    // Copy the event url to clipboard
    navigator.clipboard.writeText(this.anchorTarget.href);
  }
}
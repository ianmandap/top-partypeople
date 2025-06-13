import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sign-up-modal"
export default class extends Controller {
  newUserSubmit(e) {
    if (e.detail.success) {
      const eventsForm = document.getElementById('events-form')
      eventsForm.submit();
    }
  }
}

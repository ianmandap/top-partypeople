import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sign-up-modal"
export default class extends Controller {
  newUserClick(e) {
    const eventsForm = document.getElementById('events-form');

    // use Constraint Validation API
    if (eventsForm.checkValidity()) {
      // continue click event
    } else {
      e.preventDefault();
      eventsForm.reportValidity();
    }
  }

  newUserSubmit(e) {
    if (e.detail.success) {
      const eventsForm = document.getElementById('events-form');
      eventsForm.requestSubmit();
    }
  }
}

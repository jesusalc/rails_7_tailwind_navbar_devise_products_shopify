// # app/assets/javascripts/controllers/confirmation_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = { message: String }

    confirm(event) {
        if (!(window.confirm(this.messageValue))) {
            event.preventDefault()
            event.stopImmediatePropagation()
        }
    }
}
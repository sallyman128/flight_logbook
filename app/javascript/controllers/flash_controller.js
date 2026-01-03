import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    timeout: { type: Number, default: 1000 }
  }

  connect() {
    this.timer = setTimeout(() => {
      this.dismiss()
    }, this.timeoutValue)
  }

  dismiss() {
    this.element.classList.add("opacity-0", "translate-y-2")
    setTimeout(() => {
      this.element.remove()
    }, 200)
  }

  disconnect() {
    clearTimeout(this.timer)
  }
}
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "main"]

  toggle() {
    const sidebar = this.sidebarTarget
    const main = this.mainTarget

    if (sidebar.style.display === "none") {
      sidebar.style.display = "block";
    } else {
      sidebar.style.display = "none";
    }
  }
}

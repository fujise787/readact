import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["categoryId", "selectedCategory"]

  selectCategory(event) {
    this.categoryIdTarget.value = event.params.id
    this.selectedCategoryTarget.textContent = event.params.name
  }
}

// app/javascript/controllers/category_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "list", "menu", "categoryId", "selectedCategory"]
  static values  = { userCategories: Array }

  connect() {
    // 初期カテゴリを描画
    this.userCategoriesValue.forEach(c => this.addButton(c))

    // hidden_fieldとカテゴリ名を取得
    const categoryIdInput = this.categoryIdTarget
    const selectedCategorySpan = this.selectedCategoryTarget

    // 要素がない場合は何もしない
    if (!categoryIdInput || !selectedCategorySpan) return

    const currentCategoryId = categoryIdInput.value

    // hidden_fieldが空の場合、カテゴリ選択を初期表示
    if (!currentCategoryId) {
      selectedCategorySpan.textContent = "カテゴリを選択"
      return
    }

    // 一致するidのカテゴリ名のnameを表示
    const matchedCategory = this.userCategoriesValue.find(
      category => String(category.id) === String(currentCategoryId)
    )

    // 該当カテゴリがあれば名前を、なければ「カテゴリを選択」
    selectedCategorySpan.textContent = matchedCategory?.name || "カテゴリを選択"
  }

  selectCategory(event) {
    const id = event.params.categoryId
    const name = event.params.categoryName

    this.categoryIdTarget.value = id
    this.selectedCategoryTarget.textContent = name
  }

  create(event) {
    event.preventDefault()

    const name = this.inputTarget.value.trim()
    if (name === "") return
    fetch("/categories", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ category: { name } })
    })
      .then(r => r.ok ? r.json() : Promise.reject())
      .then(json => {
        this.addButton(json)          // 画面に即追加
        this.inputTarget.value = ""   // フォームクリア
      })
      .catch(_err => alert("登録に失敗しました"))
  }

  addButton({ id, name }) {
    const btn = document.createElement("button")
    btn.type      = "button"
    btn.className = "dropdown-item text-wrap"
    btn.textContent = name
    btn.dataset.action = "click->category#selectCategory"
    btn.setAttribute('data-category-category-id-param', id)
    btn.setAttribute('data-category-category-name-param', name)
    this.listTarget.appendChild(btn)
  }
}

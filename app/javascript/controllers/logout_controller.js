import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  handle(event) {
    event.preventDefault()
    
    // 確認ダイアログ
    const confirmMessage = event.currentTarget.dataset.confirm
    if (confirmMessage && !confirm(confirmMessage)) {
      return
    }
    
    // ログアウト処理
    const url = event.currentTarget.dataset.url
    const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    
    fetch(url, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': token,
        'Accept': 'text/html'
      }
    })
    .then(() => {
      window.location.href = '/'
    })
    .catch(error => {
      console.error('Error:', error)
      alert('ログアウトに失敗しました')
    })
  }
}

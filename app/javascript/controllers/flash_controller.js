import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // flash-toastクラスを全て表示
    document.querySelectorAll('.flash-toast').forEach(function(toastEl) {
      var toast = new bootstrap.Toast(toastEl);
      toast.show();
    });
  }
}

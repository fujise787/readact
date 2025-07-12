console.log("loaded!");
document.addEventListener("turbo:load", () => {
  // 表示エリア取得
  const display = document.getElementById("selected-category");
  if (!display) return;

  // 全てのカテゴリボタンにクリックリスナー
  document
    .querySelectorAll(".category-select-button")
    .forEach((btn) => {
      btn.addEventListener("click", (e) => {
        // ボタンに埋めたdata属性から名前を読み込む
        const name = e.currentTarget.dataset.categoryName;
        display.textContent = name;
      });
    });
});

document.addEventListener("turbo:load", () => {
  const input = document.getElementById("tweet-title-input");
  const status = document.getElementById("save-status");

  if (input) {
    let timeout = null;

    input.addEventListener("input", () => {
      clearTimeout(timeout);
      status.textContent = "入力中...";

      timeout = setTimeout(() => {
        const tweetId = input.dataset.tweetId;
        const newTitle = input.value;

        fetch(`/tweets/${tweetId}`, {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
          },
          body: JSON.stringify({ tweet: { title: newTitle } })
        })
          .then(response => {
            if (response.ok) {
              status.textContent = "保存されました";
            } else {
              status.textContent = "保存に失敗しました";
            }
          })
          .catch(() => {
            status.textContent = "通信エラー";
          });
      }, 1000); // 1秒間入力が止まったら保存
    });
  }
});

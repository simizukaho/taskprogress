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
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
            "Accept": "text/vnd.turbo-stream.html"
          },
          body: JSON.stringify({ tweet: { title: newTitle } }),
          credentials: 'same-origin'
        })
          .then(response => {
            if (response.ok) {
              return response.text(); 
            } else {      
              throw new Error("保存に失敗しました");
             }
          })
          .then(turboStreamHTML => {
            status.textContent = "保存されました";
          })
          .catch(err => {
            console.error(err.message);
            status.textContent = "通信エラー";
          });
      }, 1000);
    });
  }
});
document.addEventListener("turbo:load", () => {
  let timeoutMap = new Map();

  document.body.addEventListener("input", (event) => {
    const input = event.target;
    if (!input.classList.contains("task-content-input")) return;

    // 以前のtimeoutをクリア
    if (timeoutMap.has(input)) {
      clearTimeout(timeoutMap.get(input));
    }

    const form = input.closest("form");
    const formData = new FormData(form);

    const timeoutId = setTimeout(() => {
      fetch(form.action, {
        method: "PATCH",
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        },
        body: formData
      })
      .then((res) => {
        if (!res.ok) {
          console.error("保存に失敗しました");
        }
      })
      .catch((err) => {
        console.error("通信エラー", err);
      });
      timeoutMap.delete(input);
    }, 1000);

    timeoutMap.set(input, timeoutId);
  });
});

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".task-checkbox").forEach((checkbox) => {
    checkbox.addEventListener("change", () => {
      const form = checkbox.closest("form");
      const url = form.action;
      const token = document.querySelector('meta[name="csrf-token"]').content;

      fetch(url, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": token,
          "Accept": "application/json",
        },
        body: JSON.stringify({
          task: {
            done: checkbox.checked,
          },
        }),
      })
        .then((res) => {
          if (!res.ok) throw new Error("Network response was not ok");
          return res.json();
        })
        .then((data) => {
          console.log("更新成功:", data);
        })
        .catch((error) => {
          console.error("更新エラー:", error);
        });
    });
  });
});

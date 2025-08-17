document.addEventListener("turbo:load", () => {
  const btn = document.getElementById("show-new-task-form");
  const formDiv = document.getElementById("new-task-form");

  if (btn && formDiv) {
    btn.addEventListener("click", () => {
      formDiv.style.display = "block";
      btn.style.display = "none";
    });
  }
});

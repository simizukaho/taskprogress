// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./title_autosave"
import "./task_autosave"
import "./toggle_comments"
import "./task_form_toggle"


document.addEventListener("DOMContentLoaded", function() {
  const toggle = document.getElementById("toggle_password_visibility");
  const passwordField = document.getElementById("password_field");

  if (toggle && passwordField) {
    toggle.addEventListener("change", function() {
      if (this.checked) {
        passwordField.type = "text";
      } else {
        passwordField.type = "password";
      }
    });
  }
});

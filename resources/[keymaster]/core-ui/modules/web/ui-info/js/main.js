document.addEventListener("DOMContentLoaded", function () {
  const progressBar = document.querySelector(".ui-info-progress-bar");
  const progress = progressBar.querySelector(".ui-info-progress");
  const progressValue = progressBar.getAttribute("data-progress");

  progress.style.width = progressValue + "%";

  // Hide the UI by default
  const uiContainer = document.querySelector(".ui-info-container");
  uiContainer.classList.add("hide");

  window.addEventListener("message", function (event) {
    const data = event.data;
    if (data.action === "show") {
      document.querySelector(".ui-info-main-header").textContent = data.title;
      const infoContainer = document.querySelector(".ui-info-inner-container");
      infoContainer.innerHTML = `<header class="ui-info-main-header">${data.title}</header>`;
      data.info.forEach((item) => {
        infoContainer.innerHTML += `
          <div class="ui-info-info-line">
            <span class="ui-info-label">${item.title}</span>
            <span class="ui-info-value">${item.subtitle}</span>
          </div>
        `;
      });
      uiContainer.classList.remove("hide");
      uiContainer.classList.add("show");
    } else if (data.action === "hide") {
      uiContainer.classList.remove("show");
      uiContainer.classList.add("hide");
    }
  });
});

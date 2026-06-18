let notificationTimer = null;

function showNotification() {
  const container = document.querySelector(".weazel-notification-container");
  container.classList.remove("leaving");
  void container.offsetWidth;
  container.classList.add("visible");

  if (notificationTimer) {
    clearTimeout(notificationTimer);
  }

  notificationTimer = setTimeout(() => {
    container.classList.add("leaving");
    setTimeout(() => {
      container.classList.remove("visible", "leaving");
    }, 800);
  }, 10000);
}

function hideNotification() {
  const container = document.querySelector(".weazel-notification-container");
  container.classList.remove("visible");
}

document.addEventListener("keydown", (event) => {
  if (event.key.toLowerCase() === "p") {
    showNotification();
  }
});

window.addEventListener("message", function (event) {
  if (event.data.type === "showNotification") {
    const title = document.querySelector(".weazel-title");
    const description = document.querySelector(".weazel-description");
    const ticker = document.querySelector(".weazel-ticker-text");

    title.textContent = event.data.title;
    description.textContent = event.data.description;
    ticker.textContent = event.data.ticker || "WEAZEL NEWS - Breaking News";

    showNotification();
  }
});

function initTickerAnimation() {
  const ticker = document.querySelector(".weazel-ticker-text");
  ticker.style.transform = "translateX(100%)";

  setInterval(() => {
    ticker.style.transition = "transform 15s linear";
    ticker.style.transform = "translateX(-100%)";

    setTimeout(() => {
      ticker.style.transition = "none";
      ticker.style.transform = "translateX(100%)";
    }, 15000);
  }, 15100);
}

document.addEventListener("DOMContentLoaded", initTickerAnimation);

import { createOptions } from "./createOptions.js";

const optionsWrapper = document.getElementById("options-wrapper");
const body = document.body;
const eyeContainer = document.getElementById('eye')

window.addEventListener("message", (event) => {
  optionsWrapper.innerHTML = "";

  switch (event.data.event) {
    case "visible": {
      body.style.opacity = event.data.state ? 1 : 0;
      return eyeContainer.classList.remove("eye-active");
    }

    case "leftTarget": {
      return eyeContainer.classList.remove("eye-active");
    }

    case "setTarget": {
      eyeContainer.classList.add("eye-active")

      if (event.data.options) {
        for (const type in event.data.options) {
          event.data.options[type].forEach((data, id) => {
            createOptions(type, data, id + 1);
          });
        }
      }

      if (event.data.zones) {
        for (let i = 0; i < event.data.zones.length; i++) {
          event.data.zones[i].forEach((data, id) => {
            createOptions("zones", data, id + 1, i + 1);
          });
        }
      }
    }
  }
});
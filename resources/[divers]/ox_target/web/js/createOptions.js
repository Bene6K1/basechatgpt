import { fetchNui } from "./fetchNui.js";

const optionsWrapper = document.getElementById("options-wrapper");

function onClick() {
  this.style.pointerEvents = "none";
  fetchNui("select", [this.targetType, this.targetId, this.zoneId]);
  setTimeout(() => (this.style.pointerEvents = "auto"), 100);
}

export function createOptions(type, data, id, zoneId) {
  if (data.hide) return;

  const option = document.createElement("div");
  const iconElement = `<i class="fa-fw ${data.icon} option-icon" ${
    data.iconColor ? `style = color:${data.iconColor} !important` : null
  }"></i>`;
  
  option.innerHTML = `<div class="option-id"><span>${optionsWrapper.childElementCount + 1}</span></div><span class="option-label">${data.label}</span>${iconElement}`
  option.className = "option-container";
  option.targetType = type;
  option.targetId = id;
  option.zoneId = zoneId;

  option.addEventListener("click", onClick);
  optionsWrapper.appendChild(option);
}
const deathscreen_container = document.getElementById("deathscreen_container");

let deathscreen_open = false;
let deathscreen_time = 360;
let deathscreen_timer_interval = null;
let deathscreen_call = false;
let isStaffMember = false;

let spamNB = 0;

let Config = {
  DefaultRespawnTime: 360,
  NotificationDuration: 5000,
  Controls: {
    CallMedic: "E",
    Respawn: "X",
  },
  DefaultMessages: {
    MedicCalled: "Les secours ont été contactés. Veuillez patienter.",
    MedicEnRoute: "Les secours sont actuellement en route !",
    TimerNotFinished: "Vous devez attendre la fin du timer avant de respawn.",
  },
};

let ConfigUI = {};

const notificationContainer = document.createElement("div");
notificationContainer.className = "notification-container";
document.body.appendChild(notificationContainer);

addEventListener("message", function (e) {
  const data = e.data;

  switch (data.type) {
    case "update:config":
      Config = data.config || Config;
      ConfigUI = data.configUI || ConfigUI;
      applyUIConfig();
      break;

    case "deathscreen:open":
      deathscreen_call = false;
      spamNB = 0;
      isStaffMember = data.isStaff || false;
      deathscreen_show();
      break;

    case "deathscreen:close":
      deathscreen_hide();
      document.getElementById("deathscreen_emsAreIncoming").style.display =
        "none";
      break;

    case "medicUnit:show":
      document.getElementById("deathscreen_emsAreIncoming").style.display =
        "block";
      break;

    case "medicUnit:hide":
      document.getElementById("deathscreen_emsAreIncoming").style.display =
        "none";
      break;

    case "notified":
      const text = document.getElementById("deathscreen_emsAreIncoming");
      text.innerHTML =
        '<span class="green">Les secours</span> sont actuellement en route !';
      break;


    case "update:timer":
      if (data.time !== undefined) {
        deathscreen_time = data.time * 60;
      }
      break;

    default:
      break;
  }
});

addEventListener("keydown", function (e) {
  if (!deathscreen_open) return;

  if (e.key === "e" || e.key === "E" || e.keyCode === 69) {
    deathscreen_call_button("call");
  } else if (e.key === "x" || e.key === "X" || e.keyCode === 88) {
    deathscreen_call_button("respawn");
  } else if ((e.key === "s" || e.key === "S" || e.keyCode === 83) && isStaffMember) {
    deathscreen_call_button("staffRevive");
  }
});

window.SendLUAMessage = (name, data = {}) => {
  const resourceName = GetParentResourceName();

  fetch(`https://${resourceName}/${name}`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  }).catch((error) => {
    return;
  });
};

deathscreen_show = () => {
  if (deathscreen_open) return;

  deathscreen_time = Config.DefaultRespawnTime || 360;
  document.getElementById("deathscreen_call").classList.remove("disabled");
  deathscreen_open = true;
  deathscreen_container.classList.remove("hide");
  
  const staffButton = document.getElementById("deathscreen_staff");
  if (staffButton) {
    staffButton.style.display = isStaffMember ? "flex" : "none";
  }
  
  deathscreen_timer();
};

deathscreen_hide = () => {
  if (!deathscreen_open) return;

  deathscreen_open = false;

  setTimeout(() => {
    deathscreen_container.classList.add("hide");
  }, 300);

  clearInterval(deathscreen_timer_interval);
};

deathscreen_timer = () => {
  const timerMinutesTens = document.getElementById("deathscreen_minutes_tens");
  const timerMinutesUnits = document.getElementById(
    "deathscreen_minutes_units"
  );
  const timerSecondsTens = document.getElementById("deathscreen_seconds_tens");
  const timerSecondsUnits = document.getElementById(
    "deathscreen_seconds_units"
  );

  let previousTime = { minutes: 0, seconds: 0 };

  deathscreen_timer_interval = setInterval(() => {
    if (deathscreen_time <= 0) {
      clearInterval(deathscreen_timer_interval);
      return;
    }

    deathscreen_time--;

    const minutes = Math.floor(deathscreen_time / 60);
    const seconds = deathscreen_time % 60;

    const updateElement = (element, newValue, previousValue) => {
      if (newValue !== previousValue) {
        element.classList.remove("animate-in", "animate-out");
        element.classList.add("animate-out");

        setTimeout(() => {
          element.innerText = newValue;
          element.classList.remove("animate-out");
          element.classList.add("animate-in");
        }, 300);
      }
    };

    updateElement(
      timerMinutesTens,
      Math.floor(minutes / 10),
      Math.floor(previousTime.minutes / 10)
    );
    updateElement(timerMinutesUnits, minutes % 10, previousTime.minutes % 10);
    updateElement(
      timerSecondsTens,
      Math.floor(seconds / 10),
      Math.floor(previousTime.seconds / 10)
    );
    updateElement(timerSecondsUnits, seconds % 10, previousTime.seconds % 10);

    previousTime.minutes = minutes;
    previousTime.seconds = seconds;
  }, 1000);
};

function showNotification(message) {
  const notification = document.createElement("div");
  notification.className = "deathscreen-notification";
  
  const background = document.createElement("div");
  background.className = "notification-background";
  notification.appendChild(background);
  
  const text = document.createElement("span");
  text.textContent = message;
  text.style.position = "relative";
  text.style.zIndex = "2";
  notification.appendChild(text);

  notificationContainer.appendChild(notification);

  setTimeout(() => {
    notification.classList.add("show");
  }, 10);

  setTimeout(() => {
    notification.classList.remove("show");
    setTimeout(() => {
      notificationContainer.removeChild(notification);
    }, 300);
  }, Config.NotificationDuration || 5000);
}

function deathscreen_call_button(type) {
  if (!deathscreen_open) return;

  if (type === "call") {
    if (deathscreen_call) return;

    deathscreen_call = true;

    const callButton = document.getElementById("deathscreen_call");
    if (callButton) callButton.classList.add("disabled");

    showNotification(
      Config.DefaultMessages.MedicCalled ||
        "Les secours ont été contactés. Veuillez patienter."
    );

    window.SendLUAMessage("deathscreen:call");
  } else if (type === "respawn") {
    if (deathscreen_time > 0) {
      showNotification(
        Config.DefaultMessages.TimerNotFinished ||
          "Vous devez attendre la fin du timer avant de respawn."
      );
      return;
    }

    window.SendLUAMessage("deathscreen:end");
    window.SendLUAMessage("deathscreen:respawn");
  } else if (type === "staffRevive") {
    if (!isStaffMember) return;

    showNotification("Revive staff activé...");
    window.SendLUAMessage("deathscreen:end");
    window.SendLUAMessage("deathscreen:staffRevive");
  }
}


function applyUIConfig() {
  if (!ConfigUI) return;

  if (ConfigUI.Texts) {
    const titleElement = document.querySelector(".deathscreen-text");
    const descElement = document.querySelector(".deatnscreen-desc");

    if (titleElement) titleElement.textContent = ConfigUI.Texts.Title;
    if (descElement) descElement.textContent = ConfigUI.Texts.Description;

    const callText = document.querySelector(
      "#deathscreen_call .deathscreen-action-text"
    );
    if (callText) callText.textContent = ConfigUI.Texts.CallMedic;

    const respawnText = document.querySelector(
      "#deathscreen_respawn .deathscreen-action-text"
    );
    if (respawnText) respawnText.textContent = ConfigUI.Texts.Respawn;

    const staffText = document.querySelector(
      "#deathscreen_staff .deathscreen-action-text"
    );
    if (staffText) staffText.textContent = ConfigUI.Texts.StaffRevive;
  }

  if (Config.Controls) {
    const callKey = document.querySelector(
      "#deathscreen_call .deathscreen-action-letter"
    );
    if (callKey) callKey.textContent = Config.Controls.CallMedic;

    const respawnKey = document.querySelector(
      "#deathscreen_respawn .deathscreen-action-letter"
    );
    if (respawnKey) respawnKey.textContent = Config.Controls.Respawn;

    const staffKey = document.querySelector(
      "#deathscreen_staff .deathscreen-action-letter"
    );
    if (staffKey && Config.StaffRevive && Config.StaffRevive.Key) {
      staffKey.textContent = Config.StaffRevive.Key;
    }
  }

  const dynamicStyles = generateDynamicStyles();
  const styleElement = document.getElementById("dynamic-styles");
  if (styleElement) styleElement.innerHTML = dynamicStyles;

  toggleVisualElements();
}

function generateDynamicStyles() {
  if (!ConfigUI) return "";

  let styles = "";

  if (ConfigUI.RedGradient) {
    const inner = ConfigUI.RedGradient.InnerRGB;
    const outer = ConfigUI.RedGradient.OuterRGB;

    styles += `
      .deathscreen-red-gradient {
        background: radial-gradient(
          circle at center,
          rgba(${inner[0]}, ${inner[1]}, ${inner[2]}, ${ConfigUI.RedGradient.CenterOpacity}) 0%,
          rgba(${inner[0]}, ${inner[1]}, ${inner[2]}, ${ConfigUI.RedGradient.CenterOpacity}) 40%,
          rgba(${outer[0]}, ${outer[1]}, ${outer[2]}, ${ConfigUI.RedGradient.EdgeOpacity}) 80%,
          rgba(${outer[0]}, ${outer[1]}, ${outer[2]}, ${ConfigUI.RedGradient.EdgeOpacity}) 100%
        );
      }
    `;
  }

  if (ConfigUI.Background) {
    const bg = ConfigUI.Background;
    styles += `
      .deathscreen-bg-fade {
        background: rgba(${bg.RGB[0]}, ${bg.RGB[1]}, ${bg.RGB[2]}, ${bg.Opacity});
      }
    `;
  }

  if (ConfigUI.Font) {
    styles += `
      .deathscreen-text {
        font-family: ${ConfigUI.Font.Family || "'Manrope', sans-serif"};
        font-size: ${ConfigUI.Font.TitleSize || "48px"};
        font-weight: ${ConfigUI.Font.TitleWeight || "800"};
        color: ${ConfigUI.Font.TitleColor || "#ffffff"};
        letter-spacing: ${ConfigUI.Font.TitleLetterSpacing || "2px"};
      }
      .deatnscreen-desc {
        font-size: ${ConfigUI.Font.DescriptionSize || "16px"};
        color: ${ConfigUI.Font.DescriptionColor || "rgba(255, 255, 255, 0.8)"};
      }
      .deathscreen-action-text {
        font-size: ${ConfigUI.Font.ButtonTextSize || "14px"};
      }
      .deathscreen-action-letter {
        font-size: ${ConfigUI.Font.ButtonLetterSize || "14px"};
      }
    `;
  }

  if (ConfigUI.Timer) {
    styles += `
      .deathscreen-timer-number-text {
        font-size: ${ConfigUI.Timer.FontSize || "80px"};
        font-weight: ${ConfigUI.Timer.FontWeight || "700"};
        color: ${ConfigUI.Timer.Color || "#ffffff"};
      }
      .deathscreen-timer-separator {
        font-size: ${ConfigUI.Timer.SeparatorFontSize || "80px"};
        color: ${ConfigUI.Timer.SeparatorColor || "#4fb5e9"};
      }
    `;
  }

  if (ConfigUI.Buttons) {
    styles += `
      .deathscreen-action {
        background: ${ConfigUI.Buttons.Background || "hsla(240, 5%, 4%, 0.705)"};
        width: ${ConfigUI.Buttons.Width || "250px"};
        padding: ${ConfigUI.Buttons.Padding || "12px 20px"};
      }
      .deathscreen-action:hover {
        background: ${ConfigUI.Buttons.BackgroundHover || "hsla(240, 5%, 6%, 0.805)"};
      }
      .deathscreen-buttons-row {
        gap: ${ConfigUI.Buttons.Gap || "2rem"};
      }
    `;
  }

  if (ConfigUI.SkullImage) {
    const skullImg = document.querySelector(".deathscreen-skull img");
    if (skullImg && ConfigUI.SkullImage.Enabled !== false) {
      skullImg.style.height = ConfigUI.SkullImage.Height || "150px";
      skullImg.style.filter = ConfigUI.SkullImage.Filter || "grayscale(100%) brightness(2) opacity(0.7)";
    } else if (skullImg && ConfigUI.SkullImage.Enabled === false) {
      document.querySelector(".deathscreen-skull").style.display = "none";
    }
    if (ConfigUI.SkullImage.MarginBottom) {
      styles += `
        .deathscreen-skull {
          margin-bottom: ${ConfigUI.SkullImage.MarginBottom};
        }
      `;
    }
  }

  return styles;
}

function toggleVisualElements() {
  if (!ConfigUI) return;

  const redGradient = document.querySelector(".deathscreen-red-gradient");
  const bgFade = document.querySelector(".deathscreen-bg-fade");
  const skullContainer = document.querySelector(".deathscreen-skull");

  if (redGradient) {
    redGradient.style.display = ConfigUI.EnableRedGradient !== false ? "block" : "none";
  }

  if (bgFade) {
    bgFade.style.display = ConfigUI.EnableBackgroundFade !== false ? "block" : "none";
  }

  if (skullContainer) {
    skullContainer.style.display = ConfigUI.SkullImage && ConfigUI.SkullImage.Enabled !== false ? "flex" : "none";
  }
}

document.addEventListener("DOMContentLoaded", function () {
  const callButton = document.getElementById("deathscreen_call");
  if (callButton) callButton.onclick = () => deathscreen_call_button("call");

  const respawnButton = document.getElementById("deathscreen_respawn");
  if (respawnButton)
    respawnButton.onclick = () => deathscreen_call_button("respawn");

  const staffButton = document.getElementById("deathscreen_staff");
  if (staffButton)
    staffButton.onclick = () => deathscreen_call_button("staffRevive");

  setTimeout(() => {
    const canvas = document.getElementById("gameview-canvas");
    if (canvas && window.MainRender) {
      window.MainRender.renderToTarget(canvas);
    }
  }, 2000);
});

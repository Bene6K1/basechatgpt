/* ============================================
   NEVA HUD - Combined JavaScript
   Server Info (top-right) + Status (bottom-left)
   ============================================ */

// ============================================
// SERVER INFO HUD CONFIG & FUNCTIONS
// ============================================
let serverConfig = {
  serverName: 'NEVA Ultimate',
  discordText: '.GG/NEVA-FIVEM',
  textRotationInterval: 5000
};

let rotationInterval = null;

function updateDiscordText(newText) {
  const discordTextEl = document.getElementById('discord-text');
  if (discordTextEl) {
    discordTextEl.textContent = newText;
  }
}

function updateDateText() {
  const dateText = document.querySelector('.date-text');
  if (!dateText) return;

  const now = new Date();
  const day = String(now.getDate()).padStart(2, '0');
  const month = String(now.getMonth() + 1).padStart(2, '0');
  const year = now.getFullYear();

  dateText.textContent = `${day}/${month}/${year}`;
}

function startDiscordAnimation() {
  if (rotationInterval) {
    clearInterval(rotationInterval);
  }

  const discordText = document.querySelector('.discord-text');
  const idText = document.querySelector('.id-text');
  const dateText = document.querySelector('.date-text');

  if (!discordText || !idText || !dateText) return;

  let currentIndex = 0;
  const texts = [discordText, idText, dateText];

  function showNext() {
    texts.forEach(el => el.classList.remove('active'));
    currentIndex = (currentIndex + 1) % texts.length;
    texts[currentIndex].classList.add('active');
  }

  rotationInterval = setInterval(showNext, serverConfig.textRotationInterval);
  texts[0].classList.add('active');
}

function updateServerName(serverName) {
  const serverNameEl = document.getElementById('server-name');
  if (serverNameEl) {
    serverNameEl.textContent = serverName;
  }
}

function hideServerHUD() {
  const hudFrame = document.querySelector('.hud-frame');
  if (hudFrame) {
    hudFrame.style.visibility = 'hidden';
    hudFrame.style.opacity = '0';
  }
}

function showServerHUD() {
  const hudFrame = document.querySelector('.hud-frame');
  if (hudFrame) {
    hudFrame.style.visibility = 'visible';
    hudFrame.style.opacity = '1';
  }
}

// ============================================
// STATUS HUD CONFIG & FUNCTIONS
// ============================================
let hudConfig = {
  position: { bottom: "1.25%", left: "16%" },
  colors: {
    thirst: "rgba(91, 173, 220, 0.85)",
    hunger: "rgba(242, 162, 101, 0.85)",
    voice: {
      default: "rgba(255, 255, 255, 0.95)",
      whisper: "rgba(91, 173, 220, 0.95)",
      normal: "rgba(255, 255, 255, 0.95)",
      shout: "rgba(255, 99, 71, 0.95)",
    },
    icons: {
      thirst: "rgba(150, 210, 255, 0.95)",
      hunger: "rgba(255, 200, 150, 0.95)",
      voice: "rgba(255, 255, 255, 0.95)",
    },
    background: "rgba(10, 10, 10, 0.35)",
  },
  animations: {
    fadeInTime: 80,
    fadeOutTime: 80,
  },
  circle: {
    strokeWidth: "0.32vw",
    radius: "42",
  },
  voiceTypes: {
    regular: "microphone",
    radio: "tower-broadcast",
    phone: "phone",
  },
};

const voiceElement = document.getElementById("voice");
let voiceTimeout = null;

function applyConfig() {
  $("#status").css({
    bottom: hudConfig.position.bottom,
    left: hudConfig.position.left,
  });

  $(".status-circle").css({
    "stroke-width": hudConfig.circle.strokeWidth,
    fill: hudConfig.colors.background,
  });

  const Colors = JSON.parse(localStorage.getItem("hud_colors")) || {};

  if (!Colors.voice)
    $("#voice circle").css("stroke", hudConfig.colors.voice.default);

  $("#thirst .icon-container i").css("color", hudConfig.colors.icons.thirst);
  $("#hunger .icon-container i").css("color", hudConfig.colors.icons.hunger);
  $("#voice .icon-container i").css("color", hudConfig.colors.icons.voice);

  document.documentElement.style.setProperty(
    "--fade-in-time",
    hudConfig.animations.fadeInTime + "ms"
  );
  document.documentElement.style.setProperty(
    "--fade-out-time",
    hudConfig.animations.fadeOutTime + "ms"
  );
}

setProgress = (element, percent) => {
  const Circumference = element.prop("r").baseVal.value * 2 * Math.PI;
  const Offset = Circumference - (percent / 100) * Circumference;

  element.css({
    strokeDasharray: `${Circumference} ${Circumference}`,
    strokeDashoffset: Offset,
  });

  const previousValue = element.data("previousValue") || 100;
  if (Math.abs(previousValue - percent) > 10) {
    element.parent().parent().addClass("pulse");
    setTimeout(() => {
      element.parent().parent().removeClass("pulse");
    }, 400);
  }
  element.data("previousValue", percent);
};

function setVoiceIcon(voiceType) {
  const type = voiceType || "regular";

  let iconName = "microphone";

  if (hudConfig.voiceTypes && hudConfig.voiceTypes[type]) {
    iconName = hudConfig.voiceTypes[type];
  }

  const iconElement = $("#voice .icon-container i");
  iconElement.attr("class", "fas fa-" + iconName);

  $("#voice").removeClass(
    "voice-type-regular voice-type-radio voice-type-phone"
  );
  $("#voice").addClass("voice-type-" + type);

  let iconColor = hudConfig.colors.icons.voice;

  if (hudConfig.colors.icons[type]) {
    iconColor = hudConfig.colors.icons[type];
  }

  iconElement.css("color", iconColor);

  return true;
}

function capitalizeFirstLetter(string) {
  return string.charAt(0).toUpperCase() + string.slice(1);
}

// ============================================
// INITIALIZATION
// ============================================
window.addEventListener('DOMContentLoaded', function() {
  // Server HUD init
  updateDateText();
  startDiscordAnimation();
  showServerHUD();
  setInterval(updateDateText, 60000);

  // Status HUD init
  const Colors = JSON.parse(localStorage.getItem("hud_colors"));
  let defaultColors = {
    thirst: "rgba(91, 173, 220, 0.85)",
    hunger: "rgba(242, 162, 101, 0.85)",
    voice: "rgba(255, 255, 255, 0.85)",
  };

  if (!Colors) {
    localStorage.setItem("hud_colors", JSON.stringify(defaultColors));
  }

  $.each(defaultColors, (key, value) => {
    const circle = $(`#${key} circle`);
    if (circle.length) {
      setProgress(circle, 100);
      if (key !== 'thirst' && key !== 'hunger' && (!Colors || !Colors[key])) {
        circle.css("stroke", value);
      }
    }
  });

  $.each(defaultColors, (key, value) => {
    if (key !== 'thirst' && key !== 'hunger' && (!Colors || !Colors[key])) {
      $(`#${key} circle`).css("stroke", value);
    }
  });

  // Load saved colors
  {
    const Colors = JSON.parse(localStorage.getItem("hud_colors"));
    if (Colors) {
      $.each(Colors, (key, value) => {
        if (key !== 'thirst' && key !== 'hunger') {
          $(`#${key} circle`).css("stroke", value);
        }
      });
    }
  }
});

// ============================================
// NUI MESSAGE HANDLER
// ============================================
window.addEventListener('message', (event) => {
  const data = event.data;

  // Handle action-based messages (unified for both HUDs)
  switch (data.action) {
    case 'showHUD':
      showServerHUD();
      $("#status").fadeIn(400);
      return;
    case 'hideHUD':
      hideServerHUD();
      $("#status").fadeOut(400);
      return;
    case 'toggleVisibility':
      if (data.visible) {
        showServerHUD();
        $("#status").fadeIn(400);
      } else {
        hideServerHUD();
        $("#status").fadeOut(400);
      }
      return;
    case 'initConfig':
      hudConfig = data.config;
      applyConfig();
      return;
    case 'update':
      $.each(data.data, (key, value) => {
        const K = $(`#${key} circle`);
        if (K.length) {
          setProgress(K, value);
        }
      });
      return;
    case 'panel':
      $("#panel").toggle();
      return;
    case 'voiceUpdate':
      $("#voice").removeClass("voice-whisper voice-normal voice-shout");
      $("#voice").addClass("voice-" + data.range);

      setVoiceIcon(data.voiceType);

      setProgress($("#voice circle"), data.percent);

      if (data.voiceType === "radio") {
        const radioIconColor =
          hudConfig.colors.icons.radioNormal || hudConfig.colors.icons.radio;
        $("#voice .icon-container i").css("color", radioIconColor);
      } else if (data.voiceType === "phone") {
        const phoneIconColor = hudConfig.colors.icons.phone;
        if (phoneIconColor) {
          $("#voice .icon-container i").css("color", phoneIconColor);
        }
      }

      if (data.talking) {
        $("#voice").addClass("voice-active").show();
      } else {
        $("#voice").removeClass("voice-active");
        if (!$("#voice").hasClass("ptt-active")) {
          $("#voice").hide();
        }
      }
      return;
    case 'pttState':
      if (data.active) {
        if (voiceTimeout) {
          clearTimeout(voiceTimeout);
          voiceTimeout = null;
        }

        voiceElement.style.display = "block";
        voiceElement.classList.remove("hide-voice");
        voiceElement.classList.add("show-voice");

        setVoiceIcon(data.voiceType);

        requestAnimationFrame(() => {
          $("#voice")
            .removeClass("voice-whisper voice-normal voice-shout")
            .addClass("voice-" + data.range);

          if (data.voiceType === "radio") {
            const radioIconColor =
              hudConfig.colors.icons.radioNormal ||
              hudConfig.colors.icons.radio;
            $("#voice .icon-container i").css("color", radioIconColor);
          } else if (data.voiceType === "phone") {
            const phoneIconColor = hudConfig.colors.icons.phone;
            if (phoneIconColor) {
              $("#voice .icon-container i").css("color", phoneIconColor);
            }
          }

          setProgress($("#voice circle"), data.percent);
        });
      } else {
        voiceElement.classList.remove("show-voice");
        voiceElement.classList.add("hide-voice");

        voiceTimeout = setTimeout(() => {
          voiceElement.style.display = "none";
          voiceTimeout = null;
        }, hudConfig.animations.fadeOutTime + 5);
      }
      return;
    case 'inCar':
      $("#status").css({
        bottom: "1.25%",
        left: "16%",
      });
      return;
  }

  // Handle type-based messages (server HUD)
  if (data.type === 'setConfig') {
    if (data.serverName) {
      serverConfig.serverName = data.serverName;
      updateServerName(data.serverName);
    }
    if (data.discordText) {
      serverConfig.discordText = data.discordText;
      updateDiscordText(data.discordText);
    }
    if (data.textRotationInterval) {
      serverConfig.textRotationInterval = data.textRotationInterval;
      startDiscordAnimation();
    }
  } else if (data.type === 'updatePlayerId') {
    const idText = document.querySelector('.id-text');
    if (idText) {
      idText.textContent = 'ID JOUEUR: ' + (data.player_id || 0);
    }
  } else if (data.type === 'showHUD') {
    showServerHUD();
    $("#status").fadeIn(400);
  } else if (data.type === 'hideHUD') {
    hideServerHUD();
    $("#status").fadeOut(400);
  }
});

// ============================================
// COLOR PICKER
// ============================================
let colorPicker = new iro.ColorPicker("#picker", {
  borderWidth: 1,
  borderColor: "#7B68EE",
  layoutDirection: "horizontal",
  layout: [
    {
      component: iro.ui.Box,
    },
    {
      component: iro.ui.Slider,
      options: {
        sliderType: "hue",
      },
    },
  ],
});

colorPicker.on("color:change", (color) => {
  const Hex = color.hexString;
  const Selected = $("input[name=color]:checked").val();

  if (Selected && Selected.length) {
    if (Selected !== 'thirst' && Selected !== 'hunger') {
      $(`#${Selected} circle`).css("stroke", Hex);

      const Colors = JSON.parse(localStorage.getItem("hud_colors"));
      let table = Colors ? Colors : JSON.parse("{}");
      table[Selected] = Hex;
      localStorage.setItem("hud_colors", JSON.stringify(table));
    }
  }
});

document.addEventListener('DOMContentLoaded', function () {
  let currentRenameButton = null;
  let locales = null;

  function hideElement(element) {
    if (element) {
      element.style.display = 'none';
    }
  }

  function showElement(element, displayType = "flex") {
    if (element) {
      element.style.display = displayType;
    }
  }

  function displayVehicleList(vehicles, impoundPrice, displayMode) {
    const vehicleList = document.getElementById("vehicle-list");
    const vehicleTemplate = document.getElementById('vehicle-template');
    const garageIcon = document.getElementById('garage-icon');
    const garageText = document.getElementById("garage-text");

    vehicleList.innerHTML = '' + vehicleTemplate.outerHTML;
    while (vehicleList.firstChild) {
      vehicleList.removeChild(vehicleList.firstChild);
    }

    garageIcon.classList.remove(
      "garage-menu-header-title-impound",
      "garage-menu-header-title-retrieved",
      "garage-menu-header-title-garage"
    );

    if (impoundPrice > 0) {
      garageIcon.classList.add("garage-menu-header-title-impound");
      garageText.textContent = "IMPOUND";
    } else {
      garageIcon.classList.add("garage-menu-header-title-garage");
      garageText.textContent = "GARAGE";
    }

    vehicles.forEach(vehicle => {
      const vehicleItem = vehicleTemplate.content.cloneNode(true);

      vehicleItem.querySelector(".statistic-button").textContent = locales.statistic;
      vehicleItem.querySelector(".locate-button").textContent = locales.locate;
      vehicleItem.querySelector(".rename-button").textContent = locales.rename;
      vehicleItem.querySelector(".garage-menu-vehicle-list-item-button-impound-text").textContent = locales.impound;

      vehicleItem.querySelector(".garage-menu-vehicle-list-item-name").textContent = vehicle.name;

      if (displayMode === 0) {
        vehicleItem.querySelector(".garage-menu-vehicle-list-item-id").textContent = vehicle.plate;
      } else {
        vehicleItem.querySelector(".garage-menu-vehicle-list-item-id").textContent = "ID " + vehicle.id;
      }

      vehicleItem.querySelector(".vehicle-item-plate").textContent = vehicle.plate;

      const renameButton = vehicleItem.querySelector("#rename");
      const statisticButton = vehicleItem.querySelector("#statistic");
      const locateButton = vehicleItem.querySelector("#locate");
      const getButton = vehicleItem.querySelector(".garage-menu-vehicle-list-item-button-get");
      const getButtonText = vehicleItem.querySelector('.garage-menu-vehicle-list-item-button-get-text');

      if (impoundPrice > 0) {
        getButtonText.textContent = impoundPrice + '$';
      } else {
        getButtonText.textContent = locales.get;
      }

      const impoundButton = vehicleItem.querySelector(".garage-menu-vehicle-list-item-button-impound");

      hideElement(renameButton);
      hideElement(statisticButton);
      hideElement(getButton);
      hideElement(locateButton);
      hideElement(impoundButton);

      if (vehicle.status == 1) {
        if (impoundPrice == 0) {
          showElement(renameButton);
          showElement(locateButton);
          showElement(statisticButton);
        }
        showElement(impoundButton);
      } else {
        showElement(renameButton);
        showElement(statisticButton);
        showElement(getButton);
      }

      vehicleItem.querySelector(".garage-menu-vehicle-list-item").addEventListener("mouseenter", function () {
        axios.post('https://' + GetParentResourceName() + '/hoverVehicle', {
          vehicle: vehicle.name,
          plate: vehicle.plate
        });
      });

      getButton.addEventListener('click', function () {
        axios.post('https://' + GetParentResourceName() + "/getVehicle", {
          vehicle: vehicle.name,
          plate: vehicle.plate,
          price: impoundPrice
        });
      });

      impoundButton.addEventListener('click', function () {
        axios.post("https://" + GetParentResourceName() + "/impoundVehicle", {
          vehicle: vehicle.name
        });
      });

      locateButton.addEventListener("click", function () {
        axios.post("https://" + GetParentResourceName() + "/locateVehicle", {
          vehicle: vehicle.name,
          plate: vehicle.plate
        });
      });

      renameButton.addEventListener("click", function () {
        if (currentRenameButton && currentRenameButton !== renameButton) {
          const prevIcon = currentRenameButton.querySelector('i');
          const prevText = currentRenameButton.querySelector(".rename-button");
          const prevInput = currentRenameButton.querySelector("#rename-input");
          const prevEnterIcon = currentRenameButton.querySelector("#enter-icon");
          
          showElement(prevIcon);
          showElement(prevText);
          hideElement(prevInput);
          hideElement(prevEnterIcon);
        }

        const icon = renameButton.querySelector('i');
        const text = renameButton.querySelector(".rename-button");
        const input = renameButton.querySelector("#rename-input");
        const enterIcon = renameButton.querySelector("#enter-icon");

        hideElement(icon);
        hideElement(text);
        showElement(input);
        showElement(enterIcon);

        currentRenameButton = renameButton;

        input.onkeydown = function (event) {
          if (event.key === "Enter") {
            const newName = input.value.trim();
            if (newName) {
              axios.post('https://' + GetParentResourceName() + '/renameVehicle', {
                vehicle: vehicle.name,
                plate: vehicle.plate,
                newName: newName
              });

              input.value = '';

              const nameElement = renameButton.closest(".garage-menu-vehicle-list-item")
                .querySelector(".garage-menu-vehicle-list-item-name");
              if (nameElement) {
                nameElement.textContent = newName;
              }

              hideElement(input);
              hideElement(enterIcon);
              showElement(icon);
              showElement(text);
            }
          }
        };
      });

      statisticButton.addEventListener('click', function () {
        axios.post("https://" + GetParentResourceName() + "/showStatistic", {
          vehicle: vehicle.name,
          plate: vehicle.plate
        });
      });

      vehicleList.appendChild(vehicleItem);
    });
  }

  const existingVehicleItems = document.querySelectorAll(".garage-menu-vehicle-list-item");
  existingVehicleItems.forEach(item => {
    item.addEventListener("mouseenter", function () {
      axios.post("https://" + GetParentResourceName() + "/hoverVehicle", {
        vehicle: item.querySelector(".garage-menu-vehicle-list-item-name").textContent
      });
    });

    item.addEventListener("mouseleave", function (event) {
      if (!item.contains(event.relatedTarget)) {
        axios.post("https://" + GetParentResourceName() + "/hoverVehicleEnd");
      }
    });
  });

  window.addEventListener("message", function (event) {
    const data = event.data;

    switch (data.type) {
      case "open":
        if (data.locales) {
          updateLocales(data.locales);
          locales = data.locales;
        }
        showElement(document.getElementById('garage'));
        hideElement(document.getElementById('vehicle-spec'));
        if (data.vehicles) {
          displayVehicleList(data.vehicles, data.price, data.information);
        }
        break;

      case "close":
        hideElement(document.getElementById("garage"));
        hideElement(document.getElementById('vehicle-spec'));
        break;

      case 'updateSpecs':
        const speedBar = document.getElementById("speed");
        const accelerationBar = document.getElementById("acceleration");
        const brakeBar = document.getElementById("brake");
        const tractionBar = document.getElementById("traction");

        if (speedBar) {
          speedBar.style.width = data.specs.maxSpeed + '%';
        }
        if (accelerationBar) {
          accelerationBar.style.width = data.specs.acceleration + '%';
        }
        if (brakeBar) {
          brakeBar.style.width = data.specs.brake + '%';
        }
        if (tractionBar) {
          tractionBar.style.width = data.specs.traction + '%';
        }

        const specsPanel = document.getElementById('vehicle-spec');
        showElement(specsPanel);
        break;
    }
  });

  window.addEventListener("click", function (event) {
    if (event.target.id === "close-menu") {
      hideElement(document.getElementById("garage"));
      axios.post("https://" + GetParentResourceName() + "/closeMenu", {});
    }
  });

  function updateLocales(translations) {
    const elementMap = {
      'garage': 'garage-text',
      'vehicle-gestion': "vehicle-gestion",
      'vehicle-list': 'vehicle-list',
      'speed': 'speed-text',
      'acceleration': "acceleration-text",
      'brake': "brake-text",
      'traction': 'traction-text'
    };

    Object.keys(elementMap).forEach(key => {
      let element = document.getElementById(elementMap[key]);
      if (element) {
        element.textContent = translations[key];
      }
    });
  }
});
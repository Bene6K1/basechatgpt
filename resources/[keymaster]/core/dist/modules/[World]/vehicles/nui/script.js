let currentVehicles = [];
let currentLocales = {};
let currentConfig = {};

function hideElement(element) {
    if (element) element.style.display = 'none';
}

function showElement(element, displayType = 'flex') {
    if (element) element.style.display = displayType;
}

function sendCallback(endpoint, data) {
    fetch(`https://${GetParentResourceName()}/${endpoint}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    });
}

function buildVehicleList(vehicles, impoundPrice = 0, informationType = 0) {
    const container = document.getElementById('vehicle-list');
    const template = document.getElementById('vehicle-template');
    const garageIcon = document.getElementById('garage-icon');
    const garageText = document.getElementById('garage-text');

    while (container.firstChild) {
        container.removeChild(container.firstChild);
    }
    
    garageIcon.classList.remove('garage-menu-header-title-garage', 'garage-menu-header-title-impound', 'garage-menu-header-title-retrieved');
    
    if (impoundPrice > 0) {
        garageIcon.classList.add('garage-menu-header-title-impound');
        garageText.textContent = currentLocales['impound'] || 'Fourrière - gestion de véhicule';
    } else {
        garageIcon.classList.add('garage-menu-header-title-garage');
        garageText.textContent = currentLocales['garage'] || 'Garage - gestion de véhicule';
    }

    vehicles.forEach(vehicle => {
        const clone = template.content.cloneNode(true);
        
        clone.querySelector('.garage-menu-vehicle-list-item-name').textContent = vehicle.name;
        
        clone.querySelector('.statistic-button').textContent = currentLocales['statistic'] || 'Stats';
        clone.querySelector('.locate-button').textContent = currentLocales['locate'] || 'Localiser';
        clone.querySelector('.get-button').textContent = currentLocales['get'] || 'prendre';
        
        if (informationType === 0) {
            clone.querySelector('.garage-menu-vehicle-list-item-id').textContent = vehicle.plate;
        } else {
            clone.querySelector('.garage-menu-vehicle-list-item-id').textContent = 'ID ' + (vehicle.id || '');
        }
        
        clone.querySelector('.vehicle-item-plate').textContent = vehicle.plate;

        const statisticBtn = clone.querySelector('#statistic');
        const locateBtn = clone.querySelector('#locate');
        const getBtn = clone.querySelector('.garage-menu-vehicle-list-item-button-get');
        const impoundBtn = clone.querySelector('.garage-menu-vehicle-list-item-button-impound');
        const getBtnText = clone.querySelector('.garage-menu-vehicle-list-item-button-get-text');

        hideElement(statisticBtn);
        hideElement(locateBtn);
        hideElement(getBtn);
        hideElement(impoundBtn);

        if (impoundPrice > 0) {
            showElement(getBtn);
        } else if (vehicle.status == 0) {
            showElement(statisticBtn);
            showElement(locateBtn);
            showElement(impoundBtn);
        } else {
            showElement(statisticBtn);
            showElement(locateBtn);
            showElement(getBtn);
        }

        if (impoundPrice > 0) {
            getBtnText.textContent = impoundPrice + '$';
            getBtn.classList.add('price-button');
        } else {
            getBtnText.textContent = currentLocales['get'] || 'prendre';
            getBtn.classList.remove('price-button');
        }

        const vehicleItem = clone.querySelector('.garage-menu-vehicle-list-item');
        
        vehicleItem.addEventListener('mouseenter', function() {
            sendCallback('hoverVehicle', {
                vehicle: vehicle.name,
                plate: vehicle.plate
            });
        });

        vehicleItem.addEventListener('mouseleave', function(e) {
            if (!vehicleItem.contains(e.relatedTarget)) {
                sendCallback('hoverVehicleEnd', {});
            }
        });

        getBtn.addEventListener('click', function() {
            hideElement(statisticBtn);
            hideElement(locateBtn);
            hideElement(getBtn);
            showElement(impoundBtn);
            
            vehicle.status = 0;
            
            sendCallback('getVehicle', {
                vehicle: vehicle.name,
                plate: vehicle.plate,
                price: impoundPrice
            });
        });

        impoundBtn.addEventListener('click', function() {
            if (vehicleItem.parentNode) {
                vehicleItem.parentNode.removeChild(vehicleItem);
            }
            
            sendCallback('impoundVehicle', {
                vehicle: vehicle.name,
                plate: vehicle.plate
            });
        });

        locateBtn.addEventListener('click', function() {
            sendCallback('locateVehicle', {
                vehicle: vehicle.name,
                plate: vehicle.plate
            });
        });

        let statsVisible = false;
        statisticBtn.addEventListener('click', function() {
            if (statsVisible) {
                sendCallback('hideStats', {});
                statsVisible = false;
            } else {
                sendCallback('showStatistic', {
                    vehicle: vehicle.name,
                    plate: vehicle.plate
                });
                statsVisible = true;
            }
        });

        container.appendChild(clone);
    });
    
    if (vehicles.length === 0) {
        const emptyMessage = document.createElement('div');
        emptyMessage.style.cssText = 'text-align: center; padding: 2vh; color: #969696; font-size: 0.9em;';
        emptyMessage.textContent = impoundPrice > 0 ? 'Aucun véhicule en fourrière' : 'Aucun véhicule dans ce garage';
        container.appendChild(emptyMessage);
    }
}

window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch (data.type) {
        case 'open':
            if (data.locales) {
                currentLocales = data.locales;
                updateLocales(data.locales);
            }
            
            currentConfig = data;
            
            showElement(document.getElementById('garage'));
            hideElement(document.getElementById('vehicle-spec'));
            
            if (data.vehicles) {
                currentVehicles = data.vehicles;
                buildVehicleList(data.vehicles, data.price || 0, data.information || 0);
            }
            break;
            
        case 'close':
            const garageEl = document.getElementById('garage');
            const specEl = document.getElementById('vehicle-spec');
            hideElement(garageEl);
            hideElement(specEl);
            break;
            
        case 'updateSpecs':
            const speedBar = document.getElementById('speed');
            const accelBar = document.getElementById('acceleration');
            const brakeBar = document.getElementById('brake');
            const tractionBar = document.getElementById('traction');
            
            if (speedBar) speedBar.style.width = data.specs.maxSpeed + '%';
            if (accelBar) accelBar.style.width = data.specs.acceleration + '%';
            if (brakeBar) brakeBar.style.width = data.specs.brake + '%';
            if (tractionBar) tractionBar.style.width = data.specs.traction + '%';
            break;
            
        case 'showStats':
            const speedBar2 = document.getElementById('speed');
            const accelBar2 = document.getElementById('acceleration');
            const brakeBar2 = document.getElementById('brake');
            const tractionBar2 = document.getElementById('traction');
            const handlingBar = document.getElementById('handling');
            const specName = document.getElementById('vehicle-spec-name');
            
            if (speedBar2) speedBar2.style.width = data.specs.maxSpeed + '%';
            if (accelBar2) accelBar2.style.width = data.specs.acceleration + '%';
            if (brakeBar2) brakeBar2.style.width = data.specs.brake + '%';
            if (tractionBar2) tractionBar2.style.width = data.specs.traction + '%';
            if (handlingBar) handlingBar.style.width = (data.specs.traction || 50) + '%';
            if (specName && data.vehicle && data.plate) {
                specName.textContent = data.vehicle + ' - ' + data.plate;
            }
            
            const specContainer = document.getElementById('vehicle-spec');
            showElement(specContainer);
            break;
            
        case 'hideStats':
            const specContainer2 = document.getElementById('vehicle-spec');
            hideElement(specContainer2);
            break;
    }
});

window.addEventListener('click', function(event) {
    if (event.target.id === 'close-menu') {
        hideElement(document.getElementById('garage'));
        sendCallback('closeMenu', {});
    }
    if (event.target.id === 'close-stats') {
        hideElement(document.getElementById('vehicle-spec'));
        sendCallback('hideStats', {});
    }
});

function updateLocales(locales) {
    const mapping = {
        'garage': 'garage-text',
        'vehicle-gestion': 'vehicle-gestion',
        'vehicle-list': 'vehicle-list',
        'speed': 'speed-text',
        'acceleration': 'acceleration-text',
        'brake': 'brake-text',
        'traction': 'traction-text'
    };
    
    Object.keys(mapping).forEach(key => {
        let element = document.getElementById(mapping[key]);
        if (element && locales[key]) {
            element.textContent = locales[key];
        }
    });
}

document.addEventListener('DOMContentLoaded', function() {
    hideElement(document.getElementById('garage'));
    hideElement(document.getElementById('vehicle-spec'));
});


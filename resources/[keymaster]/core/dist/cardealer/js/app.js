class VehicleRentalUI {
    constructor() {
        this.vehicles = [];
        this.filteredVehicles = [];
        this.selectedVehicle = null;
        this.currentRental = null;
        this.playerBankBalance = 0;
        this.vehicleDetailsVisible = true;
        this.currentCategory = 'all';
        
        this.init();
    }

    init() {
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => {
                this.bindEvents();
                this.setupMessageListener();
            });
        } else {
            this.bindEvents();
            this.setupMessageListener();
        }
    }

    bindEvents() {

        const closeButton = document.getElementById('closeButton');
        if (closeButton) {
            closeButton.addEventListener('click', () => {
                this.close();
            });
        }

        const informationButton = document.getElementById('informationButton');
        if (informationButton) {
            informationButton.addEventListener('click', () => {
                this.toggleVehicleDetails();
            });
        }


        const cameraOptions = document.querySelectorAll('.camera-option');
        cameraOptions.forEach(option => {
            option.addEventListener('click', () => {
                this.changeCamera(option.dataset.camera);
            });
        });

        const categoryOptions = document.querySelectorAll('.category-option');
        categoryOptions.forEach(option => {
            option.addEventListener('click', () => {
                this.selectCategory(option.dataset.category);
            });
        });

        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                this.close();
            }
        });
    }

    setupMessageListener() {
        window.addEventListener('message', (event) => {
            const data = event.data;
            
            switch(data.action) {
                case 'open':
                    this.open(data.vehicles, data.currentRental, data.playerBankBalance, data.categories);
                    break;
                case 'close':
                    this.close();
                    break;
                case 'updateRental':
                    this.updateRental(data.rental);
                    break;
                case 'updateTimer':
                    this.updateTimer(data.timeLeft);
                    break;
                case 'updateBankBalance':
                    this.updateBankBalance(data.balance);
                    break;
            }
        });
    }

    open(vehicles, currentRental = null, playerBankBalance = 0, categories = null) {
        this.vehicles = vehicles;
        this.currentRental = currentRental;
        this.playerBankBalance = playerBankBalance;
        
        if (categories) {
            this.renderCategories(categories);
        }
        
        this.applyFilter();
        this.renderVehiclesGrid();
        
        const rentalUI = document.getElementById('rental-ui');
        const cameraContainer = document.querySelector('.camera-container');
        const infoContainer = document.querySelector('.info-container');
        
        if (rentalUI) {
            rentalUI.classList.remove('hidden');
        }
        
        if (cameraContainer) {
            cameraContainer.classList.remove('hidden');
        }
        
        if (infoContainer) {
            infoContainer.classList.remove('hidden');
        }
        
        this.postMessage('playSound', { sound: 'SELECT' });
    }

    close() {
        const rentalUI = document.getElementById('rental-ui');
        const cameraContainer = document.querySelector('.camera-container');
        const infoContainer = document.querySelector('.info-container');
        
        if (rentalUI) {
            rentalUI.classList.add('hidden');
        }
        
        if (cameraContainer) {
            cameraContainer.classList.add('hidden');
        }
        
        if (infoContainer) {
            infoContainer.classList.add('hidden');
        }
        
        this.selectedVehicle = null;
        
        this.postMessage('close');
    }

    renderVehiclesGrid() {
        const container = document.getElementById('vehiclesGrid');
        const vehiclesCount = document.getElementById('vehiclesCount');
        
        if (!container) return;
        
        container.innerHTML = '';

        this.filteredVehicles.forEach((vehicle, index) => {
            const vehicleItem = this.createVehicleItem(vehicle, index);
            container.appendChild(vehicleItem);
        });

        if (vehiclesCount) {
            vehiclesCount.textContent = `${this.filteredVehicles.length} véhicule${this.filteredVehicles.length > 1 ? 's' : ''}`;
        }
    }

    createVehicleItem(vehicle, index) {
        const item = document.createElement('div');
        item.className = 'vehicle-item';
        item.dataset.vehicleIndex = index;
        item.dataset.vehicleModel = vehicle.model;
        
        item.innerHTML = `
            <div class="vehicle-image">
                <img src="https://docs.fivem.net/vehicles/${vehicle.model}.webp" alt="${vehicle.name}" 
                     onerror="this.src='assets/vehicles/default.png'"
                     draggable="false">
            </div>
        `;

        item.addEventListener('click', () => {
            this.selectVehicle(vehicle, index);
        });

        return item;
    }

    selectVehicle(vehicle, index) {
        this.selectedVehicle = vehicle;
        
        document.querySelectorAll('.vehicle-item').forEach(item => {
            item.classList.remove('selected');
        });
        
        const selectedItem = document.querySelector(`[data-vehicle-index="${index}"]`);
        if (selectedItem) {
            selectedItem.classList.add('selected');
        }
        
        this.updateVehicleInfo(vehicle);
        this.previewVehicle(vehicle);
        
        this.postMessage('playSound', { sound: 'SELECT' });
    }

    updateVehicleInfo(vehicle) {
        const vehicleName = document.getElementById('vehicleName');
        const vehiclePrice = document.getElementById('vehiclePrice');
        const speedBar = document.getElementById('speedBar');
        const brakeBar = document.getElementById('brakeBar');
        const accelerationBar = document.getElementById('accelerationBar');
        
        if (vehicleName) {
            vehicleName.textContent = vehicle.name;
        }
        
        if (vehiclePrice) {
            vehiclePrice.textContent = vehicle.price + '$';
        }
        
        const stats = this.getVehicleStats(vehicle.model);
        
        if (speedBar) {
            speedBar.style.width = stats.speed + '%';
        }
        if (brakeBar) {
            brakeBar.style.width = stats.brake + '%';
        }
        if (accelerationBar) {
            accelerationBar.style.width = stats.acceleration + '%';
        }
    }

    getVehicleStats(model) {
        const statsMap = {
            // Compacts
            'asbo': { speed: 45, brake: 60, acceleration: 50 },
            'blista': { speed: 50, brake: 65, acceleration: 55 },
            'brioso': { speed: 48, brake: 62, acceleration: 52 },
            'brioso2': { speed: 52, brake: 68, acceleration: 58 },
            'brioso3': { speed: 55, brake: 70, acceleration: 60 },
            'club': { speed: 58, brake: 72, acceleration: 65 },
            'dilettante': { speed: 40, brake: 55, acceleration: 45 },
            'dilettante2': { speed: 42, brake: 58, acceleration: 48 },
            'issi2': { speed: 48, brake: 65, acceleration: 52 },
            'issi3': { speed: 50, brake: 68, acceleration: 55 },
            'issi4': { speed: 75, brake: 80, acceleration: 70 },
            'issi5': { speed: 78, brake: 82, acceleration: 72 },
            'issi6': { speed: 80, brake: 85, acceleration: 75 },
            'kanjo': { speed: 65, brake: 75, acceleration: 70 },
            'panto': { speed: 35, brake: 50, acceleration: 40 },
            'prairie': { speed: 45, brake: 60, acceleration: 50 },
            'rhapsody': { speed: 48, brake: 65, acceleration: 52 },
            'weevil': { speed: 50, brake: 68, acceleration: 55 },
            
            // Sedans
            'asea': { speed: 60, brake: 70, acceleration: 65 },
            'asea2': { speed: 62, brake: 72, acceleration: 67 },
            'asterope': { speed: 65, brake: 75, acceleration: 70 },
            'asterope2': { speed: 70, brake: 80, acceleration: 75 },
            'cinquemila': { speed: 75, brake: 85, acceleration: 80 },
            'cog55': { speed: 80, brake: 85, acceleration: 75 },
            'cog552': { speed: 85, brake: 90, acceleration: 80 },
            'cognoscenti': { speed: 85, brake: 90, acceleration: 80 },
            'cognoscenti2': { speed: 90, brake: 95, acceleration: 85 },
            'emperor': { speed: 55, brake: 70, acceleration: 60 },
            'emperor2': { speed: 58, brake: 72, acceleration: 62 },
            'emperor3': { speed: 60, brake: 75, acceleration: 65 },
            'fugitive': { speed: 75, brake: 80, acceleration: 70 },
            'glendale': { speed: 65, brake: 75, acceleration: 70 },
            'glendale2': { speed: 70, brake: 80, acceleration: 75 },
            'ingot': { speed: 50, brake: 65, acceleration: 55 },
            'intruder': { speed: 60, brake: 70, acceleration: 65 },
            'limo2': { speed: 70, brake: 80, acceleration: 75 },
            'premier': { speed: 55, brake: 70, acceleration: 60 },
            'primo': { speed: 60, brake: 70, acceleration: 65 },
            'primo2': { speed: 65, brake: 75, acceleration: 70 },
            'regina': { speed: 50, brake: 65, acceleration: 55 },
            'romero': { speed: 55, brake: 70, acceleration: 60 },
            'schafter2': { speed: 80, brake: 85, acceleration: 75 },
            'schafter3': { speed: 85, brake: 90, acceleration: 80 },
            'schafter4': { speed: 90, brake: 95, acceleration: 85 },
            'schafter5': { speed: 95, brake: 100, acceleration: 90 },
            'schafter6': { speed: 100, brake: 100, acceleration: 95 },
            'stanier': { speed: 55, brake: 70, acceleration: 60 },
            'stratum': { speed: 60, brake: 70, acceleration: 65 },
            'stretch': { speed: 65, brake: 75, acceleration: 70 },
            'superd': { speed: 85, brake: 90, acceleration: 80 },
            'surge': { speed: 70, brake: 80, acceleration: 75 },
            'tailgater': { speed: 65, brake: 75, acceleration: 70 },
            'tailgater2': { speed: 70, brake: 80, acceleration: 75 },
            'warrener': { speed: 60, brake: 70, acceleration: 65 },
            'washington': { speed: 65, brake: 75, acceleration: 70 },
            
            // SUVs
            'baller': { speed: 70, brake: 80, acceleration: 75 },
            'baller2': { speed: 75, brake: 85, acceleration: 80 },
            'baller3': { speed: 80, brake: 90, acceleration: 85 },
            'baller4': { speed: 85, brake: 95, acceleration: 90 },
            'baller5': { speed: 90, brake: 100, acceleration: 95 },
            'baller6': { speed: 95, brake: 100, acceleration: 100 },
            'bjxl': { speed: 65, brake: 75, acceleration: 70 },
            'cavalcade': { speed: 70, brake: 80, acceleration: 75 },
            'cavalcade2': { speed: 75, brake: 85, acceleration: 80 },
            'contender': { speed: 80, brake: 90, acceleration: 85 },
            'dubsta': { speed: 75, brake: 85, acceleration: 80 },
            'dubsta2': { speed: 80, brake: 90, acceleration: 85 },
            'dubsta3': { speed: 85, brake: 95, acceleration: 90 },
            'fq2': { speed: 70, brake: 80, acceleration: 75 },
            'granger': { speed: 75, brake: 85, acceleration: 80 },
            'granger2': { speed: 80, brake: 90, acceleration: 85 },
            'habanero': { speed: 70, brake: 80, acceleration: 75 },
            'huntley': { speed: 80, brake: 90, acceleration: 85 },
            'landstalker': { speed: 75, brake: 85, acceleration: 80 },
            'landstalker2': { speed: 80, brake: 90, acceleration: 85 },
            'mesa': { speed: 70, brake: 80, acceleration: 75 },
            'mesa2': { speed: 75, brake: 85, acceleration: 80 },
            'mesa3': { speed: 80, brake: 90, acceleration: 85 },
            'patriot': { speed: 75, brake: 85, acceleration: 80 },
            'patriot2': { speed: 80, brake: 90, acceleration: 85 },
            'patriot3': { speed: 85, brake: 95, acceleration: 90 },
            'radi': { speed: 70, brake: 80, acceleration: 75 },
            'rebla': { speed: 75, brake: 85, acceleration: 80 },
            'rocoto': { speed: 80, brake: 90, acceleration: 85 },
            'seminole': { speed: 70, brake: 80, acceleration: 75 },
            'seminole2': { speed: 75, brake: 85, acceleration: 80 },
            'serrano': { speed: 70, brake: 80, acceleration: 75 },
            'squaddie': { speed: 75, brake: 85, acceleration: 80 },
            'toros': { speed: 80, brake: 90, acceleration: 85 },
            'xls': { speed: 75, brake: 85, acceleration: 80 },
            'xls2': { speed: 80, brake: 90, acceleration: 85 },
            
            // Sports
            'alpha': { speed: 85, brake: 90, acceleration: 80 },
            'banshee': { speed: 90, brake: 95, acceleration: 85 },
            'banshee2': { speed: 95, brake: 100, acceleration: 90 },
            'bestiagts': { speed: 85, brake: 90, acceleration: 80 },
            'blista2': { speed: 70, brake: 80, acceleration: 75 },
            'blista3': { speed: 75, brake: 85, acceleration: 80 },
            'buffalo': { speed: 80, brake: 85, acceleration: 75 },
            'buffalo2': { speed: 85, brake: 90, acceleration: 80 },
            'buffalo3': { speed: 90, brake: 95, acceleration: 85 },
            'buffalo4': { speed: 95, brake: 100, acceleration: 90 },
            'carbonizzare': { speed: 90, brake: 95, acceleration: 85 },
            'comet2': { speed: 85, brake: 90, acceleration: 80 },
            'comet3': { speed: 90, brake: 95, acceleration: 85 },
            'comet4': { speed: 95, brake: 100, acceleration: 90 },
            'comet5': { speed: 100, brake: 100, acceleration: 95 },
            'comet6': { speed: 100, brake: 100, acceleration: 100 },
            'coquette': { speed: 85, brake: 90, acceleration: 80 },
            'coquette2': { speed: 90, brake: 95, acceleration: 85 },
            'coquette3': { speed: 95, brake: 100, acceleration: 90 },
            'coquette4': { speed: 100, brake: 100, acceleration: 95 },
            'drafter': { speed: 90, brake: 95, acceleration: 85 },
            'elegy': { speed: 85, brake: 90, acceleration: 80 },
            'elegy2': { speed: 90, brake: 95, acceleration: 85 },
            'feltzer2': { speed: 85, brake: 90, acceleration: 80 },
            'flashgt': { speed: 90, brake: 95, acceleration: 85 },
            'furoregt': { speed: 85, brake: 90, acceleration: 80 },
            'fusilade': { speed: 80, brake: 85, acceleration: 75 },
            'futo': { speed: 75, brake: 80, acceleration: 70 },
            'futo2': { speed: 80, brake: 85, acceleration: 75 },
            'gb200': { speed: 85, brake: 90, acceleration: 80 },
            'hotring': { speed: 90, brake: 95, acceleration: 85 },
            'imorgon': { speed: 85, brake: 90, acceleration: 80 },
            'infernus2': { speed: 90, brake: 95, acceleration: 85 },
            'italigtb': { speed: 95, brake: 100, acceleration: 90 },
            'italigtb2': { speed: 100, brake: 100, acceleration: 95 },
            'jester': { speed: 85, brake: 90, acceleration: 80 },
            'jester2': { speed: 90, brake: 95, acceleration: 85 },
            'jester3': { speed: 95, brake: 100, acceleration: 90 },
            'jester4': { speed: 100, brake: 100, acceleration: 95 },
            'khamelion': { speed: 80, brake: 85, acceleration: 75 },
            'kuruma': { speed: 80, brake: 85, acceleration: 75 },
            'kuruma2': { speed: 85, brake: 90, acceleration: 80 },
            'locust': { speed: 90, brake: 95, acceleration: 85 },
            'lynx': { speed: 85, brake: 90, acceleration: 80 },
            'massacro': { speed: 90, brake: 95, acceleration: 85 },
            'massacro2': { speed: 95, brake: 100, acceleration: 90 },
            'neo': { speed: 85, brake: 90, acceleration: 80 },
            'neon': { speed: 80, brake: 85, acceleration: 75 },
            'ninef': { speed: 90, brake: 95, acceleration: 85 },
            'ninef2': { speed: 95, brake: 100, acceleration: 90 },
            'omnis': { speed: 85, brake: 90, acceleration: 80 },
            'paragon': { speed: 85, brake: 90, acceleration: 80 },
            'paragon2': { speed: 90, brake: 95, acceleration: 85 },
            'pariah': { speed: 95, brake: 100, acceleration: 90 },
            'penumbra': { speed: 80, brake: 85, acceleration: 75 },
            'penumbra2': { speed: 85, brake: 90, acceleration: 80 },
            'raiden': { speed: 80, brake: 85, acceleration: 75 },
            'rapidgt': { speed: 90, brake: 95, acceleration: 85 },
            'rapidgt2': { speed: 95, brake: 100, acceleration: 90 },
            'rapidgt3': { speed: 100, brake: 100, acceleration: 95 },
            'raptor': { speed: 85, brake: 90, acceleration: 80 },
            'revolter': { speed: 85, brake: 90, acceleration: 80 },
            'schafter3': { speed: 85, brake: 90, acceleration: 80 },
            'schafter4': { speed: 90, brake: 95, acceleration: 85 },
            'schafter5': { speed: 95, brake: 100, acceleration: 90 },
            'schafter6': { speed: 100, brake: 100, acceleration: 95 },
            'schlagen': { speed: 90, brake: 95, acceleration: 85 },
            'schwarzer': { speed: 85, brake: 90, acceleration: 80 },
            'sentinel3': { speed: 85, brake: 90, acceleration: 80 },
            'seven70': { speed: 90, brake: 95, acceleration: 85 },
            'specter': { speed: 90, brake: 95, acceleration: 85 },
            'specter2': { speed: 95, brake: 100, acceleration: 90 },
            'streiter': { speed: 80, brake: 85, acceleration: 75 },
            'sultan': { speed: 80, brake: 85, acceleration: 75 },
            'sultan2': { speed: 85, brake: 90, acceleration: 80 },
            'sultan3': { speed: 90, brake: 95, acceleration: 85 },
            'sultan4': { speed: 95, brake: 100, acceleration: 90 },
            'surano': { speed: 85, brake: 90, acceleration: 80 },
            'tampa2': { speed: 80, brake: 85, acceleration: 75 },
            'tropos': { speed: 85, brake: 90, acceleration: 80 },
            'verlierer2': { speed: 90, brake: 95, acceleration: 85 },
            'vstr': { speed: 85, brake: 90, acceleration: 80 },
            'zr350': { speed: 85, brake: 90, acceleration: 80 },
            'zr380': { speed: 90, brake: 95, acceleration: 85 },
            'zr3802': { speed: 95, brake: 100, acceleration: 90 },
            'zr3803': { speed: 100, brake: 100, acceleration: 95 },
            
            // Super
            'adder': { speed: 100, brake: 100, acceleration: 100 },
            'autarch': { speed: 100, brake: 100, acceleration: 100 },
            'banshee2': { speed: 95, brake: 100, acceleration: 90 },
            'bullet': { speed: 95, brake: 100, acceleration: 90 },
            'cheetah': { speed: 100, brake: 100, acceleration: 100 },
            'cyclone': { speed: 100, brake: 100, acceleration: 100 },
            'entity2': { speed: 100, brake: 100, acceleration: 100 },
            'entityxf': { speed: 100, brake: 100, acceleration: 100 },
            'emerus': { speed: 100, brake: 100, acceleration: 100 },
            'fmj': { speed: 100, brake: 100, acceleration: 100 },
            'furia': { speed: 100, brake: 100, acceleration: 100 },
            'gp1': { speed: 100, brake: 100, acceleration: 100 },
            'infernus': { speed: 95, brake: 100, acceleration: 90 },
            'italigtb': { speed: 95, brake: 100, acceleration: 90 },
            'italigtb2': { speed: 100, brake: 100, acceleration: 100 },
            'krieger': { speed: 100, brake: 100, acceleration: 100 },
            'le7b': { speed: 100, brake: 100, acceleration: 100 },
            'nero': { speed: 100, brake: 100, acceleration: 100 },
            'nero2': { speed: 100, brake: 100, acceleration: 100 },
            'osiris': { speed: 100, brake: 100, acceleration: 100 },
            'penetrator': { speed: 100, brake: 100, acceleration: 100 },
            'pfister811': { speed: 100, brake: 100, acceleration: 100 },
            'prototipo': { speed: 100, brake: 100, acceleration: 100 },
            'reaper': { speed: 100, brake: 100, acceleration: 100 },
            's80': { speed: 100, brake: 100, acceleration: 100 },
            'sc1': { speed: 100, brake: 100, acceleration: 100 },
            'sheava': { speed: 100, brake: 100, acceleration: 100 },
            'sultan2': { speed: 85, brake: 90, acceleration: 80 },
            'sultan3': { speed: 90, brake: 95, acceleration: 85 },
            'sultan4': { speed: 95, brake: 100, acceleration: 90 },
            't20': { speed: 100, brake: 100, acceleration: 100 },
            'taipan': { speed: 100, brake: 100, acceleration: 100 },
            'tempesta': { speed: 100, brake: 100, acceleration: 100 },
            'tezeract': { speed: 100, brake: 100, acceleration: 100 },
            'thrax': { speed: 100, brake: 100, acceleration: 100 },
            'tigon': { speed: 100, brake: 100, acceleration: 100 },
            'turismor': { speed: 100, brake: 100, acceleration: 100 },
            'tyrant': { speed: 100, brake: 100, acceleration: 100 },
            'tyrus': { speed: 100, brake: 100, acceleration: 100 },
            'vacca': { speed: 95, brake: 100, acceleration: 90 },
            'vagner': { speed: 100, brake: 100, acceleration: 100 },
            'vigilante': { speed: 100, brake: 100, acceleration: 100 },
            'visione': { speed: 100, brake: 100, acceleration: 100 },
            'voltic': { speed: 95, brake: 100, acceleration: 90 },
            'voltic2': { speed: 100, brake: 100, acceleration: 100 },
            'xa21': { speed: 100, brake: 100, acceleration: 100 },
            'zentorno': { speed: 100, brake: 100, acceleration: 100 },
            'zorrusso': { speed: 100, brake: 100, acceleration: 100 }
        };
        
        return statsMap[model] || { speed: 50, brake: 50, acceleration: 50 };
    }

    changeCamera(cameraIndex) {
        document.querySelectorAll('.camera-option').forEach(option => {
            option.classList.remove('active');
        });
        
        const activeOption = document.querySelector(`[data-camera="${cameraIndex}"]`);
        if (activeOption) {
            activeOption.classList.add('active');
        }
        
        this.postMessage('changeCamera', {
            mode: parseInt(cameraIndex)
        });
        
        this.postMessage('playSound', { sound: 'SELECT' });
    }

    selectCategory(category) {
        document.querySelectorAll('.category-option').forEach(option => {
            option.classList.remove('selected');
        });
        
        const selectedOption = document.querySelector(`[data-category="${category}"]`);
        if (selectedOption) {
            selectedOption.classList.add('selected');
        }
        
        this.currentCategory = category;
        this.applyFilter();
        this.renderVehiclesGrid();
        
        this.postMessage('selectCategory', {
            category: category
        });
        
        this.postMessage('playSound', { sound: 'SELECT' });
    }

    previewVehicle(vehicle) {
        this.postMessage('previewVehicle', {
            model: vehicle.model,
            vehicleData: vehicle
        });
    }


    rentVehicle() {
        if (!this.selectedVehicle) return;
        
        const loadingOverlay = document.getElementById('loadingOverlay');
        if (loadingOverlay) {
            loadingOverlay.classList.remove('hidden');
        }
        
        this.postMessage('rentVehicle', {
            vehicle: this.selectedVehicle
        });
        
        this.postMessage('playSound', { sound: 'SELECT' });
        
        setTimeout(() => {
            this.close();
            if (loadingOverlay) {
                loadingOverlay.classList.add('hidden');
            }
        }, 2000);
    }

    updateRental(rental) {
        this.currentRental = rental;
    }

    updateTimer(timeLeft) {
    }

    updateBankBalance(balance) {
        this.playerBankBalance = balance;
    }

    returnVehicle() {
        this.postMessage('returnVehicle');
        this.postMessage('playSound', { sound: 'SELECT' });
    }

    toggleVehicleDetails() {
        this.vehicleDetailsVisible = !this.vehicleDetailsVisible;
        const vehicleDetails = document.getElementById('vehicleInfo');
        const informationButton = document.getElementById('informationButton');
        
        if (vehicleDetails) {
            if (this.vehicleDetailsVisible) {
                vehicleDetails.classList.remove('hidden');
                informationButton.innerHTML = '<i class="fas fa-info-circle"></i><span>Informations</span>';
            } else {
                vehicleDetails.classList.add('hidden');
                informationButton.innerHTML = '<i class="fas fa-eye"></i><span>Informations</span>';
            }
        }
        
        this.postMessage('playSound', { sound: 'SELECT' });
    }



    renderCategories(categories) {
        const categoriesList = document.querySelector('.categories-list');
        if (!categoriesList) return;
        
        categoriesList.innerHTML = '';
        
        categories.forEach(category => {
            const categoryElement = document.createElement('div');
            categoryElement.className = `category-option ${category.id === 'all' ? 'selected' : ''}`;
            categoryElement.dataset.category = category.id;
            
            categoryElement.innerHTML = `
                <div class="category-icon">
                    <i class="${category.icon}"></i>
                </div>
                <span class="category-name">${category.name}</span>
            `;
            
            categoryElement.addEventListener('click', () => {
                this.selectCategory(category.id);
            });
            
            categoriesList.appendChild(categoryElement);
        });
    }

    applyFilter() {
        if (this.currentCategory === 'all') {
            this.filteredVehicles = [...this.vehicles];
        } else {
            this.filteredVehicles = this.vehicles.filter(vehicle => {
                return vehicle.category === this.currentCategory;
            });
        }
    }

    postMessage(action, data = {}) {
        fetch(`https://${GetParentResourceName()}/${action}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data)
        }).catch(() => {});
    }
}

let rentalUI;

if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        rentalUI = new VehicleRentalUI();
        window.rentalUI = rentalUI;
    });
} else {
    rentalUI = new VehicleRentalUI();
    window.rentalUI = rentalUI;
}
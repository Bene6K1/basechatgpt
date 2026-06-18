<template>
    <div>
    <v-app theme="dark">
        <div class="weapon-shop-container" v-show="isVisible">
            <div class="menu-bar">
                <div class="menu-left">
                    <i class="fas fa-shopping-cart"></i>
                    <div class="menu-title">
                        <div class="big">Magasin</div>
                        <div class="small">Ouvert tous les jours</div>
                    </div>
                </div>
                <div class="menu-right">
                    <div class="close-btn" @click="closeShop">ESC</div>
                </div>
            </div>

            <div class="main-content">
                <div class="products-section">
                    <div class="products-section-header">
                        <div class="search-container">
                            <input
                                type="text"
                                placeholder="Rechercher un article..."
                                class="search-input"
                                v-model="searchTerm"
                                ref="searchInput"
                            />
                            <i class="fas fa-search search-icon"></i>
                        </div>

                        <div class="categories-container">
                            <div
                                v-for="category in categories"
                                :key="category.id"
                                class="category-item"
                                :class="{ active: currentCategory === category.id }"
                                :data-category="category.id"
                                @click="selectCategory(category.id)"
                                v-show="
                                    category.id === 'all' || existingCategories.has(category.id)
                                "
                            >
                                <div class="category-icon">
                                    <img :src="category.icon" :alt="category.name" />
                                </div>
                                <div class="category-name">{{ category.name }}</div>
                            </div>
                        </div>
                    </div>

                    <div class="products-grid" v-if="!isLoading && filteredItems.length > 0">
                        <div
                            v-for="item in filteredItems"
                            :key="item.name"
                            class="product-card"
                            :data-item-name="item.name"
                        >
                            <div class="product-image">
                                <img :src="item.image" :alt="item.label" />
                            </div>
                            <div class="product-info">
                                <div class="product-header">
                                    <div class="product-name">{{ item.label }}</div>
                                    <div class="product-price">${{ item.price }}</div>
                                </div>
                                <div class="product-description">
                                    {{ getItemDescription(item) }}
                                </div>
                                <div class="product-actions">
                                    <button class="add-to-cart-btn" @click="addToCart(item.name)">
                                        Ajouter au panier
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Skeleton Loaders -->
                    <div class="products-grid" v-if="isLoading">
                        <SkeletonCard v-for="n in 8" :key="n" />
                    </div>

                    <!-- Empty State for Search -->
                    <EmptyState
                        v-if="!isLoading && filteredItems.length === 0 && searchTerm"
                        icon="fas fa-search"
                        title="Aucun article trouvé"
                        message="Aucun article ne correspond à votre recherche. Essayez avec d'autres mots-clés."
                        buttonText="Réinitialiser la recherche"
                        @buttonClick="searchTerm = ''"
                    />

                    <!-- Empty State for Category -->
                    <EmptyState
                        v-if="!isLoading && filteredItems.length === 0 && !searchTerm"
                        icon="fas fa-box-open"
                        title="Aucun article disponible"
                        message="Cette catégorie ne contient aucun article pour le moment."
                    />
                </div>

                <div class="shopping-cart">
                    <div class="cart-header">
                        <div class="cart-title">
                            <i class="fas fa-shopping-basket"></i>
                            Panier
                        </div>
                        <Transition name="bounce" mode="out-in">
                            <div class="cart-count" :key="totalCartItems">{{ totalCartItems }}</div>
                        </Transition>
                    </div>

                    <!-- <div class="cart-description">
                        Ajoutez des articles à votre panier pour les acheter
                    </div> -->

                    <div class="cart-items" v-show="cart.length > 0">
                        <div
                            v-for="item in cart"
                            :key="item.name"
                            class="cart-item"
                            :data-item-name="item.name"
                        >
                            <div class="cart-item-image">
                                <img :src="item.image" :alt="item.label" />
                            </div>
                            <div class="cart-item-details">
                                <div class="cart-item-header">
                                    <div class="cart-item-name">{{ item.label }}</div>
                                </div>
                                <div class="cart-item-desc">Quantité: {{ item.quantity }}</div>
                                <div class="cart-item-footer">
                                    <div class="cart-item-price">
                                        ${{ item.price * item.quantity }}
                                    </div>
                                    <div class="quantity-controls">
                                        <button
                                            class="quantity-btn remove"
                                            @click="decreaseCartQuantity(item.name)"
                                        >
                                            -
                                        </button>
                                        <div class="quantity">{{ item.quantity }}</div>
                                        <button
                                            class="quantity-btn"
                                            @click="increaseCartQuantity(item.name)"
                                        >
                                            +
                                        </button>
                                        <div class="remove-btn" @click="removeFromCart(item.name)">
                                            <i class="fas fa-times"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="cart-empty-container" v-show="cart.length === 0">
                        <EmptyState
                            icon="fas fa-shopping-basket"
                            title="Votre panier est vide"
                            message="Parcourez nos articles et ajoutez-les à votre panier pour commencer vos achats."
                        />
                    </div>

                    <div class="cart-total">
                        <div class="total-row">
                            <span class="total-label">Total</span>
                            <Transition name="pulse" mode="out-in">
                                <span class="total-amount" :key="cartTotal">${{ cartTotal }}</span>
                            </Transition>
                        </div>
                    </div>

                    <div class="payment-buttons">
                        <button class="payment-btn" @click="handlePayment">
                            <i class="fas fa-credit-card"></i>
                            <span>Payer</span>
                        </button>
                        <button
                            class="payment-btn primary"
                            v-show="currentShopType === 'ltd'"
                            @click="handleBillClient"
                        >
                            <i class="fas fa-file-invoice-dollar"></i>
                            <span>Facturer un client</span>
                        </button>
                        <button class="payment-btn secondary" @click="confirmClearCart" :disabled="cart.length === 0">
                            <i class="fas fa-trash"></i>
                            <span>Vider le panier</span>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Success Payment Modal -->
            <div class="payment-modal" :class="{ show: showModal }">
                <div class="payment-modal-content">
                    <div class="payment-success-icon">
                        <i class="fas fa-check"></i>
                    </div>
                    <h3>Achat réussi !</h3>
                    <p>Vos articles ont été ajoutés à votre inventaire.</p>
                    <button class="payment-btn" @click="closeModal">
                        <i class="fas fa-times"></i>
                        Fermer
                    </button>
                </div>
            </div>

            <!-- Clear Cart Confirmation Modal -->
            <div class="payment-modal" :class="{ show: showClearCartModal }">
                <div class="payment-modal-content">
                    <div class="payment-warning-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <h3>Vider le panier ?</h3>
                    <p>Êtes-vous sûr de vouloir retirer tous les articles de votre panier ? Cette action est irréversible.</p>
                    <div class="modal-buttons">
                        <button class="payment-btn secondary" @click="clearCart">
                            <i class="fas fa-check"></i>
                            Confirmer
                        </button>
                        <button class="payment-btn" @click="cancelClearCart">
                            <i class="fas fa-times"></i>
                            Annuler
                        </button>
                    </div>
                </div>
            </div>

            <!-- Payment Method Selection Modal -->
            <div class="payment-method-overlay" :class="{ show: showPaymentMethodModal }" @click.self="cancelPaymentMethod">
                <div class="payment-method-panel">
                    <div class="payment-method-header">
                        <div class="payment-method-title">
                            <i class="fas fa-credit-card"></i>
                            <span>Paiement</span>
                        </div>
                        <div class="payment-method-close" @click="cancelPaymentMethod">
                            <i class="fas fa-times"></i>
                        </div>
                    </div>
                    <div class="payment-method-amount">
                        <span class="amount-label">Total à payer</span>
                        <span class="amount-value">${{ cartTotal }}</span>
                    </div>
                    <div class="payment-method-options">
                        <div class="payment-option" @click="processPayment('cash')">
                            <div class="payment-option-icon cash">
                                <i class="fas fa-money-bill-wave"></i>
                            </div>
                            <div class="payment-option-info">
                                <div class="payment-option-name">Espèces</div>
                                <div class="payment-option-desc">Payer en liquide</div>
                            </div>
                            <div class="payment-option-arrow">
                                <i class="fas fa-chevron-right"></i>
                            </div>
                        </div>
                        <div class="payment-option" @click="processPayment('bank')">
                            <div class="payment-option-icon bank">
                                <i class="fas fa-university"></i>
                            </div>
                            <div class="payment-option-info">
                                <div class="payment-option-name">Banque</div>
                                <div class="payment-option-desc">Payer par carte</div>
                            </div>
                            <div class="payment-option-arrow">
                                <i class="fas fa-chevron-right"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Toast Notification System -->
            <ToastNotification ref="toastRef" />
        </div>
    </v-app>
    </div>
</template>
<script setup>
import { ref, computed, onMounted, onUnmounted, nextTick } from "vue";
import { useGlobalStore } from "./stores/global";
import api from "./api/axios";
import ToastNotification from "./components/ToastNotification.vue";
import SkeletonCard from "./components/SkeletonCard.vue";
import EmptyState from "./components/EmptyState.vue";

const globalStore = useGlobalStore();

// DEV MODE - Set to true to enable fake data for testing
const DEV_MODE = false;

// State
const items = ref([]);
const cart = ref([]);
const currentCategory = ref("all");
const searchTerm = ref("");
const isVisible = ref(false);
const currentShopType = ref("");
const showModal = ref(false);
const searchInput = ref(null);
const toastRef = ref(null);
const isLoading = ref(false);
const showClearCartModal = ref(false);
const showPaymentMethodModal = ref(false);

// Fake data for development
const FAKE_ITEMS = [
    {
        name: "bread",
        label: "Pain",
        price: 5,
        image: "assets/bread.png",
        categorie: "food",
        type: "item",
    },
    {
        name: "water",
        label: "Eau",
        price: 3,
        image: "assets/water.png",
        categorie: "food",
        type: "item",
    },
    {
        name: "phone",
        label: "Téléphone",
        price: 500,
        image: "assets/black_phone.png",
        categorie: "divers",
        type: "item",
    },
    {
        name: "tablet",
        label: "Tablette",
        price: 800,
        image: "assets/tablet.png",
        categorie: "divers",
        type: "item",
    },
    {
        name: "wallet",
        label: "Portefeuille",
        price: 50,
        image: "assets/wallet.png",
        categorie: "divers",
        type: "item",
    },
    {
        name: "bmx",
        label: "BMX",
        price: 1200,
        image: "assets/bmx.png",
        categorie: "props",
        type: "item",
    },
    {
        name: "boombox",
        label: "Boombox",
        price: 350,
        image: "assets/boombox.png",
        categorie: "props",
        type: "item",
    },
    {
        name: "snspistol",
        label: "Pistolet SNS",
        price: 2500,
        image: "assets/weapon_snspistol.png",
        categorie: "armes",
        type: "weapon",
    },
    {
        name: "bat",
        label: "Batte de baseball",
        price: 150,
        image: "assets/weapon_bat.png",
        categorie: "armes",
        type: "weapon",
    },
    {
        name: "knife",
        label: "Couteau",
        price: 200,
        image: "assets/weapon_knife.png",
        categorie: "armes",
        type: "weapon",
    },
    {
        name: "knuckle",
        label: "Poing américain",
        price: 100,
        image: "assets/weapon_knuckle.png",
        categorie: "armes",
        type: "weapon",
    },
    {
        name: "9mm",
        label: "Munitions 9mm",
        price: 50,
        image: "assets/9mm.png",
        categorie: "munitions",
        type: "item",
    },
    {
        name: "556mm",
        label: "Munitions 5.56mm",
        price: 75,
        image: "assets/556mm.png",
        categorie: "munitions",
        type: "item",
    },
    {
        name: "762mm",
        label: "Munitions 7.62mm",
        price: 80,
        image: "assets/762mm.png",
        categorie: "munitions",
        type: "item",
    },
    {
        name: "12gauge",
        label: "Cartouches 12 gauge",
        price: 60,
        image: "assets/12gauge.png",
        categorie: "munitions",
        type: "item",
    },
    {
        name: "outfitbag",
        label: "Sac de vêtements",
        price: 250,
        image: "assets/kq_outfitbag.png",
        categorie: "divers",
        type: "item",
    },
    {
        name: "empty_bag",
        label: "Sac vide",
        price: 100,
        image: "assets/empty_bag.png",
        categorie: "divers",
        type: "item",
    },
    {
        name: "shipping_box",
        label: "Carton d'expédition",
        price: 20,
        image: "assets/shipping_box.png",
        categorie: "divers",
        type: "item",
    },
    {
        name: "scratch_ticket",
        label: "Ticket à gratter",
        price: 10,
        image: "assets/scratch_ticket.png",
        categorie: "divers",
        type: "item",
    },
    {
        name: "nitro",
        label: "Nitro pour véhicule",
        price: 500,
        image: "assets/nitrovehicle.png",
        categorie: "props",
        type: "item",
    },
];

// Categories configuration
const categories = [
    { id: "all", name: "Tous", icon: "assets/aaa.png" },
    { id: "food", name: "Nourriture", icon: "assets/dejeuner.png" },
    { id: "divers", name: "Divers", icon: "assets/sac.png" },
    // { id: 'armes', name: 'Armes', icon: 'assets/aaa.png' },
    // { id: 'munitions', name: 'Munitions', icon: 'assets/aaa.png' },
    // { id: 'props', name: 'Props', icon: 'assets/aaa.png' },
    // { id: 'illegalitem', name: 'Outils', icon: 'assets/aaa.png' }
];

// Computed properties
const existingCategories = computed(() => {
    return new Set(items.value.map((item) => item.categorie));
});

const filteredItems = computed(() => {
    return items.value.filter((item) => {
        const matchesCategory =
            currentCategory.value === "all" || item.categorie === currentCategory.value;
        const matchesSearch =
            item.label.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
            item.name.toLowerCase().includes(searchTerm.value.toLowerCase());
        return matchesCategory && matchesSearch;
    });
});

const totalCartItems = computed(() => {
    return cart.value.reduce((sum, item) => sum + item.quantity, 0);
});

const cartTotal = computed(() => {
    return cart.value.reduce((sum, item) => sum + item.price * item.quantity, 0);
});

// Methods
const setPlayerID = (id) => {
    globalStore.$state.playerID = id;
};

const getItemDescription = (item) => {
    const descriptions = {
        bread: "Pain frais et nutritif",
        water: "Eau pure et rafraîchissante",
        phone: "Téléphone portable moderne",
        pistol: "Arme de poing fiable",
        ammo: "Munitions standard",
        furniture: "Meuble de qualité",
        lockpick: "Outils de crochetage",
    };

    return descriptions[item.name] || "Article de qualité";
};

const selectCategory = (category) => {
    currentCategory.value = category;
};

const addToCart = (itemName) => {
    const item = items.value.find((i) => i.name === itemName);
    if (!item) return;

    const existingItem = cart.value.find((cartItem) => cartItem.name === itemName);

    if (existingItem) {
        existingItem.quantity += 1;
    } else {
        cart.value.push({
            name: item.name,
            label: item.label,
            price: item.price,
            image: item.image,
            quantity: 1,
        });
    }

    // Show toast notification
    showToast({
        type: 'success',
        title: 'Ajouté au panier',
        message: `${item.label} a été ajouté au panier`
    });
};

const increaseCartQuantity = (itemName) => {
    const item = cart.value.find((i) => i.name === itemName);
    if (item) {
        item.quantity++;
        showToast({
            type: 'info',
            title: 'Quantité mise à jour',
            message: `${item.label} x${item.quantity}`
        });
    }
};

const decreaseCartQuantity = (itemName) => {
    const item = cart.value.find((i) => i.name === itemName);
    if (item && item.quantity > 1) {
        item.quantity--;
    } else if (item && item.quantity === 1) {
        removeFromCart(itemName);
    }
};

const removeFromCart = (itemName) => {
    const item = cart.value.find((i) => i.name === itemName);
    if (item) {
        showToast({
            type: 'warning',
            title: 'Article retiré',
            message: `${item.label} a été retiré du panier`
        });
    }
    cart.value = cart.value.filter((item) => item.name !== itemName);
};

const clearCart = () => {
    cart.value = [];
    showClearCartModal.value = false;
    showToast({
        type: 'info',
        title: 'Panier vidé',
        message: 'Tous les articles ont été retirés'
    });
};

const confirmClearCart = () => {
    showClearCartModal.value = true;
};

const cancelClearCart = () => {
    showClearCartModal.value = false;
};

const handlePayment = () => {
    if (cart.value.length === 0) {
        showNotification("Votre panier est vide", "error");
        return;
    }

    // Show payment method selection modal
    showPaymentMethodModal.value = true;
};

const cancelPaymentMethod = () => {
    showPaymentMethodModal.value = false;
};

const processPayment = (paymentMethod) => {
    showPaymentMethodModal.value = false;

    // Dev mode: simulate successful payment
    if (DEV_MODE) {
        console.log("Dev mode: Simulating payment for", cart.value, "with method:", paymentMethod);
        showPaymentModal();
        cart.value = [];
        return;
    }

    const total = cartTotal.value;
    api.post("/checkMoney", {
        total: total,
        paymentMethod: paymentMethod,
        items: cart.value.map((item) => {
            const originalItem = items.value.find((i) => i.name === item.name);
            return {
                itemName: item.name,
                quantity: item.quantity,
                type: originalItem ? originalItem.type : "item",
            };
        }),
    })
        .then((response) => {
            showPaymentModal();
            cart.value = [];
        })
        .catch((error) => {
            showNotification("Erreur lors du paiement", "error");
        });
};

const handleBillClient = () => {
    if (cart.value.length === 0) {
        showNotification("Votre panier est vide", "error");
        return;
    }

    // Dev mode: simulate successful billing
    if (DEV_MODE) {
        console.log("Dev mode: Simulating billing for", cart.value);
        clearCart();
        closeShop();
        return;
    }

    const total = cartTotal.value;
    api.post("/billClient", {
        total: total,
        items: cart.value.map((item) => {
            const originalItem = items.value.find((i) => i.name === item.name);
            return {
                itemName: item.name,
                quantity: item.quantity,
                type: originalItem ? originalItem.type : "item",
            };
        }),
    })
        .then((response) => {
            clearCart();
            closeShop();
        })
        .catch((error) => {
            showNotification("Erreur lors de la facturation", "error");
        });
};

const showPaymentModal = () => {
    showModal.value = true;
};

const closeModal = () => {
    showModal.value = false;
};

const showNotification = (message, type = "info") => {
    // You can implement a proper notification system here
    console.log(`[${type}] ${message}`);
};

const showToast = (toast) => {
    if (toastRef.value) {
        toastRef.value.addToast(toast);
    }
};

const openShop = (data) => {
    isVisible.value = true;
    isLoading.value = true;
    currentShopType.value = data.shopType || "";
    currentCategory.value = "all";
    searchTerm.value = "";

    // Simulate loading time
    setTimeout(() => {
        items.value = data.items || [];
        isLoading.value = false;

        nextTick(() => {
            if (searchInput.value) {
                searchInput.value.focus();
            }
        });
    }, DEV_MODE ? 1000 : 0);
};

const closeShop = () => {
    isVisible.value = false;

    // Dev mode: skip server communication
    if (DEV_MODE) {
        console.log("Dev mode: Closing shop");
        return;
    }

    api.post("/close", {}).catch((error) => {
        console.error("Error closing shop:", error);
    });
};

const handleShopMessageListener = (event) => {
    const data = event?.data;

    if (data.action === "open") {
        openShop(data);
    } else if (data.action === "close") {
        closeShop();
    } else if (data.action === "clearCart") {
        clearCart();
    }
};

const handleKeydown = (event) => {
    if (event.key === "Escape" && isVisible.value) {
        closeShop();
    }
};

const GetParentResourceName = () => {
    return "shop";
};

const handlers = {
    setPlayerID: (itemData) => {
        if (itemData.data) {
            setPlayerID(itemData.data);
        }
    },
};

const handleMessageListener = (event) => {
    const itemData = event?.data;
    if (handlers[itemData.type]) handlers[itemData.type](itemData);

    // Also handle shop messages
    handleShopMessageListener(event);
};

// Lifecycle hooks
onMounted(() => {
    window.addEventListener("message", handleMessageListener);
    document.addEventListener("keydown", handleKeydown);

    // Dev mode: automatically open shop with fake data
    if (DEV_MODE) {
        setTimeout(() => {
            openShop({
                shopType: "general",
                items: FAKE_ITEMS,
            });
        }, 500);
    }
});

onUnmounted(() => {
    window.removeEventListener("message", handleMessageListener);
    document.removeEventListener("keydown", handleKeydown);
});
</script>
<style>
::-webkit-scrollbar {
    width: 0;
    display: inline !important;
}
.v-application {
    background: transparent !important;
}

:root {
    color-scheme: none !important;
}

/* Shop styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

.weapon-shop-container {
    overflow: hidden;
    position: relative;
    width: 1600px;
    height: 850px;
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.08) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(15, 15, 15, 0.92);
    box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.5), 0px 8px 40px rgba(0, 0, 0, 0.4),
        0px 0px 0px 1px #2c2c2c, inset 0px 1px 0px rgba(255, 255, 255, 0.05);
    border-radius: 12px;
    padding: 28px 32px;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    transition: none;
    will-change: auto;
}

.menu-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 24px;
    padding-bottom: 16px;
    border-bottom: 1px solid #5e5e5e;
    position: relative;
}

.menu-left {
    display: flex;
    align-items: center;
    gap: 16px;
}

.menu-left i {
    font-size: 22px;
    color: #ffffff;
    width: 48px;
    height: 48px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.1) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(25, 25, 25, 0.6);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.3);
}

.menu-title {
    display: flex;
    flex-direction: column;
    justify-content: center;
    height: 100%;
}

.menu-title .small {
    font-family: "Geist", sans-serif;
    font-size: 11px;
    font-weight: 400;
    color: #c6c9ca;
    letter-spacing: 0.5px;
    text-transform: uppercase;
}

.menu-title .big {
    font-family: "Bebas Neue", sans-serif;
    font-size: 28px;
    font-weight: 400;
    line-height: 85%;
    letter-spacing: -0.02em;
    color: #ffffff;
    text-shadow: 0px 2px 4px rgba(0, 0, 0, 0.3);
    margin-top: 6px;
}

.menu-right {
    display: flex;
    align-items: center;
    gap: 12px;
}

.close-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff;
    font-size: 18px;
    cursor: pointer;
    padding: 5px 10px;
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 0, 0, 0.1) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(25, 25, 25, 0.6);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    transition: all 0.2s ease;
    font-size: 16px;
}

.close-btn:hover {
    transform: scale(1.05);
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 0, 0, 0.2) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(35, 25, 25, 0.7);
    border-color: rgba(255, 80, 80, 0.3);
}

.main-content {
    display: flex;
    gap: 24px;
    height: calc(100% - 110px);
}

.categories-sidebar {
    width: 150px;
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.category-item {
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.05) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(18, 18, 18, 0.8);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 8px;
    padding: 0 14px;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    overflow: hidden;
    box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.2);
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

.category-item:hover {
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.08) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(25, 25, 25, 0.85);
    border-color: rgba(255, 255, 255, 0.15);
    /* transform: translateX(2px); */
    box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.3);
}

.category-item.active {
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.12) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(30, 30, 30, 0.9);
    border-color: rgba(255, 255, 255, 0.2);
    box-shadow: 0px 4px 16px rgba(0, 0, 0, 0.4), inset 0px 1px 0px rgba(255, 255, 255, 0.1);
}

.category-icon {
    width: 20px;
    height: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.category-icon img {
    width: 100%;
    height: 100%;
    object-fit: contain;
    filter: brightness(0.5);
    opacity: 0.6;
    transition: all 0.3s ease;
}

.category-item:hover .category-icon img,
.category-item.active .category-icon img {
    filter: brightness(0.9);
    opacity: 0.95;
}

.category-name {
    font-family: "Bebas Neue", sans-serif;
    font-size: 15px;
    font-weight: 400;
    color: #ffffff;
    letter-spacing: 0.5px;
    text-transform: uppercase;
    line-height: 1;
}

.products-section {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.products-section-header {
    display: flex;
    flex-direction: row;
    width: 100%;
    justify-content: space-between;
    gap: 10px;
}

.categories-container {
    display: flex;
    flex-direction: row;
    gap: 8px;
}

.search-container {
    position: relative;
    width: 100%;
}

.search-input {
    width: 100%;
    padding: 14px 50px 14px 18px;
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(50, 50, 50, 0.3) 0%,
            rgba(0, 0, 0, 0) 100%
        )
        rgba(21, 21, 21, 0.9);
    box-shadow: 0px 0.602187px 2.04744px -1.66667px rgba(0, 0, 0, 0.19),
        0px 2.28853px 7.78101px -3.33333px rgba(0, 0, 0, 0.153), 0px 0px 0px 1px #4c4c4c;
    border-radius: 8px;
    color: #fff;
    font-family: "Geist", sans-serif;
    font-size: 14px;
    outline: none;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.search-input:focus {
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(100, 100, 100, 0.3) 0%,
            rgba(0, 0, 0, 0) 100%
        )
        rgba(21, 21, 21, 0.9);
    box-shadow: 0px 0.602187px 2.04744px -1.66667px rgba(0, 0, 0, 0.19),
        0px 2.28853px 7.78101px -3.33333px rgba(0, 0, 0, 0.153), 0px 0px 0px 2px #4c4c4c;
}

.search-input::placeholder {
    color: rgba(255, 255, 255, 0.5);
}

.search-icon {
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: rgba(255, 255, 255, 0.5);
    font-size: 14px;
}

.products-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    padding: 1px;
    gap: 16px;
    height: 100%;
    overflow-y: auto;
    overflow-x: hidden;
    padding-right: 10px;
}

.product-card {
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.1) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(21, 21, 21, 0.55);
    box-shadow: 0px 0.602187px 2.04744px -1.66667px rgba(0, 0, 0, 0.19),
        0px 2.28853px 7.78101px -3.33333px rgba(0, 0, 0, 0.153), 0px 0px 0px 1px #4c4c4c75;
    border-radius: 10px;
    padding: 16px;
    display: flex;
    flex-direction: column;
    height: 340px;
    transition: all 0.1s cubic-bezier(0.4, 0, 0.2, 1);
    cursor: pointer;
    position: relative;
    overflow: hidden;
}

.product-card:hover {
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.2) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(21, 21, 21, 0.25);
    box-shadow: 0px 0.602187px 2.04744px -1.66667px rgba(0, 0, 0, 0.19),
        0px 2.28853px 7.78101px -3.33333px rgba(0, 0, 0, 0.153), 0px 0px 0px 1px #4c4c4c;
}

.product-image {
    height: 190px;
    /* background: rgba(10, 10, 10, 0.7); */
    /* border: 1px solid rgba(255, 255, 255, 0.03); */
    border-radius: 8px;
    margin-bottom: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    position: relative;
    box-shadow: inset 0px 2px 8px rgba(0, 0, 0, 0.3);
}

.product-image::after {
    content: "";
    position: absolute;
    inset: 0;
    background: radial-gradient(circle at center, transparent 0%, rgba(0, 0, 0, 0.2) 100%);
    pointer-events: none;
}

.product-image img {
    max-width: 100%;
    max-height: 75%;
    object-fit: contain;
    filter: grayscale(50%) drop-shadow(0px 2px 4px rgba(0, 0, 0, 0.3));
    opacity: 0.85;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    z-index: 1;
}

.product-card:hover .product-image img {
    filter: grayscale(0) drop-shadow(0px 4px 8px rgba(0, 0, 0, 0.4));
    opacity: 1;
    transform: scale(1.1);
}

.product-info {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.product-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.product-name {
    font-family: "Bebas Neue", sans-serif;
    font-size: 18px;
    font-weight: 400;
    color: #ffffff;
    letter-spacing: 0.5px;
    flex: 1;
    text-shadow: 0px 1px 2px rgba(0, 0, 0, 0.3);
}

.product-price {
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.1) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(21, 21, 21, 0.55);
    background-blend-mode: overlay, normal, color;
    box-shadow: 0px 0.602187px 2.04744px -1.66667px rgba(0, 0, 0, 0.19),
        0px 2.28853px 7.78101px -3.33333px rgba(0, 0, 0, 0.153), 0px 0px 0px 1px #4c4c4c85;
    border-radius: 4px;
    padding: 4px 8px;
    font-family: "Geist", sans-serif;
    font-size: 13px;
    font-weight: 600;
    color: #43a141ab;
}

.product-description {
    font-family: "Geist", sans-serif;
    font-size: 11px;
    font-weight: 400;
    color: #c6c9ca;
    line-height: 1.4;
    margin-bottom: 12px;
    flex: 1;
}

.product-actions {
    display: flex;
    align-items: center;
    gap: 8px;
}

.add-to-cart-btn {
    flex: 1;
    padding: 10px 14px;
    background: linear-gradient(
            135deg,
            rgba(255, 255, 255, 0.08) 0%,
            rgba(255, 255, 255, 0.02) 100%
        ),
        rgba(25, 25, 25, 0.8);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 6px;
    color: #fff;
    font-family: "Bebas Neue", sans-serif;
    font-size: 15px;
    font-weight: 400;
    letter-spacing: 0.5px;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
    box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.3);
    position: relative;
    overflow: hidden;
}

.add-to-cart-btn::before {
    content: "";
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s ease;
}

.add-to-cart-btn:hover::before {
    left: 100%;
}

.add-to-cart-btn:hover {
    border-color: rgba(255, 255, 255, 0.2);
    box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.4), inset 0px 1px 0px rgba(255, 255, 255, 0.1),
        0 12px 32px rgba(255, 255, 255, 0.15);
    background: linear-gradient(
            135deg,
            rgba(255, 255, 255, 0.12) 0%,
            rgba(255, 255, 255, 0.04) 100%
        ),
        rgba(30, 30, 30, 0.9);
}

.shopping-cart {
    width: 360px;
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.08) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(16, 16, 16, 0.9);
    border: 1px solid rgba(255, 255, 255, 0.12);
    border-radius: 12px;
    padding: 24px;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 0px 4px 16px rgba(0, 0, 0, 0.3), inset 0px 1px 0px rgba(255, 255, 255, 0.05);
}

.cart-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
    padding-bottom: 16px;
    border-bottom: 1px solid #5e5e5e;
    position: relative;
}

.cart-title {
    font-family: "Bebas Neue", sans-serif;
    font-size: 20px;
    font-weight: 400;
    letter-spacing: 0.5px;
    display: flex;
    align-items: center;
    gap: 10px;
    text-shadow: 0px 2px 4px rgba(0, 0, 0, 0.3);
}

.cart-count {
    background: linear-gradient(
            135deg,
            rgba(255, 255, 255, 0.12) 0%,
            rgba(255, 255, 255, 0.04) 100%
        ),
        rgba(25, 25, 25, 0.8);
    border: 1px solid rgba(255, 255, 255, 0.15);
    box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.3);
    border-radius: 4px;
    width: 26px;
    height: 26px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: "Geist", sans-serif;
    font-size: 12px;
    font-weight: 700;
}

.cart-description {
    font-family: "Geist", sans-serif;
    font-size: 10px;
    text-align: center;
    font-weight: 400;
    color: #c6c9ca;
    line-height: 1;
    margin-bottom: 20px;
}

.cart-items {
    flex: 1;
    overflow-y: auto;
    margin-bottom: 10px;
    padding-right: 5px;
    min-height: 0;
}

.cart-item {
    display: flex;
    gap: 14px;
    padding: 14px;
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.1) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(50, 50, 50, 0.25);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 8px;
    margin-bottom: 12px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.2);
    position: relative;
}

.cart-item:hover {
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.2) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(50, 50, 50, 0.35);
}

.cart-item-image {
    width: 52px;
    height: 52px;
    /* background: rgba(10, 10, 10, 0.7); */
    border: 1px solid rgba(150, 150, 150, 0.03);
    border-radius: 4px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: inset 0px 2px 8px rgba(0, 0, 0, 0.3);
}

.product-image::after {
    content: "";
    position: absolute;
    inset: 0;
    background: radial-gradient(circle at center, transparent 0%, rgba(0, 0, 0, 0.2) 100%);
    pointer-events: none;
}

.cart-item-image img {
    max-width: 85%;
    max-height: 85%;
    object-fit: contain;
}

.cart-item-details {
    flex: 1;
    min-width: 0;
}

.cart-item-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.cart-item-name {
    font-family: "Bebas Neue", sans-serif;
    font-size: 17px;
    font-weight: 400;
    letter-spacing: 0.3px;
    color: #fff;
    flex: 1;
    text-shadow: 0px 1px 2px rgba(0, 0, 0, 0.3);
}

.cart-item-desc {
    font-family: "Geist", sans-serif;
    font-size: 11px;
    font-weight: 400;
    color: #c6c9ca;
    margin-bottom: 14px;
}

.cart-item-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.cart-item-price {
    font-family: "Geist", sans-serif;
    font-size: 14px;
    font-weight: 600;
    color: #43a141ab;
}

.quantity-controls {
    display: flex;
    align-items: center;
    gap: 6px;
}

.quantity-btn {
    padding: 4px;
    background: linear-gradient(297.02deg, #2f692eab 52.79%, #43a141ab 95.95%),
        rgba(25, 25, 25, 0.75);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 3px;
    color: #fff;
    cursor: pointer;
    transition: all 0.2s ease;
    width: 22px;
    height: 22px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 10px;
    transition: all 0.2s ease-in-out;
}
.quantity-btn.remove {
    background: linear-gradient(297.02deg, #6e2e2e 52.79%, #8b3a3a 95.95%), rgba(25, 25, 25, 0.75);
}

.quantity-btn:hover {
    background: linear-gradient(297.02deg, #377c36ab 52.79%, #4eb64dab 95.95%),
        rgba(25, 25, 25, 0.75);
}

.quantity-btn.remove:hover {
    background: linear-gradient(297.02deg, #833737 52.79%, #a34545 95.95%), rgba(25, 25, 25, 0.75);
}

.quantity {
    font-family: "Geist", sans-serif;
    font-size: 13px;
    font-weight: 600;
    color: #fff;
    min-width: 20px;
    text-align: center;
}

.remove-btn {
    padding: 4px;
    color: #833737;
    cursor: pointer;
    transition: all 0.2s ease;
    font-size: 12px;
}

.remove-btn:hover {
    color: #ff5252;
    transform: scale(1.1);
}

.cart-empty {
    text-align: center;
    color: #c6c9ca;
    padding: 40px 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 10px;
    flex: 1;
    min-height: 200px;
}

.cart-empty i {
    font-size: 48px;
    opacity: 0.3;
}

.cart-empty p {
    margin: 0;
    font-family: "Geist", sans-serif;
    font-size: 13px;
    font-weight: 400;
}

.cart-total {
    border-top: 1px solid #5e5e5e;
    padding-top: 14px;
    margin-bottom: 16px;
}

.total-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.total-label {
    font-family: "Bebas Neue", sans-serif;
    font-size: 20px;
    font-weight: 400;
    letter-spacing: 0.5px;
    color: #c6c9ca;
    text-transform: uppercase;
}

.total-amount {
    font-family: "Bebas Neue", sans-serif;
    font-size: 22px;
    font-weight: 400;
    letter-spacing: 0.5px;
    color: #fff;
    text-shadow: 0px 2px 4px rgba(0, 0, 0, 0.3);
}

.payment-buttons {
    display: flex;
    flex-direction: column;
    gap: 10px;
    margin-top: auto;
}

.payment-btn {
    padding: 10px 18px;
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.02) 100%),
        rgba(25, 25, 25, 0.8);
    border: 1px solid rgba(255, 255, 255, 0.12);
    border-radius: 8px;
    color: #fff;
    font-family: "Bebas Neue", sans-serif;
    font-size: 18px;
    font-weight: 400;
    letter-spacing: 2px;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    box-shadow: 0px 3px 10px rgba(0, 0, 0, 0.3);
    position: relative;
    overflow: hidden;
}

.payment-btn span {
    line-height: 1;
    margin-top: 2.5px;
}

.payment-btn::before {
    content: "";
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s ease;
}

.payment-btn:hover:not(:disabled)::before {
    left: 100%;
}

.payment-btn:hover:not(:disabled) {
    transform: translateY(-1px);
    border-color: rgba(255, 255, 255, 0.2);
    box-shadow: 0px 6px 16px rgba(0, 0, 0, 0.4), inset 0px 1px 0px rgba(255, 255, 255, 0.15), 0 0px 22px rgba(255, 255, 255, 0.05);
    background: linear-gradient(
            135deg,
            rgba(255, 255, 255, 0.15) 0%,
            rgba(255, 255, 255, 0.04) 100%
        ),
        rgba(30, 30, 30, 0.9);
}

.payment-btn:disabled {
    opacity: 0.4;
    cursor: not-allowed;
}

.payment-btn:disabled:hover {
    transform: none;
}

.payment-btn.primary {
    background: linear-gradient(135deg, rgba(100, 200, 100, 0.1) 0%, rgba(100, 200, 100, 0.02) 100%),
        rgba(30, 40, 30, 0.8);
}

.payment-btn.primary:hover:not(:disabled) {
    background: linear-gradient(
            135deg,
            rgba(100, 200, 100, 0.15) 0%,
            rgba(100, 200, 100, 0.04) 100%
        ),
        rgba(35, 45, 35, 0.9);
}

.payment-btn.secondary {
    background: linear-gradient(297.02deg, rgba(255, 0, 0, 0.1) 52.79%, rgba(255, 0, 0, 0.2) 95.95%),
        rgba(40, 20, 20, 0.75);
}

.payment-btn.secondary:hover:not(:disabled) {
    background: linear-gradient(
            297.02deg,
            rgba(255, 0, 0, 0.15) 52.79%,
            rgba(255, 0, 0, 0.25) 95.95%
        ),
        rgba(50, 25, 25, 0.85);
}

.payment-modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.8);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    backdrop-filter: blur(5px);
}

.payment-modal.show {
    opacity: 1;
    visibility: visible;
}

.payment-modal-content {
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.1) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(15, 15, 15, 0.95);
    box-shadow: 0px 8px 30px rgba(0, 0, 0, 0.6), 0px 4px 15px rgba(0, 0, 0, 0.5),
        0px 0px 0px 1px #2c2c2c, inset 0px 1px 0px rgba(255, 255, 255, 0.08);
    border-radius: 12px;
    padding: 48px;
    text-align: center;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    max-width: 450px;
    width: 90%;
    animation: fadeIn 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-30px) scale(0.95);
    }
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
    }
}

.payment-success-icon {
    width: 80px;
    height: 80px;
    background: radial-gradient(
            circle at center,
            rgba(34, 197, 94, 0.25) 0%,
            rgba(34, 197, 94, 0.1) 50%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(34, 197, 94, 0.15);
    border: 2px solid rgba(34, 197, 94, 0.5);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 24px;
    box-shadow: 0px 0px 20px rgba(34, 197, 94, 0.25), inset 0px 1px 0px rgba(255, 255, 255, 0.1);
}

.payment-success-icon i {
    color: #22c55e;
    font-size: 32px;
}

.payment-modal h3 {
    font-family: "Bebas Neue", sans-serif;
    font-size: 32px;
    font-weight: 400;
    letter-spacing: 1px;
    color: #fff;
    margin-bottom: 16px;
    text-shadow: 0px 2px 4px rgba(0, 0, 0, 0.3);
}

.payment-modal p {
    font-family: "Geist", sans-serif;
    font-size: 15px;
    font-weight: 400;
    color: #c6c9ca;
    margin-bottom: 28px;
    line-height: 1.5;
}

.products-grid::-webkit-scrollbar,
.cart-items::-webkit-scrollbar {
    width: 8px;
}

.products-grid::-webkit-scrollbar-track,
.cart-items::-webkit-scrollbar-track {
    background: rgba(0, 0, 0, 0.3);
    border-radius: 4px;
}

.products-grid::-webkit-scrollbar-thumb,
.cart-items::-webkit-scrollbar-thumb {
    background: rgba(255, 255, 255, 0.15);
    border-radius: 4px;
    border: 1px solid rgba(255, 255, 255, 0.05);
}

.products-grid::-webkit-scrollbar-thumb:hover,
.cart-items::-webkit-scrollbar-thumb:hover {
    background: rgba(255, 255, 255, 0.25);
    border-color: rgba(255, 255, 255, 0.1);
}

@media (max-width: 1600px) {
    .weapon-shop-container {
        width: 90vw;
        height: 90vh;
    }
}

@media (max-width: 1200px) {
    .main-content {
        flex-direction: column;
        height: auto;
    }

    .categories-sidebar {
        width: 100%;
        flex-direction: row;
        overflow-x: auto;
    }

    .category-item {
        min-width: 120px;
    }

    .shopping-cart {
        width: 100%;
        max-height: 400px;
    }

    .products-grid {
        grid-template-columns: repeat(3, 1fr);
    }
}

@media (max-width: 900px) {
    .products-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@keyframes flyToCart {
    0% {
        transform: translate(0, 0) scale(1);
        opacity: 1;
    }
    50% {
        transform: translate(
            calc((var(--endX) - 100%) / 2),
            calc((var(--endY) - 100%) / 2)
        ) scale(0.8);
        opacity: 0.8;
    }
    100% {
        transform: translate(
            calc(var(--endX) - 100%),
            calc(var(--endY) - 100%)
        ) scale(0.3);
        opacity: 0;
    }
}

/* Bounce Animation for Cart Count */
.bounce-enter-active {
    animation: bounceIn 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
}

.bounce-leave-active {
    animation: bounceOut 0.3s ease-in;
}

@keyframes bounceIn {
    0% {
        transform: scale(0.3);
        opacity: 0;
    }
    50% {
        transform: scale(1.15);
    }
    100% {
        transform: scale(1);
        opacity: 1;
    }
}

@keyframes bounceOut {
    0% {
        transform: scale(1);
        opacity: 1;
    }
    100% {
        transform: scale(0.3);
        opacity: 0;
    }
}

/* Pulse Animation for Total */
.pulse-enter-active {
    animation: pulseGlow 0.6s ease-out;
}

.pulse-leave-active {
    animation: fadeOut 0.2s ease-in;
}

@keyframes pulseGlow {
    0% {
        transform: scale(1);
        text-shadow: 0px 2px 4px rgba(0, 0, 0, 0.3);
    }
    50% {
        transform: scale(1.1);
        text-shadow: 0px 0px 20px rgba(67, 161, 65, 0.6),
                     0px 2px 4px rgba(0, 0, 0, 0.3);
    }
    100% {
        transform: scale(1);
        text-shadow: 0px 2px 4px rgba(0, 0, 0, 0.3);
    }
}

@keyframes fadeOut {
    from {
        opacity: 1;
    }
    to {
        opacity: 0;
    }
}

/* Empty State Container */
.cart-empty-container {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 200px;
}

/* Warning Icon for Clear Cart Modal */
.payment-warning-icon {
    width: 80px;
    height: 80px;
    background: radial-gradient(
            circle at center,
            rgba(255, 152, 0, 0.25) 0%,
            rgba(255, 152, 0, 0.1) 50%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(255, 152, 0, 0.15);
    border: 2px solid rgba(255, 152, 0, 0.5);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 24px;
    box-shadow: 0px 0px 20px rgba(255, 152, 0, 0.25), inset 0px 1px 0px rgba(255, 255, 255, 0.1);
}

.payment-warning-icon i {
    color: #ff9800;
    font-size: 32px;
}

/* Modal Buttons Container */
.modal-buttons {
    display: flex;
    gap: 12px;
    justify-content: center;
}

.modal-buttons .payment-btn {
    flex: 1;
    min-width: 140px;
}

/* Disabled button state improvement */
.payment-btn:disabled {
    opacity: 0.3;
    cursor: not-allowed;
    filter: grayscale(60%);
}

/* Payment Method Panel Styles */
.payment-method-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.6);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
    opacity: 0;
    visibility: hidden;
    transition: all 0.25s ease;
    backdrop-filter: blur(4px);
}

.payment-method-overlay.show {
    opacity: 1;
    visibility: visible;
}

.payment-method-panel {
    width: 340px;
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.08) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(16, 16, 16, 0.95);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.5), 0px 8px 40px rgba(0, 0, 0, 0.4),
        inset 0px 1px 0px rgba(255, 255, 255, 0.05);
    animation: slideIn 0.25s ease;
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(-20px) scale(0.98);
    }
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
    }
}

.payment-method-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 16px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.08);
    margin-bottom: 16px;
}

.payment-method-title {
    display: flex;
    align-items: center;
    gap: 10px;
    font-family: "Bebas Neue", sans-serif;
    font-size: 20px;
    font-weight: 400;
    letter-spacing: 0.5px;
    color: #fff;
}

.payment-method-title i {
    font-size: 16px;
    color: rgba(255, 255, 255, 0.6);
}

.payment-method-close {
    width: 28px;
    height: 28px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 6px;
    color: rgba(255, 255, 255, 0.5);
    cursor: pointer;
    transition: all 0.2s ease;
    font-size: 12px;
}

.payment-method-close:hover {
    background: rgba(255, 80, 80, 0.15);
    border-color: rgba(255, 80, 80, 0.3);
    color: #ff5252;
}

.payment-method-amount {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 14px 16px;
    background: rgba(255, 255, 255, 0.03);
    border: 1px solid rgba(255, 255, 255, 0.06);
    border-radius: 8px;
    margin-bottom: 16px;
}

.amount-label {
    font-family: "Geist", sans-serif;
    font-size: 12px;
    font-weight: 400;
    color: rgba(255, 255, 255, 0.5);
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.amount-value {
    font-family: "Bebas Neue", sans-serif;
    font-size: 24px;
    font-weight: 400;
    color: #fff;
    letter-spacing: 0.5px;
}

.payment-method-options {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.payment-option {
    display: flex;
    align-items: center;
    gap: 14px;
    padding: 14px 16px;
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.05) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(25, 25, 25, 0.6);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.2s ease;
}

.payment-option:hover {
    background: radial-gradient(
            120.1% 120.1% at 115.34% -20.1%,
            rgba(255, 255, 255, 0.1) 0%,
            rgba(0, 0, 0, 0) 100%
        ),
        rgba(35, 35, 35, 0.8);
    border-color: rgba(255, 255, 255, 0.15);
}

.payment-option:active {
    transform: scale(0.98);
}

.payment-option-icon {
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 8px;
    font-size: 16px;
}

.payment-option-icon.cash {
    background: linear-gradient(135deg, rgba(34, 197, 94, 0.2) 0%, rgba(34, 197, 94, 0.1) 100%);
    border: 1px solid rgba(34, 197, 94, 0.3);
    color: #22c55e;
}

.payment-option-icon.bank {
    background: linear-gradient(135deg, rgba(59, 130, 246, 0.2) 0%, rgba(59, 130, 246, 0.1) 100%);
    border: 1px solid rgba(59, 130, 246, 0.3);
    color: #3b82f6;
}

.payment-option-info {
    flex: 1;
}

.payment-option-name {
    font-family: "Bebas Neue", sans-serif;
    font-size: 16px;
    font-weight: 400;
    color: #fff;
    letter-spacing: 0.3px;
    line-height: 1;
    margin-bottom: 4px;
}

.payment-option-desc {
    font-family: "Geist", sans-serif;
    font-size: 11px;
    font-weight: 400;
    color: rgba(255, 255, 255, 0.4);
}

.payment-option-arrow {
    color: rgba(255, 255, 255, 0.2);
    font-size: 12px;
    transition: all 0.2s ease;
}

.payment-option:hover .payment-option-arrow {
    color: rgba(255, 255, 255, 0.5);
    transform: translateX(2px);
}

</style>

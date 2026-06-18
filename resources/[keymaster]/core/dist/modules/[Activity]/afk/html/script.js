/**
 * =============================================
 * NEVA - AFK SYSTEM JAVASCRIPT
 * =============================================
 */

// Configuration
let config = {
    position: 'bottom-right',
    theme: 'dark',
    opacity: 0.9,
    showTimer: true,
    showEarnings: true,
    showNextReward: true,
    showVIPStatus: true,
    showLeaderboard: true,
    showExitInfo: true,
    exitKey: 'E',
    rewardInterval: 60
};

// Elements
const overlay = document.getElementById('afk-overlay');
const vipBadge = document.getElementById('vip-badge');
const timerBox = document.getElementById('timer-box');
const earningsBox = document.getElementById('earnings-box');
const multiplierBox = document.getElementById('multiplier-box');
const nextRewardBox = document.getElementById('next-reward-box');
const miniLeaderboard = document.getElementById('mini-leaderboard');
const exitInfo = document.getElementById('exit-info');
const exitKeyDisplay = document.getElementById('exit-key');
const leaderboardPopup = document.getElementById('leaderboard-popup');

// Stats elements
const afkTimer = document.getElementById('afk-timer');
const afkEarnings = document.getElementById('afk-earnings');
const afkMultiplier = document.getElementById('afk-multiplier');
const nextReward = document.getElementById('next-reward');
const rewardProgress = document.getElementById('reward-progress');
const leaderboardList = document.getElementById('leaderboard-list');
const leaderboardTableBody = document.getElementById('leaderboard-table-body');

/**
 * Initialize overlay with config
 */
function initOverlay(cfg) {
    if (!overlay) return;
    
    config = { ...config, ...cfg };

    // Set position
    overlay.className = 'afk-overlay ' + config.position;

    // Set theme
    if (config.theme === 'light') {
        overlay.classList.add('light');
    }

    // Set opacity
    overlay.style.opacity = config.opacity;

    // Show/hide elements
    if (timerBox && !config.showTimer) timerBox.classList.add('hidden');
    if (earningsBox && !config.showEarnings) earningsBox.classList.add('hidden');
    if (nextRewardBox && !config.showNextReward) nextRewardBox.classList.add('hidden');
    if (miniLeaderboard && !config.showLeaderboard) miniLeaderboard.classList.add('hidden');
    if (exitInfo && !config.showExitInfo) exitInfo.classList.add('hidden');

    // Set exit key
    if (exitKeyDisplay) exitKeyDisplay.textContent = config.exitKey;
}

/**
 * Toggle overlay visibility
 */
function toggleOverlay(show) {
    if (!overlay) return;
    
    if (show) {
        overlay.classList.remove('hidden');
    } else {
        overlay.classList.add('hidden');
    }
}

/**
 * Update stats display
 */
function updateStats(stats) {
    if (!afkTimer || !afkEarnings || !afkMultiplier) return;
    
    if (afkTimer) afkTimer.textContent = stats.duration || '00:00';
    if (afkEarnings) afkEarnings.textContent = stats.earnings || '$0';
    if (afkMultiplier) afkMultiplier.textContent = stats.multiplier || 'x1.0';

    // Update next reward
    if (stats.nextReward !== undefined && nextReward && rewardProgress) {
        nextReward.textContent = stats.nextReward + 's';

        // Update progress bar
        const progress = ((config.rewardInterval - stats.nextReward) / config.rewardInterval) * 100;
        rewardProgress.style.width = progress + '%';
    }

    // Show/hide VIP badge
    if (vipBadge) {
        if (stats.isVIP && config.showVIPStatus) {
            vipBadge.classList.remove('hidden');
        } else {
            vipBadge.classList.add('hidden');
        }
    }
}

/**
 * Update mini leaderboard
 */
function updateLeaderboard(data) {
    if (!leaderboardList) return;

    leaderboardList.innerHTML = '';

    // Show only top 5 in mini view
    const topPlayers = data.slice(0, 5);

    topPlayers.forEach((player, index) => {
        const entry = document.createElement('div');
        entry.className = 'leaderboard-entry';

        if (index === 0) entry.classList.add('top-1');
        else if (index === 1) entry.classList.add('top-2');
        else if (index === 2) entry.classList.add('top-3');

        entry.innerHTML = `
            <span class="entry-rank">${index + 1}</span>
            <span class="entry-name">${player.name}</span>
            <span class="entry-time">${player.time}</span>
        `;

        leaderboardList.appendChild(entry);
    });
}

/**
 * Show leaderboard popup
 */
function showLeaderboardPopup(data) {
    if (!leaderboardTableBody || !leaderboardPopup) {
        return;
    }
    
    if (!data || !Array.isArray(data) || data.length === 0) {
        return;
    }

    leaderboardTableBody.innerHTML = '';

    data.forEach((player, index) => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${index + 1}</td>
            <td>${player.name || 'Inconnu'}</td>
            <td>${player.time || '0h 00m'}</td>
            <td>${player.earnings || '$0'}</td>
        `;
        leaderboardTableBody.appendChild(row);
    });

    leaderboardPopup.classList.remove('hidden');
}

/**
 * Hide leaderboard popup
 */
function hideLeaderboardPopup() {
    leaderboardPopup.classList.add('hidden');
    // Notify Lua to disable NUI focus
    fetch(`https://${GetParentResourceName()}/closeLeaderboard`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({})
    });
}

/**
 * NUI Message Handler
 */
window.addEventListener('message', (event) => {
    const data = event.data;

    switch (data.action) {
        case 'toggleOverlay':
            if (data.config) {
                initOverlay(data.config);
                if (data.config.rewardInterval) {
                    config.rewardInterval = data.config.rewardInterval || 60;
                }
            }
            toggleOverlay(data.show);
            break;

        case 'updateStats':
            updateStats(data.stats);
            break;

        case 'updateLeaderboard':
            updateLeaderboard(data.leaderboard);
            break;

        case 'showLeaderboardPopup':
            showLeaderboardPopup(data.leaderboard);
            break;

        case 'hideLeaderboardPopup':
            hideLeaderboardPopup();
            break;
    }
});

/**
 * Event Listeners
 */

// Close leaderboard popup
document.getElementById('close-leaderboard')?.addEventListener('click', hideLeaderboardPopup);

// Close on popup overlay click
document.querySelector('.popup-overlay')?.addEventListener('click', hideLeaderboardPopup);

// ESC key to close popup
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' || e.keyCode === 27) {
        if (leaderboardPopup && !leaderboardPopup.classList.contains('hidden')) {
            hideLeaderboardPopup();
        }
    }
});

/**
 * Get parent resource name (FiveM)
 * Sauvegarde de la fonction native avant de créer le fallback
 */
const nativeGetParentResourceName = window.GetParentResourceName;

/**
 * Get parent resource name (FiveM) with fallback
 */
function GetParentResourceName() {
    if (typeof nativeGetParentResourceName === 'function') {
        try {
            return nativeGetParentResourceName();
        } catch (e) {
            return 'core';
        }
    }
    
    return 'core';
}

// Script loaded

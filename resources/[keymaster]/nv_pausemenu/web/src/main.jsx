import React, {
    useCallback,
    useEffect,
    useMemo,
    useRef,
    useState,
} from 'react';
import { createRoot } from 'react-dom/client';
import './index.css';

const defaultPlayerData = {
    playerId: '0',
    bankMoney: 0,
    cash: 0,
    job: 'promoteur',
    playerName: 'John Doe',
};

const DEFAULT_MEDIA = Object.freeze({
    images: {
        logoSmall: 'media/logo.png',
        logoLarge: 'media/logo.png',
        background: '',
        avatar: '',
    },
    avatarIcon: 'fas fa-user',
    sounds: {
        hover: 'media/woosh.mp3',
        click: 'media/enter.mp3',
        open: 'media/wind.mp3',
    },
    buttons: [
        { id: 'mapButton', icon: 'fas fa-map icon', action: 'map', type: 'callback' },
        { id: 'settingsButton', icon: 'fas fa-gear icon', action: 'settings', type: 'callback' },
        { id: 'discordButton', icon: 'fab fa-discord icon', type: 'discord' },
        { id: 'webButton', icon: 'fa-solid fa-basket-shopping', action: 'shop', type: 'callback' },
    ],
});

const resolveMediaPath = (value, fallback = '') => {
    const target = value || fallback;
    if (!target) return '';

    if (/^(?:https?:|nui:|data:)/i.test(target)) {
        return target;
    }

    try {
        return new URL(target, window.location.href).href;
    } catch {
        return target;
    }
};

const formatMoney = (value) => {
    const numeric = Number(String(value ?? 0).replace(/\s/g, ''));

    if (Number.isNaN(numeric)) {
        return '0';
    }

    return numeric
        .toString()
        .replace(/\B(?=(\d{3})+(?!\d))/g, ' ');
};

const App = () => {
    const [playerData, setPlayerData] = useState(defaultPlayerData);
    const [discord, setDiscord] = useState('');
    const [media, setMedia] = useState(DEFAULT_MEDIA);
    const [isContainerVisible, setIsContainerVisible] = useState(false);
    const [animationClass, setAnimationClass] = useState('');
    const [isMenuActive, setIsMenuActive] = useState(false);
    const [tooltip, setTooltip] = useState({
        visible: false,
        text: '',
        x: 0,
        y: 0,
    });

    const closeTimeoutRef = useRef(null);
    const hoverSoundRef = useRef(null);
    const clickSoundRef = useRef(null);

    useEffect(() => {
        const sounds = media?.sounds || {};

        const hoverPath = resolveMediaPath(sounds.hover, DEFAULT_MEDIA.sounds.hover);
        const clickPath = resolveMediaPath(sounds.click, DEFAULT_MEDIA.sounds.click);

        const hover = hoverPath ? new Audio(hoverPath) : null;
        const click = clickPath ? new Audio(clickPath) : null;

        if (hover) hover.volume = 0.15;
        if (click) click.volume = 0.2;

        hoverSoundRef.current = hover;
        clickSoundRef.current = click;

        return () => {
            [hoverSoundRef, clickSoundRef].forEach((ref) => {
                if (ref.current) {
                    ref.current.pause();
                    ref.current.currentTime = 0;
                    ref.current = null;
                }
            });
        };
    }, [media]);

    const updatePlayerData = useCallback((updater) => {
        setPlayerData((prev) => {
            const nextValues = typeof updater === 'function' ? updater(prev) : updater;
            return { ...prev, ...nextValues };
        });
    }, []);

    const copyToClipboard = useCallback((text) => {
        if (!text) return;

        if (navigator.clipboard?.writeText) {
            navigator.clipboard.writeText(text).catch(() => {});
            return;
        }

        const textArea = document.createElement('textarea');
        textArea.value = text;
        textArea.style.position = 'fixed';
        textArea.style.left = '-999999px';
        textArea.style.top = '-999999px';
        document.body.appendChild(textArea);
        textArea.focus();
        textArea.select();

        try {
            document.execCommand('copy');
        } catch (err) {
            console.error('Failed to copy:', err);
        } finally {
            textArea.remove();
        }
    }, []);

    const openExternalLink = useCallback((url) => {
        if (!url) return;

        try {
            if (window.invokeNative) {
                window.invokeNative('openUrl', url);
                return;
            }

            const popup = window.open(url, '_blank');
            if (!popup || popup.closed || typeof popup.closed === 'undefined') {
                copyToClipboard(url);
            }
        } catch (err) {
            console.error('Unable to open external link:', err);
            copyToClipboard(url);
        }
    }, [copyToClipboard]);

    const playSound = useCallback((ref) => {
        if (!ref.current) return;

        try {
            ref.current.currentTime = 0;
            const playPromise = ref.current.play();
            if (playPromise?.catch) {
                playPromise.catch(() => {});
            }
        } catch (err) {
            console.error('Audio playback failed:', err);
        }
    }, []);

    const playHoverSound = useCallback(() => {
        playSound(hoverSoundRef);
    }, [playSound]);

    const playClickSound = useCallback(() => {
        playSound(clickSoundRef);
    }, [playSound]);

    const playOpenSound = useCallback((overridePath) => {
        const path = overridePath || resolveMediaPath(media.sounds?.open, DEFAULT_MEDIA.sounds.open);
        if (!path) return;

        try {
            const audio = new Audio(path);
            audio.volume = 0.2;
            const playPromise = audio.play();
            if (playPromise?.catch) {
                playPromise.catch(() => {});
            }
        } catch (err) {
            console.error('Audio playback failed:', err);
        }
    }, [media]);

    const sendCallback = useCallback((action, data = {}) => {
        if (!action) return;

        fetch(`https://nv_pausemenu/${action}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        }).catch(() => {});
    }, []);

    const triggerCloseAnimation = useCallback(() => {
        setAnimationClass('close');
        setIsMenuActive(false);

        if (closeTimeoutRef.current) {
            clearTimeout(closeTimeoutRef.current);
        }

        closeTimeoutRef.current = setTimeout(() => {
            setIsContainerVisible(false);
            setAnimationClass('');
        }, 300);
    }, []);

    const mergeMediaPayload = useCallback((payload) => {
        if (!payload) {
            return DEFAULT_MEDIA;
        }

        const mergedImages = {
            ...DEFAULT_MEDIA.images,
            ...(payload.images || {}),
        };

        const mergedSounds = {
            ...DEFAULT_MEDIA.sounds,
            ...(payload.sounds || {}),
        };

        const mergedButtons = Array.isArray(payload.buttons) && payload.buttons.length > 0
            ? payload.buttons
            : DEFAULT_MEDIA.buttons;

        return {
            ...DEFAULT_MEDIA,
            ...payload,
            images: mergedImages,
            sounds: mergedSounds,
            buttons: mergedButtons,
        };
    }, []);

    const handleOpen = useCallback((data) => {
        if (closeTimeoutRef.current) {
            clearTimeout(closeTimeoutRef.current);
            closeTimeoutRef.current = null;
        }

        if (data.discord !== undefined) setDiscord(data.discord || '');
        const nextMedia = mergeMediaPayload(data.media);
        setMedia(nextMedia);

        updatePlayerData((prev) => ({
            playerId: data.id ?? prev.playerId,
            cash: data.cash ?? prev.cash,
            bankMoney: data.money ?? prev.bankMoney,
            job: data.job ?? prev.job,
            playerName: data.playerName ?? prev.playerName,
        }));

        setIsContainerVisible(true);
        setAnimationClass('open');
        setIsMenuActive(true);
        const openPathOverride = resolveMediaPath(
            data.media?.sounds?.open,
            nextMedia.sounds?.open || DEFAULT_MEDIA.sounds.open
        );
        playOpenSound(openPathOverride);
    }, [mergeMediaPayload, playOpenSound, updatePlayerData]);

    const handleClose = useCallback(() => {
        triggerCloseAnimation();
    }, [triggerCloseAnimation]);

    const handleMessage = useCallback((event) => {
        const data = event.data;
        if (!data || !data.type) return;

        switch (data.type) {
            case 'open':
                handleOpen(data);
                break;
            case 'close':
                handleClose();
                break;
            case 'updateMoney':
                updatePlayerData({ bankMoney: data.money });
                break;
            case 'updateCash':
                updatePlayerData({ cash: data.cash });
                break;
            case 'updateJob':
                updatePlayerData({ job: data.job });
                break;
            case 'updatePlayerName':
                updatePlayerData({ playerName: data.playerName });
                break;
            default:
                break;
        }
    }, [handleClose, handleOpen, updatePlayerData]);

    useEffect(() => {
        window.addEventListener('message', handleMessage);
        return () => window.removeEventListener('message', handleMessage);
    }, [handleMessage]);

    useEffect(() => {
        if (!isMenuActive) return undefined;

        const handleKeyDown = (event) => {
            const key = event.key?.toUpperCase();
            if (key === 'ESCAPE') {
                sendCallback('closePause');
            } else if (key === 'M') {
                sendCallback('map');
            } else if (key === 'P') {
                sendCallback('settings');
            }
        };

        document.addEventListener('keydown', handleKeyDown);
        return () => document.removeEventListener('keydown', handleKeyDown);
    }, [isMenuActive, sendCallback]);

    useEffect(() => {
        return () => {
            if (closeTimeoutRef.current) {
                clearTimeout(closeTimeoutRef.current);
            }
        };
    }, []);

    const handleBentoHover = useCallback(() => {
        playHoverSound();
    }, [playHoverSound]);

    const showTooltip = useCallback((text, event) => {
        if (!text) return;
        setTooltip({
            visible: true,
            text,
            x: event.clientX,
            y: event.clientY,
        });
    }, []);

    const moveTooltip = useCallback((event) => {
        setTooltip((prev) => {
            if (!prev.visible) return prev;
            return {
                ...prev,
                x: event.clientX,
                y: event.clientY,
            };
        });
    }, []);

    const hideTooltip = useCallback(() => {
        setTooltip((prev) => (prev.visible ? { ...prev, visible: false } : prev));
    }, []);

    const handleBentoClick = useCallback((card) => {
        hideTooltip();
        playClickSound();

        if (card.type === 'discord') {
            if (discord) {
                openExternalLink(discord);
            }
            return;
        }

        if (card.action) {
            sendCallback(card.action);
        }
    }, [discord, hideTooltip, openExternalLink, playClickSound, sendCallback]);

    const formattedCash = useMemo(() => formatMoney(playerData.cash), [playerData.cash]);
    const formattedBank = useMemo(() => formatMoney(playerData.bankMoney), [playerData.bankMoney]);

    const logoSmallSrc = resolveMediaPath(media.images?.logoSmall, DEFAULT_MEDIA.images.logoSmall);
    const logoLargeSrc = resolveMediaPath(media.images?.logoLarge, DEFAULT_MEDIA.images.logoLarge);
    const avatarImageSrc = resolveMediaPath(media.images?.avatar);
    const avatarIconClass = media.avatarIcon || DEFAULT_MEDIA.avatarIcon;
    const backgroundSrc = resolveMediaPath(media.images?.background);
    const backgroundStyle = backgroundSrc ? { backgroundImage: `url(${backgroundSrc})` } : undefined;
    const cards = Array.isArray(media.buttons) && media.buttons.length > 0
        ? media.buttons
        : DEFAULT_MEDIA.buttons;

    return (
        <div className={`container ${isContainerVisible ? '' : 'hidden'}`} id="container">
            <div className={`pause-menu ${animationClass}`} id="pauseMenu">
                <div className="background-image" style={backgroundStyle}></div>

                <div className="header-left">
                    <div className="avatar-container">
                        {avatarImageSrc ? (
                            <img src={avatarImageSrc} alt="" className="avatar-image" />
                        ) : (
                            <i className={`avatar-icon ${avatarIconClass}`}></i>
                        )}
                    </div>
                    <div className="player-info">
                        <div className="info-item">
                            <span className="info-label">CASH :</span>
                            <span className="info-value" id="cashText">
                                ${formattedCash}
                            </span>
                        </div>
                        <div className="info-item">
                            <span className="info-label">BANQUE :</span>
                            <span className="info-value" id="bankMoneyText">
                                ${formattedBank}
                            </span>
                        </div>
                        <div className="info-item">
                            <span className="info-label">JOB :</span>
                            <span className="info-value" id="jobText">
                                {playerData.job || 'promoteur'}
                            </span>
                        </div>
                    </div>
                </div>

                <div className="header-right">
                    <div className="logo-container">
                        <img src={logoSmallSrc} alt="" className="logo-small" />
                    </div>
                    <div className="player-header-info">
                        <div className="player-name" id="playerNameText">
                            {playerData.playerName || 'John Doe'}
                        </div>
                        <div className="player-id" id="playerIdText">
                            id joueur : {playerData.playerId || '0'}
                        </div>
                    </div>
                </div>

                <div className="logo-center">
                    <img src={logoLargeSrc} alt="" className="logo-large" />
                </div>

                <div className="bottom-buttons">
                    {cards.map((card) => (
                        <div
                            key={card.id}
                            className="bento-card"
                            id={card.id}
                            onMouseEnter={(e) => {
                                handleBentoHover();
                                showTooltip(card.label, e);
                            }}
                            onMouseMove={moveTooltip}
                            onMouseLeave={hideTooltip}
                            onClick={() => handleBentoClick(card)}
                        >
                            <i className={card.icon}></i>
                        </div>
                    ))}
                </div>
            </div>
            <div
                className={`bottom-tooltip ${tooltip.visible ? 'visible' : ''}`}
                style={{ left: tooltip.x, top: tooltip.y }}
            >
                {tooltip.text}
            </div>
        </div>
    );
};

const rootElement = document.getElementById('root');
const root = createRoot(rootElement);
root.render(React.createElement(App));


Config = {}

Config.Discord = 'https://discord.gg/neva-fivem'

Config.MapKey = 'M'

Config.Media = {
    images = {
        logoSmall = 'media/logo.png',
        logoLarge = 'media/logo.png',
        background = '',
        avatar = '',
    },
    avatarIcon = 'fas fa-user',
    sounds = {
        hover = 'media/woosh.mp3',
        click = 'media/enter.mp3',
        open = 'media/wind.mp3'
    },
    buttons = {
        { id = 'mapButton', icon = 'fas fa-map icon', action = 'map', type = 'callback', label = 'Ouvrir la carte' },
        { id = 'settingsButton', icon = 'fas fa-gear icon', action = 'settings', type = 'callback', label = 'Options' },
        { id = 'discordButton', icon = 'fab fa-discord icon', type = 'discord', label = 'Discord' },
        { id = 'webButton', icon = 'fa-solid fa-cart-shopping icon', action = 'shop', type = 'callback', label = 'Boutique' }
    }
}

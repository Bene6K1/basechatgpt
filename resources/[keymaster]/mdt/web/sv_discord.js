const SVConfig = exports[GetCurrentResourceName()].GetConfig()
const { Discord } = require("discord-id");
const Client = new Discord(SVConfig.discordToken);

const SteamAPI = require('steamapi');
const ServerSteamAPI = GetConvar('steam_webApiKey', 'none')
const steam = new SteamAPI(ServerSteamAPI);

const GetIdentifier = (source, id) => {
    return exports[GetCurrentResourceName()].GetIdentifier(source, id)
};


async function GrabDiscord(id) {
    var discordid = GetIdentifier(id, 'discord')
    if (!discordid) return null;
    discordid = discordid.replace('discord:', '')
    if (!discordid) return null;
    var user = null;
    try {
        user = await Client.grabProfile(discordid);
    } catch (error) {
        console.log('Discord API Error: ' + error)
    }

    return user;
}

// https://stackoverflow.com/questions/12532871/how-to-convert-a-very-large-hex-number-to-decimal-in-javascript
function hexToDec(s) {
    function add(x, y) {
        var c = 0, r = [];
        var x = x.split('').map(Number);
        var y = y.split('').map(Number);
        while(x.length || y.length) {
            var s = (x.pop() || 0) + (y.pop() || 0) + c;
            r.unshift(s < 10 ? s : s - 10); 
            c = s < 10 ? 0 : 1;
        }
        if(c) r.unshift(c);
        return r.join('');
    }

    var dec = '0';
    s.split('').forEach(function(chr) {
        var n = parseInt(chr, 16);
        for(var t = 8; t; t >>= 1) {
            dec = add(dec, dec);
            if(n & t) dec = add(dec, '1');
        }
    });
    return dec;
}

async function GrabSteam(id) {
    if (ServerSteamAPI == 'none') {
        console.log('No steam_webApiKey found, please add to your config.')
        return null;
    }
    var steamid = GetIdentifier(id, 'steam')
    if (!steamid) return null;
    steamid = hexToDec(steamid.replace('steam:', ''))
    
    if (!steamid) return null;
    var user = null;
    try {
        user = await steam.getUserSummary(steamid);
    } catch (error) {
        console.log('Steam API Error: ' + error)
    }

    return user;
}

exports('GrabDiscordPP', async (playerid) => {
    const user = await GrabDiscord(playerid)
    return user?.avatar.url
})

exports('GrabSteamPP', async (playerid) => {
    const user = await GrabSteam(playerid)
    return user?.avatar.large
})
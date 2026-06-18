RegisterNetEvent('SHOW_NOTIFTOP')
AddEventHandler('SHOW_NOTIFTOP', function(show, text, icon, bordercolor)

    text = text or ""
    icon = icon or ""
    bordercolor = bordercolor or "#FFFFFF"

    SendReactMessage('SHOW_DRAWTOPNOTIF', {
        show = show,
        text = text,
        icon = icon,
        bordercolor = bordercolor
    })
end)

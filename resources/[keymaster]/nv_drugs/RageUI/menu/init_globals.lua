
Items = Items or {}
Panels = Panels or {}
ServerFontStyle = 1

Citizen.CreateThread(function()
    RegisterFontFile('FontStyle')
    ServerFontStyle = RegisterFontId('FontStyle')
end)

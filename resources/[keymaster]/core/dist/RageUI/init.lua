Config = Config or {}

Config.RageUI = {
  arrondi = true,
  simpleBar = true,
  hideNavigation = true,
  hideDescription = false,
  -- Vertical offset applied to the items block (negative = closer to subtitle)
  itemsOffsetY = -6,
  -- Base Y added to every item row (Button/List/Checkbox). Lower = more "collé" to the subtitle.
  itemBaseY = 20,
  -- Amount removed from the subtitle height before items start (higher = more collé)
  subtitleItemGap = 20,
  -- Left padding for item labels/badges
  itemPaddingX = 10,
  -- Checkbox sprite size (in pixels).
  checkboxSize = 34,
  buttonBackground = { R = 35, G = 35, B = 35, A = 0 },
  buttonBorderThickness = 1,
  buttonBorderAlpha = 220,
  -- Outline-only selection; use a classic rectangle outline
  buttonOutlineRadius = 12,
  buttonOutlineRounded = false,
  hoverColor = {
    R = GetConvarInt("unddreal_color_r", 237),
    G = GetConvarInt("unddreal_color_g", 28),
    B = GetConvarInt("unddreal_color_b", 36),
    A = 120,
  },
}

Config.RageUI.color = Config.RageUI.color or Config.RageUI.hoverColor

CreateThread(function()
  RegisterFontFile("FontStyle")
  ServerFontStyle = RegisterFontId("FontStyle")
end)

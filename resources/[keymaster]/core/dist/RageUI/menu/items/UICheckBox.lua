
---@type table
local SettingsButton = {
  Rectangle = { Y = 0, Width = 500, Height = 43 },
  Text = { X = 0, Y = 4, Scale = 0.25 },
  LeftBadge = { Y = 20, Width = 40, Height = 40 },
  RightBadge = { X = 373, Y = 9, Width = 20, Height = 20 },
  RightText = { X = 420, Y = 1, Scale = 0.23 },
  SelectedSprite = {
    Dictionary = "utils",
    Texture = "gradient_nav",
    Y = 0,
    Width = 440,
    Height = 38,
  },
}

---@type table
local SettingsCheckbox = {
  -- Use vanilla GTA/FiveM texture dict for performance (handles large lists smoothly)
  Dictionary = "commonmenu",
  Textures = {
    Blank = "shop_box_blank",
    Tick = "shop_box_tick",
    Cross = "shop_box_cross",
  },
  Y = 9,
  Width = 24,
  Height = 24,
}

-- Keep an immutable base size so scaling doesn't compound across rows.
SettingsCheckbox.BaseSize = SettingsCheckbox.BaseSize or math.max(SettingsCheckbox.Width or 20, SettingsCheckbox.Height or 20)

RageUI.CheckboxStyle = RageUI.CheckboxStyle or {
  Tick = 1,
  Cross = 2,
}

local function StyleCheckBox(Selected, Checked, Box, BoxSelect, OffSet)
  local CurrentMenu = RageUI.CurrentMenu
  if CurrentMenu == nil or not CurrentMenu() then
    return
  end

  local ItemsOffsetY = (Config and Config.RageUI and Config.RageUI.itemsOffsetY) or 0
  local ItemBaseY = (Config and Config.RageUI and Config.RageUI.itemBaseY) or 20
  local baseWidth = RageUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset
  local checkboxX = CurrentMenu.X + baseWidth - SettingsCheckbox.Width - 8 - (OffSet or 0)

  -- Center checkbox within the row for consistent alignment
  local rowY = CurrentMenu.Y + ItemBaseY + ItemsOffsetY + (SettingsButton.SelectedSprite.Y or 0) + CurrentMenu.SubtitleHeight + RageUI.ItemOffset
  local rowH = (SettingsButton.SelectedSprite.Height or SettingsButton.Rectangle.Height) - 1
  local checkboxY = rowY + math.floor(((rowH - SettingsCheckbox.Height) / 2) + 0.5)

  local c = (SunnyConfigServ and SunnyConfigServ.RageUI and SunnyConfigServ.RageUI.gradientColor)
    or (Config and Config.RageUI and (Config.RageUI.hoverColor or Config.RageUI.color))
    or { R = 237, G = 28, B = 36, A = 255 }

  local dict = SettingsCheckbox.Dictionary
  local textures = SettingsCheckbox.Textures or {}
  local isCross = (Box == 5) or (BoxSelect == 6)
  local texture
  if Checked then
    texture = isCross and (textures.Cross or "shop_box_cross") or (textures.Tick or "shop_box_tick")
    -- Tint the checked icon with the theme color
    RenderSprite(dict, texture, checkboxX, checkboxY, SettingsCheckbox.Width, SettingsCheckbox.Height, 0, c.R, c.G, c.B, 255)
  else
    texture = textures.Blank or "shop_box_blank"
    RenderSprite(dict, texture, checkboxX, checkboxY, SettingsCheckbox.Width, SettingsCheckbox.Height, 0, 255, 255, 255, 200)
  end
end

function RageUI.Checkbox(Label, Description, Checked, Style, Actions)
  local CurrentMenu = RageUI.CurrentMenu
  if CurrentMenu == nil or not CurrentMenu() then
    return
  end

  Style = Style or {}
  Actions = Actions or {}

  local Option = RageUI.Options + 1
  if CurrentMenu.Pagination.Minimum > Option or CurrentMenu.Pagination.Maximum < Option then
    RageUI.Options = RageUI.Options + 1
    return
  end

  local Selected = (CurrentMenu.Index == Option)
  local enabled = (Style.Enabled == true or Style.Enabled == nil)

  RageUI.ItemsSafeZone(CurrentMenu)

  local ItemsOffsetY = (Config and Config.RageUI and Config.RageUI.itemsOffsetY) or 0
  local ItemBaseY = (Config and Config.RageUI and Config.RageUI.itemBaseY) or 20
  local ItemPaddingX = (Config and Config.RageUI and Config.RageUI.itemPaddingX) or 2

  -- Allow larger checkboxes without overlapping rows.
  local checkboxSize = (Config and Config.RageUI and tonumber(Config.RageUI.checkboxSize))
    or (SettingsCheckbox.BaseSize * 1.5)
  checkboxSize = math.max(12, math.floor(checkboxSize + 0.5))
  SettingsCheckbox.Width = checkboxSize
  SettingsCheckbox.Height = checkboxSize

  -- Grow ONLY the checkbox row height to fit the larger checkbox.
  local baseRowHeight = 43
  local rowHeight = math.max(baseRowHeight, checkboxSize + 16)
  SettingsButton.Rectangle.Height = rowHeight
  SettingsButton.SelectedSprite.Height = rowHeight - 5
  local extraTextY = math.floor(((rowHeight - baseRowHeight) / 2) + 0.5)

  local Hovered = false
  if CurrentMenu.EnableMouse == true and (CurrentMenu.CursorStyle == 0 or CurrentMenu.CursorStyle == 1) then
    Hovered = RageUI.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton)
  end

  local LeftBadgeOffset = ((Style.LeftBadge == RageUI.BadgeStyle.None or Style.LeftBadge == nil) and 0 or 27)
  local RightBadgeOffset = ((Style.RightBadge == RageUI.BadgeStyle.None or Style.RightBadge == nil) and 0 or 32)

  local boxX = CurrentMenu.X
  local boxY =
    CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset
  local baseWidth = RageUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset
  local boxW = baseWidth
  local boxH = SettingsButton.SelectedSprite.Height - 1

  if enabled then
    local bg = (Config and Config.RageUI and Config.RageUI.buttonBackground) or { R = 25, G = 25, B = 25, A = 150 }
    local bgR, bgG, bgB, bgA = bg.R or 25, bg.G or 25, bg.B or 25, bg.A or 150

    local c = (Config and Config.RageUI and (Config.RageUI.hoverColor or Config.RageUI.color))
      or { R = 237, G = 28, B = 36, A = 255 }
    local g = (SunnyConfigServ and SunnyConfigServ.RageUI and SunnyConfigServ.RageUI.gradientColor)
      or (Config and Config.RageUI and Config.RageUI.gradientColor)
      or c

    if Selected then
      -- 1. Fine barre verticale blanche avec marge
      local barMargin = 4
      local barWidth = 2
      RenderRectangle(boxX + barMargin, boxY, barWidth, boxH, 255, 255, 255, 255)

      -- 2. Gradient Rouge (gauche) -> Transparent (droite) via Rectangles (Pixel-Perfect)
      local gradientX = boxX + barMargin + 2
      local gradientW = baseWidth - barMargin - 2
      local steps = math.ceil(gradientW)
      local startAlpha = c.A or 200

      for i = 0, steps - 1 do
        local progress = i / steps
        local alphaFactor = (1 - progress) ^ 2
        local currentAlpha = math.floor(startAlpha * alphaFactor)

        if currentAlpha > 0 then
          RenderRectangle(gradientX + i, boxY, 1, boxH, g.R, g.G, g.B, currentAlpha)
        end
      end
    else
      -- Normal background for unselected items
      RenderSprite("utils", "bouton", boxX, boxY, baseWidth, boxH, 0, bgR, bgG, bgB, bgA)
    end
  end

  if enabled then
    RenderText(
      Label,
      CurrentMenu.X + ItemPaddingX + SettingsButton.Text.X + LeftBadgeOffset,
      boxY + (SettingsButton.Text.Y or 0) + extraTextY,
      8,
      SettingsButton.Text.Scale,
      Selected and 255 or 225,
      Selected and 255 or 225,
      Selected and 255 or 225,
      255
    )
  else
    RenderText(
      Label,
      CurrentMenu.X + ItemPaddingX + SettingsButton.Text.X + LeftBadgeOffset,
      boxY + (SettingsButton.Text.Y or 0) + extraTextY,
      8,
      SettingsButton.Text.Scale,
      163,
      159,
      148,
      255
    )
  end

  if Style.LeftBadge ~= nil and Style.LeftBadge ~= RageUI.BadgeStyle.None then
    local BadgeData = Style.LeftBadge(Selected)
    local rowY = boxY
    local rowH = (SettingsButton.SelectedSprite.Height or SettingsButton.Rectangle.Height) - 1
    local badgeY = rowY + math.floor(((rowH - SettingsButton.LeftBadge.Height) / 2) + 0.5)
    RenderSprite(
      BadgeData.BadgeDictionary or "commonmenu",
      BadgeData.BadgeTexture or "",
      CurrentMenu.X + ItemPaddingX,
      badgeY,
      SettingsButton.LeftBadge.Width,
      SettingsButton.LeftBadge.Height,
      0,
      BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255,
      BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255,
      BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255,
      BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255
    )
  end

  if Style.RightBadge ~= nil and Style.RightBadge ~= RageUI.BadgeStyle.None then
    local BadgeData = Style.RightBadge(Selected)
    local baseWidth = RageUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset
    local rightBadgeX = CurrentMenu.X + baseWidth - SettingsButton.RightBadge.Width - 8

    local rowY = boxY
    local rowH = (SettingsButton.SelectedSprite.Height or SettingsButton.Rectangle.Height) - 1
    local rightBadgeY = rowY + math.floor(((rowH - SettingsButton.RightBadge.Height) / 2) + 0.5)

    RenderSprite(
      BadgeData.BadgeDictionary or "commonmenu",
      BadgeData.BadgeTexture or "",
      rightBadgeX,
      rightBadgeY,
      SettingsButton.RightBadge.Width,
      SettingsButton.RightBadge.Height,
      0,
      BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255,
      BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255,
      BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255,
      BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255
    )
  end

  local BoxOffset = 0
  if enabled and Style.RightLabel ~= nil and Style.RightLabel ~= "" then
    local baseWidth = RageUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset
    local rightEdgeX = CurrentMenu.X + baseWidth - 10 - (RightBadgeOffset > 0 and (SettingsButton.RightBadge.Width + 6) or 0)
    RenderText(
      Style.RightLabel,
      rightEdgeX,
      boxY + (SettingsButton.RightText.Y or 0) + extraTextY,
      8,
      SettingsButton.RightText.Scale,
      Selected and 255 or 225,
      Selected and 255 or 225,
      Selected and 255 or 225,
      255,
      2
    )
    BoxOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
  end

  BoxOffset = RightBadgeOffset + BoxOffset
  if Style.Style == RageUI.CheckboxStyle.Cross then
    StyleCheckBox(Selected, Checked, 5, 6, BoxOffset)
  else
    StyleCheckBox(Selected, Checked, 2, 4, BoxOffset)
  end

  if Selected and (CurrentMenu.Controls.Select.Active or (Hovered and CurrentMenu.Controls.Click.Active)) and enabled and not isWaitingForServer then
    local Audio = RageUI.Settings.Audio
    RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
    Checked = not Checked
    if Checked then
      if Actions.onChecked ~= nil then
        Actions.onChecked()
      end
    else
      if Actions.onUnChecked ~= nil then
        Actions.onUnChecked()
      end
    end
  end

  RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height

  RageUI.ItemsDescription(CurrentMenu, Description, Selected)

  if (Actions.onSelected ~= nil) and Selected then
    Actions.onSelected(Checked)
  end

  RageUI.Options = RageUI.Options + 1
end

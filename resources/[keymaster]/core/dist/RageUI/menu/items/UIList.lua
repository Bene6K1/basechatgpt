local SettingsButton = {
  Rectangle = { Y = 0, Width = 500, Height = 43 },
  Text = { X = 8, Y = 4, Scale = 0.25 },
  LeftBadge = { X = 5, Y = -2, Width = 40, Height = 40 },
  RightBadge = { X = 385, Y = -2, Width = 40, Height = 40 },
  RightText = { X = 420, Y = 1, Scale = 0.25 },
  SelectedSprite = {
    Dictionary = "utils",
    Texture = "gradient_nav",
    Y = 0,
    Width = 440,
    Height = 38,
  },
}

---@type table
local SettingsList = {
  Text = { X = 395, Y = 3, Scale = 0.25 },
}

function RageUI.List(Label, Items, Index, Description, Style, Enabled, Actions, Submenu, IndexColor)
  local CurrentMenu = RageUI.CurrentMenu
  if CurrentMenu == nil or not CurrentMenu() then
    return
  end

  local Option = RageUI.Options + 1
  if CurrentMenu.Pagination.Minimum > Option or CurrentMenu.Pagination.Maximum < Option then
    RageUI.Options = RageUI.Options + 1
    return
  end

  local Selected = CurrentMenu.Index == Option
  RageUI.ItemsSafeZone(CurrentMenu)

  Style = Style or {}
  Actions = Actions or {}

  local ItemsOffsetY = (Config and Config.RageUI and Config.RageUI.itemsOffsetY) or 0
  local ItemBaseY = (Config and Config.RageUI and Config.RageUI.itemBaseY) or 20
  local ItemPaddingX = (Config and Config.RageUI and Config.RageUI.itemPaddingX) or 2

  local Hovered = false
  if CurrentMenu.EnableMouse == true and (CurrentMenu.CursorStyle == 0 or CurrentMenu.CursorStyle == 1) then
    Hovered = RageUI.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton)
  end

  local LeftBadgeOffset = ((Style.LeftBadge == RageUI.BadgeStyle.None or Style.LeftBadge == nil) and 0 or 27)
  local RightBadgeOffset = ((Style.RightBadge == RageUI.BadgeStyle.None or Style.RightBadge == nil) and 0 or 32)

  local boxX = CurrentMenu.X
  local boxY = CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset
  local baseWidth = RageUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset
  local boxW = baseWidth
  local boxH = SettingsButton.SelectedSprite.Height - 1

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

  local listValue = Items and Items[Index]
  local listLabel = "NIL"
  if type(listValue) == "table" and listValue.Name then
    listLabel = listValue.Name
  elseif listValue ~= nil then
    listLabel = tostring(listValue)
  end

  local ListText = string.format("← %s%s~s~ →", (IndexColor ~= nil and IndexColor or "~s~"), listLabel)

  local enabled = (Enabled == true or Enabled == nil)
  local labelR, labelG, labelB = 225, 225, 225
  if not enabled then
    labelR, labelG, labelB = 163, 159, 148
  elseif Selected then
    labelR, labelG, labelB = g.R, g.G, g.B
  end

  local RightOffset = 0
  if enabled and Style.RightLabel ~= nil and Style.RightLabel ~= "" then
    RightOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
    local rightEdgeX = boxX + baseWidth - 10 - (RightBadgeOffset > 0 and (SettingsButton.RightBadge.Width + 6) or 0)
    RenderText(
      Style.RightLabel,
      rightEdgeX,
      CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
      8,
      SettingsButton.RightText.Scale,
      labelR,
      labelG,
      labelB,
      255,
      2
    )
  end
  RightOffset = RightBadgeOffset * 1.3 + RightOffset

  RenderText(
    Label,
    CurrentMenu.X + ItemPaddingX + SettingsButton.Text.X + LeftBadgeOffset,
    CurrentMenu.Y + ItemBaseY + ItemsOffsetY + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
    8,
    SettingsButton.Text.Scale,
    labelR,
    labelG,
    labelB,
    255
  )

  local listRightEdgeX = boxX + baseWidth - 10 - RightOffset
  RenderText(
    ListText,
    listRightEdgeX,
    CurrentMenu.Y + ItemBaseY + ItemsOffsetY + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
    8,
    SettingsList.Text.Scale,
    labelR,
    labelG,
    labelB,
    255,
    2
  )

  if Style.LeftBadge ~= nil and Style.LeftBadge ~= RageUI.BadgeStyle.None then
    local BadgeData = Style.LeftBadge(Selected)
    local rowY = CurrentMenu.Y + ItemBaseY + ItemsOffsetY + (SettingsButton.SelectedSprite.Y or 0) + CurrentMenu.SubtitleHeight + RageUI.ItemOffset
    local rowH = (SettingsButton.Rectangle.Height or 43)
    local badgeY = rowY + math.floor(((rowH - SettingsButton.LeftBadge.Height) / 2) + 0.5)
    RenderSprite(
      BadgeData.BadgeDictionary or "commonmenu",
      BadgeData.BadgeTexture or "",
      CurrentMenu.X + SettingsButton.LeftBadge.X,
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
    local rightBadgeX = CurrentMenu.X + baseWidth - SettingsButton.RightBadge.Width - 8
    local rowY = CurrentMenu.Y + ItemBaseY + ItemsOffsetY + (SettingsButton.SelectedSprite.Y or 0) + CurrentMenu.SubtitleHeight + RageUI.ItemOffset
    local rowH = (SettingsButton.Rectangle.Height or 43)
    local badgeY = rowY + math.floor(((rowH - SettingsButton.RightBadge.Height) / 2) + 0.5)
    RenderSprite(
      BadgeData.BadgeDictionary or "commonmenu",
      BadgeData.BadgeTexture or "",
      rightBadgeX,
      badgeY,
      SettingsButton.RightBadge.Width,
      SettingsButton.RightBadge.Height,
      0,
      BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255,
      BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255,
      BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255,
      BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255
    )
  end

  local leftArrowX = listRightEdgeX + CurrentMenu.SafeZoneSize.X
  local arrowY = CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 2.5 + CurrentMenu.SafeZoneSize.Y
  local LeftArrowHovered = RageUI.IsMouseInBounds(leftArrowX, arrowY, 15, 22.5)
  local RightArrowHovered = RageUI.IsMouseInBounds(
    CurrentMenu.X + SettingsList.Text.X + CurrentMenu.WidthOffset + CurrentMenu.SafeZoneSize.X - RightOffset
      - MeasureStringWidth(ListText, 0, SettingsList.Text.Scale),
    arrowY,
    15,
    22.5
  )

  RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height
  RageUI.ItemsDescription(CurrentMenu, Description, Selected)

  if Selected and enabled and not isWaitingForServer then
    if (CurrentMenu.Controls.Left.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered))
      and not (CurrentMenu.Controls.Right.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered))
    then
      Index = Index - 1
      if Index < 1 then
        Index = #Items
      end
      if Actions.onListChange ~= nil then
        Actions.onListChange(Index, Items[Index])
      end
      local Audio = RageUI.Settings.Audio
      RageUI.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
    elseif (CurrentMenu.Controls.Right.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered))
      and not (CurrentMenu.Controls.Left.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered))
    then
      Index = Index + 1
      if Index > #Items then
        Index = 1
      end
      if Actions.onListChange ~= nil then
        Actions.onListChange(Index, Items[Index])
      end
      local Audio = RageUI.Settings.Audio
      RageUI.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
    end

    if (CurrentMenu.Controls.Select.Active or ((Hovered and CurrentMenu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) then
      local Audio = RageUI.Settings.Audio
      RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)

      if Actions.onSelected ~= nil then
        Actions.onSelected(Index, Items[Index])
      end

      if Submenu ~= nil and type(Submenu) == "table" then
        RageUI.NextMenu = Submenu[Index]
      end
    elseif Actions.onActive ~= nil then
      Actions.onActive()
    end
  end

  RageUI.Options = RageUI.Options + 1
end

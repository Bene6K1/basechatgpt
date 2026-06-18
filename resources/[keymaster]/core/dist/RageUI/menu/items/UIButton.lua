---@type table
local SettingsButton = {
  Rectangle = { Y = 0, Width = 500, Height = 43 },
  Text = { X = 8, Y = 5, Scale = 0.25 },
  LeftBadge = { X = 5, Y = 20, Width = 40, Height = 40 },
  RightBadge = { X = 373, Y = 28, Width = 20, Height = 20 },
  RightText = { X = 420, Y = 5, Scale = 0.23 },
  SelectedSprite = {
    Dictionary = "utils",
    Texture = "gradient_nav",
    Y = 0,
    Width = 440,
    Height = 38,
  },
}

---ButtonWithStyle
---@param Label string
---@param Description string
---@param Style table
---@param Enabled boolean
---@param Callback function
---@param Submenu table
---@return nil
---@public

local progressValue = 0
local isStarted = false
local canInteract = true
local isThreadCreateded = false
local alpha = 100

local function DrawButtonBox(CurrentMenu, x, y, w, h, selected)
  local bg = (Config and Config.RageUI and Config.RageUI.buttonBackground) or { R = 25, G = 25, B = 25, A = 150 }
  local bgR, bgG, bgB, bgA = bg.R or 25, bg.G or 25, bg.B or 25, bg.A or 150
  local c = (Config and Config.RageUI and (Config.RageUI.hoverColor or Config.RageUI.color))
    or { R = 237, G = 28, B = 36, A = 255 }
  local g = (SunnyConfigServ and SunnyConfigServ.RageUI and SunnyConfigServ.RageUI.gradientColor)
    or (Config and Config.RageUI and Config.RageUI.gradientColor)
    or c

  if selected then
    -- 1. Fine barre verticale blanche avec marge
    local barMargin = 4
    local barWidth = 2
    RenderRectangle(x + barMargin, y, barWidth, h, 255, 255, 255, 255)

    -- 2. Gradient Rouge (gauche) -> Transparent (droite)
    -- "Custom" Pixel-Perfect Loop pour éviter les stries
    local gradientX = x + barMargin + barWidth -- Commence juste après la barre blanche (avec ou sans petit gap ?) -> User: "commence là où y'a la barre blanche"
    -- On va dire gradientX = x + barMargin pour que le dégradé "parte" du même niveau visuel, mais la barre blanche est par dessus ou dedans.
    -- Si on veut que ça commence *après* la barre : x + barMargin + barWidth.
    -- Le user a dit : "commence au début alors qu'il devrait ocmmencre la olu y'a la barre blanche".
    -- "la ou y'a la barre blanche" = à la position de la barre.
    -- Donc je vais garder x + barMargin. La barre blanche sera dessinée par dessus (render order) ou avant.
    -- Ici je dessine la barre blanche AVANT, donc le gradient va se dessiner PAR DESSUS si overlap.
    -- Mais si je commence à x + barMargin, ça overlap la barre.
    -- Le rouge transparent sur du blanc = rouge clair. Ça peut faire bizarre.
    -- Mieux vaut commencer APRÈS la barre : x + barMargin + barWidth?
    -- Ou alors commencer à x + barMargin mais commencer l'alpha après ?
    -- "Le fond du selector doit être un gradient rouge ... Il doit y avoir une fine barre verticale blanche au début"
    -- Généralement le gradient est le FOND. La barre est un ACCENT.
    -- Donc le gradient doit commencer à x + barMargin, et la barre est à x + barMargin.
    
    gradientX = x + barMargin + 2
    local gradientW = w - barMargin - 2
    
    -- Pour éviter les stries (aliasing d'overlap), on dessine pixel par pixel (width=1) sans overlap.
    local steps = math.ceil(gradientW)
    local startAlpha = c.A or 200

    for i = 0, steps - 1 do
      local progress = i / steps
      -- Formule ajustée pour un fade plus rapide (exposant plus élevé = transparence plus tôt)
      local alphaFactor = (1 - progress) ^ 2 
      local currentAlpha = math.floor(startAlpha * alphaFactor)

      if currentAlpha > 0 then
        RenderRectangle(gradientX + i, y, 1, h, g.R, g.G, g.B, currentAlpha)
      end
    end
  else
    -- Normal background for unselected items
    RenderSprite("utils", "bouton", x, y, w, h, 0, bgR, bgG, bgB, bgA)
  end
end

function RageUI.Button(Label, Description, Style, Enabled, Action, Submenu)
  Enabled = Enabled and not isWaitingForServer
  local CurrentMenu = RageUI.CurrentMenu
  if CurrentMenu ~= nil and CurrentMenu() then
    ---@type number
    local Option = RageUI.Options + 1

    if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
      ---@type boolean
      local Active = CurrentMenu.Index == Option

      RageUI.ItemsSafeZone(CurrentMenu)

      local ItemsOffsetY = (Config and Config.RageUI and Config.RageUI.itemsOffsetY) or 0
      local ItemBaseY = (Config and Config.RageUI and Config.RageUI.itemBaseY) or 20
      local ItemPaddingX = (Config and Config.RageUI and Config.RageUI.itemPaddingX) or 2

      local haveLeftBadge = Style.LeftBadge and Style.LeftBadge ~= RageUI.BadgeStyle.None
      local showSubmenuChevron = (Submenu ~= nil)
        and (not Style.RightBadge or Style.RightBadge == RageUI.BadgeStyle.None)
        and (not Style.RightLabel or Style.RightLabel == "")
      local haveRightBadge = (Style.RightBadge and Style.RightBadge ~= RageUI.BadgeStyle.None)
        or showSubmenuChevron
        or (not Enabled and Style.LockBadge ~= RageUI.BadgeStyle.None)
      local LeftBadgeOffset = haveLeftBadge and 27 or 0
      local RightBadgeOffset = haveRightBadge and 32 or 0

      local boxX = CurrentMenu.X
      local boxY = CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset
      local baseWidth = RageUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset
      local boxW = baseWidth
      local boxH = SettingsButton.SelectedSprite.Height - 1
      DrawButtonBox(CurrentMenu, boxX, boxY, boxW, boxH, Active)

      local rightBadgeX = boxX + baseWidth - SettingsButton.RightBadge.Width - 8
      -- Use the *actual drawn* box height for perfect vertical alignment.
      local rowH = boxH
      local rightBadgeY = boxY + math.floor(((rowH - SettingsButton.RightBadge.Height) / 2) + 0.5)
      local leftBadgeY = boxY + math.floor(((rowH - SettingsButton.LeftBadge.Height) / 2) + 0.5)
      local activeColor = (Config and Config.RageUI and (Config.RageUI.hoverColor or Config.RageUI.color))
        or { R = 237, G = 28, B = 36, A = 255 }

      if Enabled then
        if haveLeftBadge then
          if Style.LeftBadge ~= nil then
            local LeftBadge = Style.LeftBadge(Active)
            RenderSprite(
              LeftBadge.BadgeDictionary or "commonmenu",
              LeftBadge.BadgeTexture or "",
              CurrentMenu.X + SettingsButton.LeftBadge.X,
              leftBadgeY,
              SettingsButton.LeftBadge.Width,
              SettingsButton.LeftBadge.Height,
              0,
              LeftBadge.BadgeColour and LeftBadge.BadgeColour.R or 255,
              LeftBadge.BadgeColour and LeftBadge.BadgeColour.G or 255,
              LeftBadge.BadgeColour and LeftBadge.BadgeColour.B or 255,
              LeftBadge.BadgeColour and LeftBadge.BadgeColour.A or 255
            )
          end
        end
        if haveRightBadge then
          if (not Enabled and Style.LockBadge ~= RageUI.BadgeStyle.None) then
            local RightBadge = RageUI.BadgeStyle.Lock(Active)
            RenderSprite(
              RightBadge.BadgeDictionary or "commonmenu",
              RightBadge.BadgeTexture or "",
              rightBadgeX,
              rightBadgeY,
              SettingsButton.RightBadge.Width,
              SettingsButton.RightBadge.Height,
              0,
              RightBadge.BadgeColour and RightBadge.BadgeColour.R or 255,
              RightBadge.BadgeColour and RightBadge.BadgeColour.G or 255,
              RightBadge.BadgeColour and RightBadge.BadgeColour.B or 255,
              RightBadge.BadgeColour and RightBadge.BadgeColour.A or 255
            )
          elseif showSubmenuChevron then
            local RightBadge = RageUI.BadgeStyle.Chevron(Active)
            local badgeW = RightBadge.Width or SettingsButton.RightBadge.Width
            local badgeH = RightBadge.Height or SettingsButton.RightBadge.Height
            local badgeX = boxX + baseWidth - badgeW - 8
            local badgeY = boxY + math.floor(((rowH - badgeH) / 2) + 0.5)
            RenderSprite(
              RightBadge.BadgeDictionary or "commonmenu",
              RightBadge.BadgeTexture or "",
              badgeX,
              badgeY,
              badgeW,
              badgeH,
              0,
              Active and (activeColor.R or 255) or (RightBadge.BadgeColour and RightBadge.BadgeColour.R or 255),
              Active and (activeColor.G or 255) or (RightBadge.BadgeColour and RightBadge.BadgeColour.G or 255),
              Active and (activeColor.B or 255) or (RightBadge.BadgeColour and RightBadge.BadgeColour.B or 255),
              RightBadge.BadgeColour and RightBadge.BadgeColour.A or 255
            )
          elseif Style.RightBadge ~= nil then
            local RightBadge = Style.RightBadge(Active)
            RenderSprite(
              RightBadge.BadgeDictionary or "commonmenu",
              RightBadge.BadgeTexture or "",
              rightBadgeX,
              rightBadgeY,
              SettingsButton.RightBadge.Width,
              SettingsButton.RightBadge.Height,
              0,
              RightBadge.BadgeColour and RightBadge.BadgeColour.R or 255,
              RightBadge.BadgeColour and RightBadge.BadgeColour.G or 255,
              RightBadge.BadgeColour and RightBadge.BadgeColour.B or 255,
              RightBadge.BadgeColour and RightBadge.BadgeColour.A or 255
            )
          end
        end

        if Style.RightLabel then
          local rightEdgeX = boxX + boxW - 10 - (haveRightBadge and (SettingsButton.RightBadge.Width + 6) or 0)
          RenderText(
            Style.RightLabel,
            rightEdgeX,
            boxY + (SettingsButton.RightText.Y or 0),
            0,
            SettingsButton.RightText.Scale,
            Active and 255 or 225,
            Active and 255 or 225,
            Active and 255 or 225,
            255,
            2
          )
        end

        local R_ITEM_BUTTON = not Active and 225 or 255
        local G_ITEM_BUTTON = not Active and 225 or 255
        local B_ITEM_BUTTON = not Active and 225 or 255

        -- TEXT ICI
        RenderText(
          not Active and Label or Label,
          CurrentMenu.X + ItemPaddingX + SettingsButton.Text.X + LeftBadgeOffset,
          boxY + (SettingsButton.Text.Y or 0),
          8,
          SettingsButton.Text.Scale,
          R_ITEM_BUTTON,
          G_ITEM_BUTTON,
          B_ITEM_BUTTON,
          255
        )
      else
        -- Badges are handled in the Enabled branch; keep disabled text style here.

        local R_ITEM_BUTTON = not Active and 104 or 124
        local G_ITEM_BUTTON = not Active and 108 or 129
        local B_ITEM_BUTTON = not Active and 114 or 135

        RenderText(
          Label,
          CurrentMenu.X + ItemPaddingX + SettingsButton.Text.X + LeftBadgeOffset,
          boxY + (SettingsButton.Text.Y or 0),
          8,
          SettingsButton.Text.Scale,
          R_ITEM_BUTTON,
          G_ITEM_BUTTON,
          B_ITEM_BUTTON,
          255
        )
      end

      RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height

      RageUI.ItemsDescription(CurrentMenu, Description, Active)

      if Enabled then
        local Hovered = CurrentMenu.EnableMouse
          and (CurrentMenu.CursorStyle == 0 or CurrentMenu.CursorStyle == 1)
          and RageUI.ItemsMouseBounds(CurrentMenu, Active, Option + 1, SettingsButton)
        local Selected = (
          CurrentMenu.Controls.Select.Active or (Hovered and CurrentMenu.Controls.Click.Active)
        ) and Active
        if (Action.onHovered ~= nil) and Hovered then
          Action.onHovered()
        end
        if (Action.onActive ~= nil) and Active then
          Action.onActive()
        end
        if Selected then
          local Audio = RageUI.Settings.Audio
          RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
          if Action.onSelected ~= nil then
            Citizen.CreateThread(function()
              Action.onSelected()
            end)
          end
          if Submenu and Submenu() then
            RageUI.NextMenu = Submenu
          end
        end
      end
    end
    RageUI.Options = RageUI.Options + 1
  end
end

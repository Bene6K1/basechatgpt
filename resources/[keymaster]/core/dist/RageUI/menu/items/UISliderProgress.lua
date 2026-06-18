---@type table
local SettingsButton = {
  Rectangle = { Y = 0, Width = 415.01, Height = 47 },
  Text = { X = 35, Y = 25, Scale = 0.20 },
  LeftBadge = { Y = -1.93, Width = 38.52, Height = 40 },
  RightBadge = { X = 385, Y = -1.93, Width = 38.52, Height = 40 },
  RightText = { X = 420, Y = 0.85, Scale = 0.35 },
  SelectedSprite = {
    Dictionary = "utils",
    Texture = "gradient_nav",
    Y = 0,
    Width = 431,
    Height = 38,
  },
}

local SettingsSlider = {
  Background = { X = 221.13, Y = 34.5, Width = 144.44, Height = 9 },
  Slider = { X = 221.13, Y = 34.5, Width = 144.44, Height = 9 },
  LeftArrow = {
    Dictionary = "utils",
    Texture = "arrowleft",
    X = 207.03,
    Y = 31.5,
    Width = 14.44,
    Height = 14.44,
  },
  RightArrow = {
    Dictionary = "utils",
    Texture = "arrowright",
    X = 366.47,
    Y = 31.5,
    Width = 14.44,
    Height = 14.44,
  },
}

function RageUI.SliderProgress(
  Label,
  ProgressStart,
  ProgressMax,
  Description,
  Style,
  Enabled,
  Actions
)
  ---@type table
  local CurrentMenu = RageUI.CurrentMenu
  local Audio = RageUI.Settings.Audio

  if CurrentMenu ~= nil then
    if CurrentMenu() then
      local Items = {}
      for i = 1, ProgressMax do
        table.insert(Items, i)
      end
      ---@type number
      local Option = RageUI.Options + 1

      if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
        ---@type number
        local Selected = CurrentMenu.Index == Option

        ---@type boolean
        local LeftArrowHovered, RightArrowHovered = false, false

        RageUI.ItemsSafeZone(CurrentMenu)

        local ItemsOffsetY = (Config and Config.RageUI and Config.RageUI.itemsOffsetY) or 0
        local ItemBaseY = (Config and Config.RageUI and Config.RageUI.itemBaseY) or 20

        local Hovered = false
        local LeftBadgeOffset = (
          (Style.LeftBadge == RageUI.BadgeStyle.None or Style.LeftBadge == nil) and 0 or 27
        )
        local RightBadgeOffset = (
          (Style.RightBadge == RageUI.BadgeStyle.None or Style.RightBadge == nil) and 0 or 32
        )
        local RightOffset = 0
        ---@type boolean
        if
          CurrentMenu.EnableMouse == true and (CurrentMenu.CursorStyle == 0)
          or (CurrentMenu.CursorStyle == 1)
        then
          Hovered = RageUI.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton)
        end

        do
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
        end

        if Selected then
          LeftArrowHovered = RageUI.IsMouseInBounds(
            CurrentMenu.X
              + SettingsSlider.LeftArrow.X
              + CurrentMenu.SafeZoneSize.X
              + CurrentMenu.WidthOffset,
            CurrentMenu.Y
              + ItemsOffsetY
              + SettingsSlider.LeftArrow.Y
              + CurrentMenu.SafeZoneSize.Y
              + CurrentMenu.SubtitleHeight
              + RageUI.ItemOffset,
            SettingsSlider.LeftArrow.Width,
            SettingsSlider.LeftArrow.Height
          )
          RightArrowHovered = RageUI.IsMouseInBounds(
            CurrentMenu.X
              + SettingsSlider.RightArrow.X
              + CurrentMenu.SafeZoneSize.X
              + CurrentMenu.WidthOffset,
            CurrentMenu.Y
              + ItemsOffsetY
              + SettingsSlider.RightArrow.Y
              + CurrentMenu.SafeZoneSize.Y
              + CurrentMenu.SubtitleHeight
              + RageUI.ItemOffset,
            SettingsSlider.RightArrow.Width,
            SettingsSlider.RightArrow.Height
          )
        end

        if Enabled == true or Enabled == nil then
          if Selected then
            if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
              RenderText(
                Style.RightLabel,
                CurrentMenu.X
                  + SettingsButton.RightText.X
                  - RightBadgeOffset
                  + CurrentMenu.WidthOffset,
                CurrentMenu.Y
                  + ItemsOffsetY
                  + SettingsButton.RightText.Y
                  + CurrentMenu.SubtitleHeight
                  + RageUI.ItemOffset,
                0,
                SettingsButton.RightText.Scale,
                0,
                0,
                0,
                255,
                2
              )
              RightOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
            end
          else
            if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
              RightOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
              RenderText(
                Style.RightLabel,
                CurrentMenu.X
                  + SettingsButton.RightText.X
                  - RightBadgeOffset
                  + CurrentMenu.WidthOffset,
                CurrentMenu.Y
                  + ItemsOffsetY
                  + SettingsButton.RightText.Y
                  + CurrentMenu.SubtitleHeight
                  + RageUI.ItemOffset,
                0,
                SettingsButton.RightText.Scale,
                245,
                245,
                245,
                255,
                2
              )
            end
          end
        end
        RightOffset = RightOffset + RightBadgeOffset
        if Enabled == true or Enabled == nil then
          if Selected then
            RenderText(
              Label,
              CurrentMenu.X + SettingsButton.Text.X,
              CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
              0,
              SettingsButton.Text.Scale,
              255,
              255,
              255,
              255
            )

            RenderSprite(
              SettingsSlider.LeftArrow.Dictionary,
              SettingsSlider.LeftArrow.Texture,
              CurrentMenu.X + SettingsSlider.LeftArrow.X + CurrentMenu.WidthOffset - RightOffset,
              CurrentMenu.Y
                + ItemsOffsetY
                + SettingsSlider.LeftArrow.Y
                + CurrentMenu.SubtitleHeight
                + RageUI.ItemOffset,
              SettingsSlider.LeftArrow.Width,
              SettingsSlider.LeftArrow.Height,
              0,
              255,
              255,
              255,
              255
            )
            RenderSprite(
              SettingsSlider.RightArrow.Dictionary,
              SettingsSlider.RightArrow.Texture,
              CurrentMenu.X + SettingsSlider.RightArrow.X + CurrentMenu.WidthOffset - RightOffset,
              CurrentMenu.Y
                + ItemsOffsetY
                + SettingsSlider.RightArrow.Y
                + CurrentMenu.SubtitleHeight
                + RageUI.ItemOffset,
              SettingsSlider.RightArrow.Width,
              SettingsSlider.RightArrow.Height,
              0,
              255,
              255,
              255,
              255
            )
          else
            RenderText(
              Label,
              CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset,
              CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
              0,
              SettingsButton.Text.Scale,
              225,
              225,
              225,
              255
            )
          end
        else
          RenderText(
            Label,
            CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset,
            CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
            0,
            SettingsButton.Text.Scale,
            163,
            159,
            148,
            255
          )

          if Selected then
            RenderSprite(
              SettingsSlider.LeftArrow.Dictionary,
              SettingsSlider.LeftArrow.Texture,
              CurrentMenu.X + SettingsSlider.LeftArrow.X + CurrentMenu.WidthOffset - RightOffset,
              CurrentMenu.Y
                + ItemsOffsetY
                + SettingsSlider.LeftArrow.Y
                + CurrentMenu.SubtitleHeight
                + RageUI.ItemOffset,
              SettingsSlider.LeftArrow.Width,
              SettingsSlider.LeftArrow.Height,
              163,
              159,
              148,
              255
            )
            RenderSprite(
              SettingsSlider.RightArrow.Dictionary,
              SettingsSlider.RightArrow.Texture,
              CurrentMenu.X + SettingsSlider.RightArrow.X + CurrentMenu.WidthOffset - RightOffset,
              CurrentMenu.Y
                + ItemsOffsetY
                + SettingsSlider.RightArrow.Y
                + CurrentMenu.SubtitleHeight
                + RageUI.ItemOffset,
              SettingsSlider.RightArrow.Width,
              SettingsSlider.RightArrow.Height,
              163,
              159,
              148,
              255
            )
          end
        end

        if type(Style) == "table" then
          if Style.Enabled == true or Style.Enabled == nil then
            if type(Style) == "table" then
              if Style.LeftBadge ~= nil then
                if Style.LeftBadge ~= RageUI.BadgeStyle.None then
                  local BadgeData = Style.LeftBadge(Selected)

                  RenderSprite(
                    BadgeData.BadgeDictionary or "commonmenu",
                    BadgeData.BadgeTexture or "",
                    CurrentMenu.X,
                    CurrentMenu.Y
                      + ItemsOffsetY
                      + SettingsButton.LeftBadge.Y
                      + CurrentMenu.SubtitleHeight
                      + RageUI.ItemOffset,
                    SettingsButton.LeftBadge.Width,
                    SettingsButton.LeftBadge.Height,
                    0,
                    BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255,
                    BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255,
                    BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255,
                    BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255
                  )
                end
              end

              if Style.RightBadge ~= nil then
                if Style.RightBadge ~= RageUI.BadgeStyle.None then
                  local BadgeData = Style.RightBadge(Selected)
                  local rightBadgeX = CurrentMenu.X + RageUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset - SettingsButton.RightBadge.Width - 8

                  RenderSprite(
                    BadgeData.BadgeDictionary or "commonmenu",
                    BadgeData.BadgeTexture or "",
                    rightBadgeX,
                    CurrentMenu.Y
                      + ItemsOffsetY
                      + SettingsButton.RightBadge.Y
                      + CurrentMenu.SubtitleHeight
                      + RageUI.ItemOffset,
                    SettingsButton.RightBadge.Width,
                    SettingsButton.RightBadge.Height,
                    0,
                    BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255,
                    BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255,
                    BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255,
                    BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255
                  )
                end
              end
            end
          else
            ---@type table
            local LeftBadge = RageUI.BadgeStyle.Lock

            if LeftBadge ~= RageUI.BadgeStyle.None and LeftBadge ~= nil then
              local BadgeData = LeftBadge(Selected)

              RenderSprite(
                BadgeData.BadgeDictionary or "commonmenu",
                BadgeData.BadgeTexture or "",
                CurrentMenu.X,
                CurrentMenu.Y
                  + SettingsButton.LeftBadge.Y
                  + CurrentMenu.SubtitleHeight
                  + RageUI.ItemOffset,
                SettingsButton.LeftBadge.Width,
                SettingsButton.LeftBadge.Height,
                0,
                BadgeData.BadgeColour.R or 255,
                BadgeData.BadgeColour.G or 255,
                BadgeData.BadgeColour.B or 255,
                BadgeData.BadgeColour.A or 255
              )
            end
          end
        else
          error("UICheckBox Style is not a `table`")
        end

        if type(Style.ProgressBackgroundColor) == "table" then
          RenderRectangle(
            CurrentMenu.X + SettingsSlider.Background.X + CurrentMenu.WidthOffset - RightOffset,
            CurrentMenu.Y
              + ItemsOffsetY
              + SettingsSlider.Background.Y
              + CurrentMenu.SubtitleHeight
              + RageUI.ItemOffset,
            SettingsSlider.Background.Width,
            SettingsSlider.Background.Height,
            Style.ProgressBackgroundColor.R,
            Style.ProgressBackgroundColor.G,
            Style.ProgressBackgroundColor.B,
            Style.ProgressBackgroundColor.A
          )
        else
          error("Style ProgressBackgroundColor is not a table or undefined")
        end

        if type(Style.ProgressColor) == "table" then
          RenderRectangle(
            CurrentMenu.X + SettingsSlider.Slider.X + CurrentMenu.WidthOffset - RightOffset,
            CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsSlider.Slider.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
            ((SettingsSlider.Slider.Width / (#Items - 1)) * (ProgressStart - 1)),
            SettingsSlider.Slider.Height,
            Style.ProgressColor.R,
            Style.ProgressColor.G,
            Style.ProgressColor.B,
            Style.ProgressColor.A
          )
        else
          error("Style ProgressColor is not a table or undefined")
        end

        RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height

        RageUI.ItemsDescription(CurrentMenu, Description, Selected)

        if
          Selected
          and (CurrentMenu.Controls.Left.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered))
          and not (
            CurrentMenu.Controls.Right.Active
            or (CurrentMenu.Controls.Click.Active and RightArrowHovered)
          )
        then
          ProgressStart = ProgressStart - 1
          if ProgressStart < 1 then
            ProgressStart = #Items
          end
          if Actions.onSliderChange ~= nil then
            Actions.onSliderChange(ProgressStart)
          end
          RageUI.PlaySound(
            Audio[Audio.Use].LeftRight.audioName,
            Audio[Audio.Use].LeftRight.audioRef
          )
        elseif
          Selected
          and (CurrentMenu.Controls.Right.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered))
          and not (
            CurrentMenu.Controls.Left.Active
            or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)
          )
        then
          ProgressStart = ProgressStart + 1
          if ProgressStart > #Items then
            ProgressStart = 1
          end
          if Actions.onSliderChange ~= nil then
            Actions.onSliderChange(ProgressStart)
          end
          RageUI.PlaySound(
            Audio[Audio.Use].LeftRight.audioName,
            Audio[Audio.Use].LeftRight.audioRef
          )
        end

        if
          Selected
          and (
            CurrentMenu.Controls.Select.Active
            or (
              (Hovered and CurrentMenu.Controls.Click.Active)
              and (not LeftArrowHovered and not RightArrowHovered)
            )
          )
        then
          if Actions.onSelected ~= nil then
            Actions.onSelected(ProgressStart)
          end
          RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
        elseif Selected then
          if Actions.onActive ~= nil then
            Actions.onActive()
          end
        end
      end

      RageUI.Options = RageUI.Options + 1
    end
  end
end

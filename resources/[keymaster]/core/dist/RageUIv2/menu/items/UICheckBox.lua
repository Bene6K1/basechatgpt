local SettingsButton = {
  Rectangle = { Y = 0, Width = 450, Height = 38 },
  Text = { X = 30, Y = 3, Scale = 0.25 },
  LeftBadge = { X = 15, Y = 1, Width = 35, Height = 35 },
  RightBadge = { X = 414, Y = 3, Width = 35, Height = 35 },
  RightText = { X = 439, Y = 3, Scale = 0.25 },
  SelectedSprite = {
    Dictionary = "commonmenu",
    Texture = "gradient_nav",
    Y = 0,
    Width = 450,
    Height = 38,
  },
}

local SettingsCheckbox = {
  Dictionary = "commonmenu",
  Textures = {
    "shop_box_blankb",
    "shop_box_tickb",
    "shop_box_blank",
    "shop_box_tick",
    "shop_box_crossb",
    "shop_box_cross",
  },
  X = 415,
  Y = 3,
  Width = 35,
  Height = 35,
}

RageUI.CheckboxStyle = {
  Tick = 1,
  Cross = 2,
}

local function StyleCheckBox(Selected, Checked, Box, BoxSelect, OffSet)
  local CurrentMenu = RageUI.CurrentMenu
  if OffSet == nil then
    OffSet = 0
  end
  if Selected then
    if Checked then
      RenderSprite(
        SettingsCheckbox.Dictionary,
        SettingsCheckbox.Textures[Box],
        CurrentMenu.X + SettingsCheckbox.X + CurrentMenu.WidthOffset - OffSet,
        CurrentMenu.Y + SettingsCheckbox.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
        SettingsCheckbox.Width,
        SettingsCheckbox.Height
      )
    else
      RenderSprite(
        SettingsCheckbox.Dictionary,
        SettingsCheckbox.Textures[1],
        CurrentMenu.X + SettingsCheckbox.X + CurrentMenu.WidthOffset - OffSet,
        CurrentMenu.Y + SettingsCheckbox.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
        SettingsCheckbox.Width,
        SettingsCheckbox.Height
      )
    end
  else
    if Checked then
      RenderSprite(
        SettingsCheckbox.Dictionary,
        SettingsCheckbox.Textures[BoxSelect],
        CurrentMenu.X + SettingsCheckbox.X + CurrentMenu.WidthOffset - OffSet,
        CurrentMenu.Y + SettingsCheckbox.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
        SettingsCheckbox.Width,
        SettingsCheckbox.Height
      )
    else
      RenderSprite(
        SettingsCheckbox.Dictionary,
        SettingsCheckbox.Textures[3],
        CurrentMenu.X + SettingsCheckbox.X + CurrentMenu.WidthOffset - OffSet,
        CurrentMenu.Y + SettingsCheckbox.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
        SettingsCheckbox.Width,
        SettingsCheckbox.Height
      )
    end
  end
end

function RageUI.Checkbox(Label, Description, Checked, Style, Actions)
  local CurrentMenu = RageUI.CurrentMenu
  if CurrentMenu ~= nil then
    if CurrentMenu() then
      local Option = RageUI.Options + 1
      if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
        local Active = CurrentMenu.Index == Option

        RageUI.ItemsSafeZone(CurrentMenu)

        local haveLeftBadge = Style.LeftBadge and Style.LeftBadge ~= RageUI.BadgeStyle.None
        local haveRightBadge = (Style.RightBadge and Style.RightBadge ~= RageUI.BadgeStyle.None)
          or (
            not (Style.Enabled == true or Style.Enabled == nil)
            and Style.LockBadge ~= RageUI.BadgeStyle.None
          )
        local LeftBadgeOffset = haveLeftBadge and 27 or 0
        local RightBadgeOffset = haveRightBadge and 32 or 0

        local Hovered = false

        if
          CurrentMenu.EnableMouse == true and (CurrentMenu.CursorStyle == 0)
          or (CurrentMenu.CursorStyle == 1)
        then
          Hovered = RageUI.ItemsMouseBounds(CurrentMenu, Active, Option, SettingsButton)
        end

        if Style.Color and Style.Color.BackgroundColor then
          RenderRectangle(
            CurrentMenu.X,
            CurrentMenu.Y
              + SettingsButton.SelectedSprite.Y
              + CurrentMenu.SubtitleHeight
              + RageUI.ItemOffset,
            SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset,
            SettingsButton.SelectedSprite.Height - 3,
            255,
            255,
            255,
            255
          )
        end
        if Active then
          if Style.Color and Style.Color.HightLightColor then
            RenderRectangle(
              CurrentMenu.X,
              CurrentMenu.Y
                + SettingsButton.SelectedSprite.Y
                + CurrentMenu.SubtitleHeight
                + RageUI.ItemOffset,
              SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset,
              SettingsButton.SelectedSprite.Height - 3,
              Style.Color.HightLightColor[1],
              Style.Color.HightLightColor[2],
              Style.Color.HightLightColor[3],
              Style.Color.HightLightColor[4]
            )
          end
        end

        if Style.Enabled == true or Style.Enabled == nil then
          if Active then
            RenderRectangle(
              CurrentMenu.X + 10,
              CurrentMenu.Y
                + SettingsButton.SelectedSprite.Y
                + CurrentMenu.SubtitleHeight
                + RageUI.ItemOffset,
              SettingsButton.SelectedSprite.Width - 20 + CurrentMenu.WidthOffset,
              SettingsButton.SelectedSprite.Height - 3,
              13,
              13,
              13,
              255
            )
            -- Accent bar gris clair (Tactical Dark monochrome)
            RenderRectangle(
              CurrentMenu.X + 10,
              CurrentMenu.Y
                + SettingsButton.SelectedSprite.Y
                + CurrentMenu.SubtitleHeight
                + RageUI.ItemOffset,
              SettingsButton.SelectedSprite.Width - 447 + CurrentMenu.WidthOffset,
              SettingsButton.SelectedSprite.Height - 3,
              200,
              200,
              200,
              255
            )
            RenderText(
              Label,
              CurrentMenu.X - 7 + SettingsButton.Text.X + LeftBadgeOffset,
              CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
              0,
              SettingsButton.Text.Scale,
              255,
              255,
              255,
              255
            )
          else
            RenderRectangle(
              CurrentMenu.X + 10,
              CurrentMenu.Y
                + SettingsButton.SelectedSprite.Y
                + CurrentMenu.SubtitleHeight
                + RageUI.ItemOffset,
              SettingsButton.SelectedSprite.Width - 20 + CurrentMenu.WidthOffset,
              SettingsButton.SelectedSprite.Height - 3,
              13,
              13,
              13,
              255
            )
            -- Texte inactif gris clair (Tactical Dark theme)
            RenderText(
              Label,
              CurrentMenu.X - 7 + SettingsButton.Text.X + LeftBadgeOffset,
              CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
              0,
              SettingsButton.Text.Scale,
              170,
              170,
              170,
              255
            )
          end

          if Active then
            if Checked then
              RenderSprite(
                SettingsCheckbox.Dictionary,
                SettingsCheckbox.Textures[4],
                CurrentMenu.X + SettingsCheckbox.X + CurrentMenu.WidthOffset - 10,
                CurrentMenu.Y
                  + SettingsCheckbox.Y
                  + CurrentMenu.SubtitleHeight
                  + RageUI.ItemOffset
                  - 2,
                SettingsCheckbox.Width,
                SettingsCheckbox.Height,
                0,
                255,
                255,
                255,
                255
              )
            else
              RenderSprite(
                SettingsCheckbox.Dictionary,
                SettingsCheckbox.Textures[3],
                CurrentMenu.X + SettingsCheckbox.X + CurrentMenu.WidthOffset - 10,
                CurrentMenu.Y
                  + SettingsCheckbox.Y
                  + CurrentMenu.SubtitleHeight
                  + RageUI.ItemOffset
                  - 2,
                SettingsCheckbox.Width,
                SettingsCheckbox.Height,
                0,
                255,
                255,
                255,
                255
              )
            end
          else
            -- Checkbox inactif gris (Tactical Dark monochrome)
            if Checked then
              RenderSprite(
                SettingsCheckbox.Dictionary,
                SettingsCheckbox.Textures[4],
                CurrentMenu.X + SettingsCheckbox.X + CurrentMenu.WidthOffset - 10,
                CurrentMenu.Y
                  + SettingsCheckbox.Y
                  + CurrentMenu.SubtitleHeight
                  + RageUI.ItemOffset
                  - 2,
                SettingsCheckbox.Width,
                SettingsCheckbox.Height,
                0,
                136,
                136,
                136,
                255
              )
            else
              RenderSprite(
                SettingsCheckbox.Dictionary,
                SettingsCheckbox.Textures[3],
                CurrentMenu.X + SettingsCheckbox.X + CurrentMenu.WidthOffset - 10,
                CurrentMenu.Y
                  + SettingsCheckbox.Y
                  + CurrentMenu.SubtitleHeight
                  + RageUI.ItemOffset
                  - 2,
                SettingsCheckbox.Width,
                SettingsCheckbox.Height,
                0,
                136,
                136,
                136,
                255
              )
            end
          end

          if haveRightBadge then
            if Style.RightBadge ~= nil then
              local RightBadge = Style.RightBadge(Active)
              RenderSprite(
                RightBadge.BadgeDictionary or "commonmenu",
                RightBadge.BadgeTexture or "",
                CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset - 10,
                CurrentMenu.Y
                  + SettingsButton.RightBadge.Y
                  + CurrentMenu.SubtitleHeight
                  + RageUI.ItemOffset,
                SettingsButton.RightBadge.Width,
                SettingsButton.RightBadge.Height,
                0,
                255,
                255,
                255,
                255
              )
            end
          end

          if haveLeftBadge then
            local LeftBadge = Style.LeftBadge and Style.LeftBadge(Active)
            RenderSprite(
              LeftBadge.BadgeDictionary or "commonmenu",
              LeftBadge.BadgeTexture or "",
              CurrentMenu.X + SettingsButton.LeftBadge.X,
              CurrentMenu.Y
                + SettingsButton.LeftBadge.Y
                + CurrentMenu.SubtitleHeight
                + RageUI.ItemOffset,
              SettingsButton.LeftBadge.Width,
              SettingsButton.LeftBadge.Height,
              0,
              LeftBadge.BadgeColour and LeftBadge.BadgeColour.R or 255,
              LeftBadge.BadgeColour and LeftBadge.BadgeColour.G or 255,
              LeftBadge.BadgeColour and LeftBadge.BadgeColour.B or 255,
              LeftBadge.BadgeColour and LeftBadge.BadgeColour.A or 255
            )
          end
        else
          if haveRightBadge then
            local RightBadge = RageUI.BadgeStyle.Lock(Active)
            if Active then
              RenderRectangle(
                CurrentMenu.X + 10,
                CurrentMenu.Y
                  + SettingsButton.SelectedSprite.Y
                  + CurrentMenu.SubtitleHeight
                  + RageUI.ItemOffset,
                SettingsButton.SelectedSprite.Width - 20 + CurrentMenu.WidthOffset,
                SettingsButton.SelectedSprite.Height,
                13,
                13,
                13,
                255
              )
              -- Accent bar gris clair (Tactical Dark monochrome) - disabled state
              RenderRectangle(
                CurrentMenu.X + 10,
                CurrentMenu.Y
                  + SettingsButton.SelectedSprite.Y
                  + CurrentMenu.SubtitleHeight
                  + RageUI.ItemOffset,
                SettingsButton.SelectedSprite.Width - 447 + CurrentMenu.WidthOffset,
                SettingsButton.SelectedSprite.Height,
                200,
                200,
                200,
                255
              )
              RenderSprite(
                RightBadge.BadgeDictionary or "commonmenu",
                RightBadge.BadgeTexture or "",
                CurrentMenu.X - 10 + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset,
                CurrentMenu.Y
                  + SettingsButton.RightBadge.Y
                  + CurrentMenu.SubtitleHeight
                  + RageUI.ItemOffset,
                SettingsButton.RightBadge.Width,
                SettingsButton.RightBadge.Height,
                0,
                255,
                255,
                255,
                255
              )
            else
              RenderRectangle(
                CurrentMenu.X + 10,
                CurrentMenu.Y
                  + SettingsButton.SelectedSprite.Y
                  + CurrentMenu.SubtitleHeight
                  + RageUI.ItemOffset,
                SettingsButton.SelectedSprite.Width - 20 + CurrentMenu.WidthOffset,
                SettingsButton.SelectedSprite.Height,
                13,
                13,
                13,
                255
              )
              RenderSprite(
                RightBadge.BadgeDictionary or "commonmenu",
                RightBadge.BadgeTexture or "",
                CurrentMenu.X - 10 + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset,
                CurrentMenu.Y
                  + SettingsButton.RightBadge.Y
                  + CurrentMenu.SubtitleHeight
                  + RageUI.ItemOffset,
                SettingsButton.RightBadge.Width,
                SettingsButton.RightBadge.Height,
                0,
                255,
                255,
                255,
                255
              )
            end
          end

          if Active then
            RenderRectangle(
              CurrentMenu.X + 10,
              CurrentMenu.Y
                + SettingsButton.SelectedSprite.Y
                + CurrentMenu.SubtitleHeight
                + RageUI.ItemOffset,
              SettingsButton.SelectedSprite.Width - 20 + CurrentMenu.WidthOffset,
              SettingsButton.SelectedSprite.Height,
              13,
              13,
              13,
              255
            )
            -- Accent bar gris clair (Tactical Dark monochrome)
            RenderRectangle(
              CurrentMenu.X + 10,
              CurrentMenu.Y
                + SettingsButton.SelectedSprite.Y
                + CurrentMenu.SubtitleHeight
                + RageUI.ItemOffset,
              SettingsButton.SelectedSprite.Width - 447 + CurrentMenu.WidthOffset,
              SettingsButton.SelectedSprite.Height,
              200,
              200,
              200,
              255
            )
            RenderText(
              Label,
              CurrentMenu.X - 7 + SettingsButton.Text.X + LeftBadgeOffset,
              CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
              0,
              SettingsButton.Text.Scale,
              255,
              255,
              255,
              255
            )
          else
            RenderRectangle(
              CurrentMenu.X + 10,
              CurrentMenu.Y
                + SettingsButton.SelectedSprite.Y
                + CurrentMenu.SubtitleHeight
                + RageUI.ItemOffset,
              SettingsButton.SelectedSprite.Width - 20 + CurrentMenu.WidthOffset,
              SettingsButton.SelectedSprite.Height,
              13,
              13,
              13,
              255
            )
            -- Texte inactif gris clair (Tactical Dark theme)
            RenderText(
              Label,
              CurrentMenu.X - 7 + SettingsButton.Text.X + LeftBadgeOffset,
              CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
              0,
              SettingsButton.Text.Scale,
              170,
              170,
              170,
              255
            )
          end

          if haveLeftBadge then
            local LeftBadge = Style.LeftBadge and Style.LeftBadge(Active)
            RenderSprite(
              LeftBadge.BadgeDictionary or "commonmenu",
              LeftBadge.BadgeTexture or "",
              CurrentMenu.X + SettingsButton.LeftBadge.X,
              CurrentMenu.Y
                + SettingsButton.LeftBadge.Y
                + CurrentMenu.SubtitleHeight
                + RageUI.ItemOffset,
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

        if
          Active
          and (CurrentMenu.Controls.Select.Active or (Hovered and CurrentMenu.Controls.Click.Active))
          and (Style.Enabled == true or Style.Enabled == nil)
        then
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

        RageUI.ItemsDescription(CurrentMenu, Description, Active)

        if (Actions.onSelected ~= nil) and Active then
          Actions.onSelected(Checked)
        end
      end
      RageUI.Options = RageUI.Options + 1
    end
  end
end

Items.Checkbox = RageUI.Checkbox

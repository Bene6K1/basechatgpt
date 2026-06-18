---@type table
---@
---@




local SettingsButton = {
    Rectangle = { Y = 0, Width = 500, Height = 47 },
    Text = { X = -6, Y = 27, Scale = 0.25 },
    SelectedSprite = { Dictionary = "utils", Texture = "gradient_nav", Y = 0, Width = 440, Height = 38 },
}

---@type table
local SettingsSlider = {
    Background = { X = 220, Y = 35.5, Width = 150, Height = 7 },
    Slider = { X = 220, Y = 35.5, Width = 65, Height = 7 },
    Divider = { X = 293.5, Y = 30, Width = 2.5, Height = 18 },
    LeftArrow = { Dictionary = "mpleaderboard", Texture = "leaderboard_female_icon", X = 190, Y = 23, Width = 35, Height = 33 },
    RightArrow = { Dictionary = "mpleaderboard", Texture = "leaderboard_male_icon", X = 365, Y = 23, Width = 35, Height = 33 },

}

local Items = {}
for i = 1, 10 do
    table.insert(Items, i)
end



function RageUI.UISliderHeritage(Label, ItemIndex, Description, Actions, Value)
    local CurrentMenu = RageUI.CurrentMenu;
    local Audio = RageUI.Settings.Audio

    if CurrentMenu ~= nil then
        if CurrentMenu() then
            ---@type number
            local Option = RageUI.Options + 1

            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                ---@type number
                local value = Value or 0.1
                local Selected = CurrentMenu.Index == Option

                ---@type boolean
                local LeftArrowHovered, RightArrowHovered = false, false

                RageUI.ItemsSafeZone(CurrentMenu)

                local ItemsOffsetY = (Config and Config.RageUI and Config.RageUI.itemsOffsetY) or 0

                local Hovered = false;
                local RightOffset = 0

                ---@type boolean
                if CurrentMenu.EnableMouse == true and (CurrentMenu.CursorStyle == 0) or (CurrentMenu.CursorStyle == 1) then
                    Hovered = RageUI.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton);
                end

                do
                                        local boxX = CurrentMenu.X
                    local ItemBaseY = (Config and Config.RageUI and Config.RageUI.itemBaseY) or 20
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
                        CurrentMenu.X + SettingsSlider.LeftArrow.X + CurrentMenu.SafeZoneSize.X + CurrentMenu
                        .WidthOffset,
                        CurrentMenu.Y + ItemsOffsetY + SettingsSlider.LeftArrow.Y + CurrentMenu.SafeZoneSize.Y +
                        CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsSlider.LeftArrow.Width,
                        SettingsSlider.LeftArrow.Height)
                    RightArrowHovered = RageUI.IsMouseInBounds(
                        CurrentMenu.X + SettingsSlider.RightArrow.X + CurrentMenu.SafeZoneSize.X +
                        CurrentMenu.WidthOffset,
                        CurrentMenu.Y + ItemsOffsetY + SettingsSlider.RightArrow.Y + CurrentMenu.SafeZoneSize.Y +
                        CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsSlider.RightArrow.Width,
                        SettingsSlider.RightArrow.Height)
                end

                RightOffset = RightOffset

                if Selected then
                    RenderText(Label, 28 + CurrentMenu.X + SettingsButton.Text.X,
                        CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0,
                        SettingsButton.Text.Scale, 255, 255, 255, 255)

                    RenderSprite(SettingsSlider.LeftArrow.Dictionary, SettingsSlider.LeftArrow.Texture,
                        CurrentMenu.X + SettingsSlider.LeftArrow.X + CurrentMenu.WidthOffset - RightOffset,
                        CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsSlider.LeftArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
                        SettingsSlider.LeftArrow.Width, SettingsSlider.LeftArrow.Height, 0, 255, 255, 255, 255)
                    RenderSprite(SettingsSlider.RightArrow.Dictionary, SettingsSlider.RightArrow.Texture,
                        CurrentMenu.X + SettingsSlider.RightArrow.X + CurrentMenu.WidthOffset - RightOffset,
                        CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsSlider.RightArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
                        SettingsSlider.RightArrow.Width, SettingsSlider.RightArrow.Height, 0, 255, 255, 255, 255)
                else
                    RenderText(Label, 28 + CurrentMenu.X + SettingsButton.Text.X,
                        CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0,
                        SettingsButton.Text.Scale, 163, 159, 148, 255)

                    RenderSprite(SettingsSlider.LeftArrow.Dictionary, SettingsSlider.LeftArrow.Texture,
                        CurrentMenu.X + SettingsSlider.LeftArrow.X + CurrentMenu.WidthOffset - RightOffset,
                        CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsSlider.LeftArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
                        SettingsSlider.LeftArrow.Width, SettingsSlider.LeftArrow.Height, 0, 255, 255, 255, 255)
                    RenderSprite(SettingsSlider.RightArrow.Dictionary, SettingsSlider.RightArrow.Texture,
                        CurrentMenu.X + SettingsSlider.RightArrow.X + CurrentMenu.WidthOffset - RightOffset,
                        CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsSlider.RightArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
                        SettingsSlider.RightArrow.Width, SettingsSlider.RightArrow.Height, 0, 255, 255, 255, 255)
                end

                RenderRectangle(CurrentMenu.X + SettingsSlider.Background.X + CurrentMenu.WidthOffset - RightOffset,
                    CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsSlider.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
                    SettingsSlider.Background.Width, SettingsSlider.Background.Height, 22, 22, 22, 255)
                RenderRectangle(
                    CurrentMenu.X + SettingsSlider.Slider.X +
                    (((SettingsSlider.Background.Width - SettingsSlider.Slider.Width) / (#Items)) * (ItemIndex)) +
                    CurrentMenu.WidthOffset - RightOffset,
                    CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsSlider.Slider.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
                    SettingsSlider.Slider.Width, SettingsSlider.Slider.Height, 130, 130, 130, 255)

                RenderRectangle(CurrentMenu.X + SettingsSlider.Divider.X + CurrentMenu.WidthOffset,
                    CurrentMenu.Y + ItemBaseY + ItemsOffsetY + SettingsSlider.Divider.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
                    SettingsSlider.Divider.Width, SettingsSlider.Divider.Height, 245, 245, 245, 255)

                RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height

                RageUI.ItemsDescription(CurrentMenu, Description, Selected);

                if Selected and (CurrentMenu.Controls.SliderLeft.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)) and not (CurrentMenu.Controls.SliderRight.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered)) then
                    ItemIndex = ItemIndex - value
                    if ItemIndex < 0.1 then
                        ItemIndex = 0.0
                    else
                        RageUI.PlaySound(Audio[Audio.Use].Slider.audioName, Audio[Audio.Use].Slider.audioRef, true)
                    end
                    if (Actions.onSliderChange ~= nil) then
                        Actions.onSliderChange(ItemIndex / 10, ItemIndex);
                    end
                elseif Selected and (CurrentMenu.Controls.SliderRight.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered)) and not (CurrentMenu.Controls.SliderLeft.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)) then
                    ItemIndex = ItemIndex + value
                    if ItemIndex > #Items then
                        ItemIndex = 10
                    else
                        RageUI.PlaySound(Audio[Audio.Use].Slider.audioName, Audio[Audio.Use].Slider.audioRef, true)
                    end
                    if (Actions.onSliderChange ~= nil) then
                        Actions.onSliderChange(ItemIndex / 10, ItemIndex);
                    end
                end

                if Selected and (CurrentMenu.Controls.Select.Active or ((Hovered and CurrentMenu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) then
                    if (Actions.onSelected ~= nil) then
                        Actions.onSelected(ItemIndex / 10, ItemIndex);
                    end
                    RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef, false)
                elseif Selected then
                    if (Actions.onActive ~= nil) then
                        Actions.onActive()
                    end
                end
            end

            RageUI.Options = RageUI.Options + 1
        end
    end
end

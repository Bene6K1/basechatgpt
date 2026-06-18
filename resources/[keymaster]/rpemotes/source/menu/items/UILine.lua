local SettingsLine = {
    Rectangle = { Y = 0, Width = 450, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.25 },
    LeftBadge = { X = 15, Y = 1, Width = 35, Height = 35 },
    RightBadge = { X = 396, Y = 0, Width = 35, Height = 35 },
    RightText = { X = 436, Y = 3, Scale = 0.25 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 450, Height = 38 },
}

function RageUI.Line()
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu then
            local Option = RageUI.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                RenderSprite("RageUILine", "UILine", CurrentMenu.X + SettingsLine.Text.X, CurrentMenu.Y + SettingsLine.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 400, 4, 255, CurrentMenu.ButtonColor.R, CurrentMenu.ButtonColor.G, CurrentMenu.ButtonColor.B, CurrentMenu.ButtonColor.A)
                RageUI.ItemOffset = RageUI.ItemOffset + SettingsLine.Rectangle.Height + 0
                if (CurrentMenu.Index == Option) then
                    if (RageUI.LastControl) then
                        CurrentMenu.Index = Option - 1
                        if (CurrentMenu.Index < 1) then
                            CurrentMenu.Index = RageUI.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 1
                    end
                end
            end
            RageUI.Options = RageUI.Options + 1
        end
    end
end
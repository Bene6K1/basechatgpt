local SettingsButton = {
  Rectangle = { Y = 0, Width = 491, Height = 38 },
  Text = { X = 25, Y = 16, Scale = 0.33 },
  LeftBadge = { Y = -2, Width = 40, Height = 40 },
  RightBadge = { X = 456, Y = 4, Width = 30, Height = 30 },
  RightText = { X = 420, Y = 4, Scale = 0.35 },
  SelectedSprite = {
    Dictionary = "commonmenu",
    Texture = "gradient_nav",
    Y = 0,
    Width = 491,
    Height = 38,
  },
}

function Items:Line()
  local CurrentMenu = RageUI.CurrentMenu
  if CurrentMenu ~= nil then
    if CurrentMenu then
      local Option = RageUI.Options + 1
      if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
        RenderSprite(
          "RageUILine",
          "UILine",
          CurrentMenu.X + SettingsButton.Text.X,
          CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
          400,
          4,
          255,
          153,
          153,
          153,
          255
        )
        RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height + 0
        if CurrentMenu.Index == Option then
          if RageUI.LastControl then
            CurrentMenu.Index = Option - 1
            if CurrentMenu.Index < 1 then
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

function RageUI.Line()
  return Items:Line()
end

function Items:WLine()
  local CurrentMenu = RageUI.CurrentMenu
  if CurrentMenu ~= nil then
    if CurrentMenu then
      local Option = RageUI.Options + 1
      if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
        RenderSprite(
          "RageUILine",
          "UILine",
          CurrentMenu.X + SettingsButton.Text.X,
          CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
          400,
          2,
          255,
          153,
          153,
          153,
          255
        )
        RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height + 0
        if CurrentMenu.Index == Option then
          if RageUI.LastControl then
            CurrentMenu.Index = Option - 1
            if CurrentMenu.Index < 1 then
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

function RageUI.WLine()
  return Items:WLine()
end

Items.WLine = Items.WLine

function Panels:info(Title, LeftText, RightText, Index, startAt)
  local CurrentMenu = RageUI.CurrentMenu
  local LineCount = (
    RightText and LeftText and #LeftText >= #RightText and #LeftText or LeftText and #LeftText
  ) or 1
  if CurrentMenu then
    if
      (not Index and not startAt)
      or ((not Index and startAt) and CurrentMenu.Index >= startAt)
      or ((not startAt and Index) and CurrentMenu.Index == Index)
    then
      if Title ~= nil then
        RenderText("~h~| " .. Title .. "~h~", 466, 7, 0, 0.38, 255, 255, 255, 255, 0)
      end
      if LeftText ~= nil then
        local leftTextString = table.concat(LeftText, "\n")
        RenderText(
          "~c~" .. leftTextString,
          466,
          Title ~= nil and 43 or 7,
          0,
          0.22,
          255,
          255,
          255,
          255,
          0
        )
      end
      if RightText ~= nil then
        RenderText(
          table.concat(RightText, "\n"),
          846,
          Title ~= nil and 43 or 7,
          0,
          0.22,
          255,
          255,
          255,
          255,
          2
        )
      end
      RenderRectangle(456, 0, 400, Title ~= nil and 50 + (LineCount * 23), 10, 10, 10, 220)

      RenderRectangle(456, 50 + (LineCount * 23), 400, Title ~= nil and 3, 180, 180, 180, 200)
    end
  end
end

function RageUI.Info(Title, LeftText, RightText, Index, startAt)
  return Panels:info(Title, LeftText, RightText, Index, startAt)
end

RageUI = {}

RageUI.Item = {}

RageUI.Panel = {}

RageUI.Window = {}

RMenu = setmetatable({}, RMenu)

local TotalMenus = {}

function RMenu.Add(Type, Name, Menu)
  local typeTable = RMenu[Type]
  if typeTable ~= nil then
    typeTable[Name] = { Menu = Menu }
  else
    RMenu[Type] = { [Name] = { Menu = Menu } }
  end
  return table.insert(TotalMenus, Menu)
end

function RMenu:Get(Type, Name)
  if self[Type] ~= nil and self[Type][Name] ~= nil then
    return self[Type][Name].Menu
  end
end

function RMenu:GetType(Type)
  if self[Type] ~= nil then
    return self[Type]
  end
end

function RMenu:Settings(Type, Name, Settings, Value)
  if Value ~= nil then
    self[Type][Name][Settings] = Value
  else
    return self[Type][Name][Settings]
  end
end

function RMenu:Delete(Type, Name)
  self[Type][Name] = nil
  collectgarbage()
end

function RMenu:DeleteType(Type)
  self[Type] = nil
  collectgarbage()
end

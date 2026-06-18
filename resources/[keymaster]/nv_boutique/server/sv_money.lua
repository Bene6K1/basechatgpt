function GiveMoney(playerId, amount)
  local xPlayer = ESX.GetPlayerFromId(playerId)
  if xPlayer == nil then
    return
  end
  xPlayer.addAccountMoney(Config.AccountName, amount)
end

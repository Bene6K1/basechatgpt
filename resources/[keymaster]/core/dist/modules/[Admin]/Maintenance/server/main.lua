-- CreateThread(function()
    
--     function IsMaintenaceOpen(value)
--         SunnyConfigServ.MaintenancePerm.Active = value

--         MySQL.Async.execute('UPDATE maintenant SET active = @active', {
--             ['@active'] = value
--         }, function()
--             if SunnyConfigServ.MaintenancePerm.Active then
--                 ESX.toConsole('La maintenance est désormais active')
--             else
--                 ESX.toConsole('La maintenance est désormais inactive')
--             end
--         end)
--     end
    
--     RegisterCommand('maintenance', function(source)
--         if source == 0 then
--             SunnyConfigServ.MaintenancePerm.Active = not SunnyConfigServ.MaintenancePerm.Active
    
--             IsMaintenaceOpen(SunnyConfigServ.MaintenancePerm.Active)
--         end
--     end)

--     MySQL.Async.fetchAll('SELECT * FROM maintenant', {}, function(result)
--         if result[1].active == true then
--             IsMaintenaceOpen(true)
--         end
--     end)
-- end)
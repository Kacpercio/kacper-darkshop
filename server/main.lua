ESX = nil
local ile = {}
local ile_broni= 4
local ile_radia = {}
local brak_broni 
local brak_radia
local odlicza1 = false
local odlicza2 = false

ESX = exports.es_extended:getSharedObject()

local allEvents = {
    ["get_item"] = false
}
local fiveguard_resource = ""
AddEventHandler("fg:ExportsLoaded", function(fiveguard_res, res)
    if res == "*" or res == GetCurrentResourceName() then
        fiveguard_resource = fiveguard_res
        for event,cross_scripts in pairs(allEvents) do
            local retval, errorText = exports[fiveguard_res]:RegisterSafeEvent(event, {
                ban = true,
                log = true
            }, cross_scripts)
            if not retval then
                print("[fiveguard safe-events] "..errorText)
            end
        end
    end
end)

-- to pod callbacki 
AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	print('Wystartowano ' .. resourceName)
	table.insert(ile, 1, ile_broni)
	table.insert(ile_radia, 1, ile_broni)
  end)

RegisterServerEvent('get_item')
AddEventHandler('get_item', function(id, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemcheck = xPlayer.getInventoryItem('black_money')
	if not exports['betterrp-lornetka']:VerifyToken(source) then return end

	if itemcheck.count >= tonumber(amount) then 
		if id == 1 then
			for k, v in pairs(ile) do
				if v > 0 and odlicza1 == false then
					ile[k] = v - 1
					xPlayer.addInventoryItem('weapon_pistol', 1)
					xPlayer.removeInventoryItem('black_money', amount)
				else
					TriggerClientEvent("libNotification", source, "Powiadomienie", "Nie mam już towaru stary!", 'inform')
					brak_broni = true
					if odlicza1 == false then
						TriggerEvent('get_cooldown')
					end
				end
			end
		elseif id == 2 then
			for k, v in pairs(ile_radia) do
				if v > 0 and odlicza2 == false then
					ile_radia[k] = v - 1
					xPlayer.addInventoryItem('radiocrime', 1)
					xPlayer.removeInventoryItem('black_money', amount)
				else
					TriggerClientEvent("libNotification", source, "Powiadomienie", "Nie mam już towaru stary!", 'inform')
					brak_radia = true
					if odlicza2 == false then
						TriggerEvent('get_cooldown')
					end
				end
			end
		elseif id == 3 then
			xPlayer.addInventoryItem('handcuffs', 1)
			xPlayer.removeInventoryItem('black_money', amount)
		end
	else
		TriggerClientEvent("libNotification", source, "Powiadomienie", "Nie masz wystarczająco dużo pieniędzy", 'inform')
	end
end)

RegisterServerEvent('get_cooldown')
AddEventHandler('get_cooldown', function ()
	local czas_broni = 0

	while brak_broni and czas_broni < 7200 do
		odlicza1 = true
		Wait(1000)
		czas_broni = czas_broni + 1
	end

	if czas_broni >= 7200 then 
		table.remove(ile, 1)
		table.insert(ile, 1, ile_broni)
		brak_broni = false
		odlicza1 = false
	end

	local czas_radia = 0 

	while brak_radia and czas_radia < 3600 do
		odlicza2 = true
		Wait(1000)
		czas_radia = czas_radia + 1
	end

	if czas_radia >= 3600 then
		table.remove(ile_radia, 1)
		table.insert(ile_radia, 1, ile_broni)
		brak_radia = false
		odlicza2 = false
	end
end)
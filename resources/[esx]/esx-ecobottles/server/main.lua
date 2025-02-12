local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

RegisterServerEvent("esx-ecobottles:sellBottles")
AddEventHandler("esx-ecobottles:sellBottles", function()
    local player = ESX.GetPlayerFromId(source)

    local currentBottles = player.getInventoryItem("bottle")["count"]
    
    if currentBottles > 0 then
        math.randomseed(os.time())
        local randomMoney = math.random((Config.BottleReward[1] or 1), (Config.BottleReward[2] or 4))

        player.removeInventoryItem("bottle", currentBottles)
        player.addMoney(randomMoney * currentBottles)

        TriggerClientEvent("esx:showNotification", source, ("You gave the store %s bottles and got paid $%s."):format(currentBottles, currentBottles * randomMoney))
    else
        TriggerClientEvent("esx:showNotification", source, "You don't have any bottles to give the store.")
    end
end)

RegisterServerEvent("esx-ecobottles:retrieveBottle")
AddEventHandler("esx-ecobottles:retrieveBottle", function()
    local player = ESX.GetPlayerFromId(source)

    math.randomseed(os.time())
    local luck = math.random(0, 100)
    local randomBottle = math.random((Config.BottleRecieve[1] or 1), (Config.BottleRecieve[2] or 6))

    if luck >= 0 and luck <= 29 then
        TriggerClientEvent("esx:showNotification", source, "The bin has nothing in it.")
	end
    if luck >= 30 and luck <= 70 then
        player.addInventoryItem("bottle", randomBottle)
        TriggerClientEvent("esx:showNotification", source, ("You found x%s bottles"):format(randomBottle))
    end
	 if luck >= 71 and luck <= 75 then
        player.addInventoryItem("bobbypin", randomBottle)
        TriggerClientEvent("esx:showNotification", source, ("You found x%s bobbypins"):format(randomBottle))
    end
	if luck >= 76 and luck <= 84 then
        player.addInventoryItem("rubberband", randomBottle)
        TriggerClientEvent("esx:showNotification", source, ("You found x%s rubberbands"):format(randomBottle))
    end
	if luck >= 85 and luck <= 100 then
        player.addInventoryItem("solvent", 1)
        TriggerClientEvent("esx:showNotification", source, ("You found x%s solvents"):format(randomBottle))
    end
end)


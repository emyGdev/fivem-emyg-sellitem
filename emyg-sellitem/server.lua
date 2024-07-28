local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('npc:getItemAmount', function(source, cb, item)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local itemData = xPlayer.Functions.GetItemByName(item)
    local amount = itemData and itemData.amount or 0
    cb(amount)
end)

RegisterNetEvent('npc:sellItem')
AddEventHandler('npc:sellItem', function(item, price)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local amount = xPlayer.Functions.GetItemByName(item).amount

    if amount > 0 then
        xPlayer.Functions.RemoveItem(item, amount)
        xPlayer.Functions.AddMoney('cash', amount * price)
        TriggerClientEvent('QBCore:Notify', src, amount .. " adet " .. item .. " sattınız ve $" .. (amount * price) .. " kazandınız.", 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, "Envanterinizde " .. item .. " yok.", 'error')
    end
end)

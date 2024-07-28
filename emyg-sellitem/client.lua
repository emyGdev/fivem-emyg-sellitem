local QBCore = exports['qb-core']:GetCoreObject()
local isSelling = false

CreateThread(function()
    for _, npc in pairs(Config.NPCs) do
        RequestModel(GetHashKey(npc.model))
        while not HasModelLoaded(GetHashKey(npc.model)) do
            Wait(1)
        end

        local ped = CreatePed(4, npc.model, npc.coords.x, npc.coords.y, npc.coords.z - 1.0, npc.heading, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)

        if npc.blip.enabled then
            local blip = AddBlipForCoord(npc.coords.x, npc.coords.y, npc.coords.z)
            SetBlipSprite(blip, npc.blip.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, npc.blip.scale)
            SetBlipColour(blip, npc.blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(npc.blip.name)
            EndTextCommandSetBlipName(blip)
        end

        exports['qb-target']:AddTargetEntity(ped, {
            options = {
                {
                    event = 'npc:sellItems',
                    icon = 'fas fa-shopping-cart',
                    label = 'Ürün Sat',
                    npc = npc
                }
            },
            distance = 2.5
        })
    end
end)

RegisterNetEvent('npc:sellItems')
AddEventHandler('npc:sellItems', function(data)
    local items = data.npc.items
    local menu = {}

    table.insert(menu, {
        header = data.npc.blip.name,
        isMenuHeader = true
    })

    for _, item in pairs(items) do
        table.insert(menu, {
            header = item.label,
            txt = "Satış Fiyatı: $" .. item.price,
            params = {
                event = 'npc:confirmSell',
                args = item
            }
        })
    end

    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('npc:confirmSell')
AddEventHandler('npc:confirmSell', function(item)
    QBCore.Functions.TriggerCallback('npc:getItemAmount', function(amount)
        if amount > 0 then
            isSelling = true
            QBCore.Functions.Progressbar("sell_item", "Ürün Satılıyor...", 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "mp_common",
                anim = "givetake1_a",
                flags = 49,
            }, {}, {}, function() -- Done
                if isSelling then
                    isSelling = false
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('npc:sellItem', item.value, item.price)
                end
            end, function() -- Cancel
                if isSelling then
                    isSelling = false
                    ClearPedTasks(PlayerPedId())
                    QBCore.Functions.Notify("Satış iptal edildi.", "error")
                end
            end)

            CreateThread(function()
                while isSelling do
                    Wait(0)
                    if IsControlJustPressed(0, 73) then -- X tuşuna basınca
                        isSelling = false
                        ClearPedTasks(PlayerPedId())
                        QBCore.Functions.Notify("Satış iptal edildi.", "error")
                        TriggerEvent('progressbar:client:cancel')
                    end
                end
            end)
        else
            QBCore.Functions.Notify("Envanterinizde " .. item.label .. " yok.", "error")
        end
    end, item.value)
end)

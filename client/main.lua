ESX = exports.es_extended:getSharedObject()

exports['qtarget']:AddBoxZone("dsnakolach", vector3(1130.73, -1997.87, 50.16), 1, 1, {
    name="dsnakolach",
    heading=325,
    debugPoly=false,
    minZ=49.86,
    maxZ=51.86
    }, {
        options = {
            {
                event = "get_data",
                icon = "fa-solid fa-gun",
                label = "Zakup Pistolet",
                price = 20000,
                id = 1,
            },
            {
                event = "get_data",
                icon = "fa-solid fa-walkie-talkie",
                label = "Zakup Radio",
                price = 6000,
                id = 2,
            },
            {
                event = "get_data",
                icon = "fa-solid fa-handcuffs",
                label = "Zakup Kajdanki",
                price = 3000,
                id = 3,
            },
            
        },
        distance = 2.0
})

RegisterNetEvent('get_data')
AddEventHandler('get_data', function(data)
    local source = source
    exports["betterrp-lornetka"]:ExecuteServerEvent("get_item", data.id, data.price)
end) 


RegisterNetEvent("libNotification")
AddEventHandler("libNotification", function(title, msg, type)
    lib.notify({
        title = title,
        description = msg,
        type = type
    })
end)



QBLib = QBLib or {}

CT = function(h) 
    CreateThread(h)
end

TC = function(name, ...)
    TriggerClientEvent(name, ...)
end

TS = function(name, ...)
    TriggerServerEvent(name, ...)
end

TE = function(name, ...)
    TriggerEvent(name, ...)
end

RE = function(name, ...)
    RegisterNetEvent(name, ...)
end

PP = function(...)
    print(...)
end

GetCoords = function(entity)
    local coords = nil
    local heading = nil 
    if entity then 
        coords = GetEntityCoords(entity)
        heading = GetEntityHeading(entity) 
    else
        local ped = PlayerPedId()
        coords = GetEntityCoords(ped)
        heading = GetEntityHeading(ped) 
    end
    return vector4(coords.x, coords.y, coords.z, heading)
end
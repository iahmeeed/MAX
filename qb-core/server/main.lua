QBCore = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.ClientCallbacks = {}
QBCore.ServerCallbacks = {}
QBCore.QBResources = {}

exports('GetCoreObject', function()
    return QBCore
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local QBCore = exports['qb-core']:GetCoreObject()


CreateThread(function()
    local result = MySQL.Sync.fetchAll('SELECT * FROM permissions', {})
    if result[1] then
        for k, v in pairs(result) do
            QBCore.Config.Server.PermissionList[v.license] = {
                license = v.license,
                permission = v.permission,
                optin = true,
            }
        end
    end
end)

local blockedRecourseList = {
    ["_cfx_internal"] = true,
    ["fivem"] = true,
}
for i = 0, GetNumResources(), 1 do
    local resource_name = GetResourceByFindIndex(i)
    if resource_name then
        if not blockedRecourseList[resource_name] then -- Ignore these two base resources. Others are ok.
            QBCore.QBResources[resource_name] = true 
        end
    end
end
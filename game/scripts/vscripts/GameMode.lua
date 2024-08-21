local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local ____exports = {}
____exports.AddonGameMode = __TS__Class()
local AddonGameMode = ____exports.AddonGameMode
AddonGameMode.name = "AddonGameMode"
function AddonGameMode.prototype.____constructor(self)
end
function AddonGameMode.Precache(context)
end
function AddonGameMode.Activate()
    GameRules.Addon = __TS__New(____exports.AddonGameMode)
end
return ____exports

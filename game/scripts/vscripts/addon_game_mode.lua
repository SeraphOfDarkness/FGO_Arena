local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local ____exports = {}
require("libs.timers")
local ____GameMode = require("GameMode")
local AddonGameMode = ____GameMode.AddonGameMode
__TS__ObjectAssign(
    getfenv(),
    {Activate = AddonGameMode.Activate, Precache = AddonGameMode.Precache}
)
return ____exports

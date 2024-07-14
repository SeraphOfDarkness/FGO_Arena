local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 5,["10"] = 5,["11"] = 5,["12"] = 5});
local ____exports = {}
require("libs.timers")
local ____GameMode = require("GameMode")
local AddonGameMode = ____GameMode.AddonGameMode
__TS__ObjectAssign(
    getfenv(),
    {Activate = AddonGameMode.Activate, Precache = AddonGameMode.Precache}
)
return ____exports

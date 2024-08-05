local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 11,["8"] = 11,["9"] = 11,["11"] = 14,["12"] = 74,["13"] = 75,["14"] = 72,["15"] = 16,["16"] = 18,["17"] = 19,["18"] = 16,["19"] = 22,["20"] = 24,["21"] = 24,["22"] = 24,["23"] = 24,["24"] = 24,["25"] = 22,["26"] = 27,["27"] = 29,["28"] = 30,["29"] = 31,["30"] = 27,["31"] = 34,["32"] = 36,["33"] = 37,["34"] = 38,["35"] = 39,["36"] = 40,["37"] = 34,["38"] = 43,["39"] = 45,["40"] = 46,["41"] = 47,["42"] = 48,["43"] = 43,["44"] = 51,["45"] = 53,["47"] = 55,["66"] = 51,["67"] = 78,["68"] = 78,["69"] = 82,["70"] = 84,["71"] = 82});
local ____exports = {}
____exports.AddonGameMode = __TS__Class()
local AddonGameMode = ____exports.AddonGameMode
AddonGameMode.name = "AddonGameMode"
function AddonGameMode.prototype.____constructor(self)
    self.PlayersPerTeam = 0
    self.GameMode = GameRules:GetGameModeEntity()
    self:Configure()
end
function AddonGameMode.prototype.Configure(self)
    self:RegisterEventListeners()
    self:DefaultConfiguration()
end
function AddonGameMode.prototype.RegisterEventListeners(self)
    ListenToGameEvent(
        "game_rules_state_change",
        function() return self:OnGameStateChange() end,
        nil
    )
end
function AddonGameMode.prototype.DefaultConfiguration(self)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, self.PlayersPerTeam)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, self.PlayersPerTeam)
    self:Setup_3v3v3v3()
end
function AddonGameMode.prototype.Setup_3v3v3v3(self)
    self.PlayersPerTeam = 3
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_1, self.PlayersPerTeam)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_2, self.PlayersPerTeam)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_3, self.PlayersPerTeam)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_4, self.PlayersPerTeam)
end
function AddonGameMode.prototype.Setup_4v4v4(self)
    self.PlayersPerTeam = 4
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_1, self.PlayersPerTeam)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_2, self.PlayersPerTeam)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_3, self.PlayersPerTeam)
end
function AddonGameMode.prototype.OnGameStateChange(self)
    local CurrentState = GameRules:State_Get()
    repeat
        local ____switch10 = CurrentState
        local ____cond10 = ____switch10 == DOTA_GAMERULES_STATE_HERO_SELECTION
        if ____cond10 then
            do
                break
            end
        end
        ____cond10 = ____cond10 or ____switch10 == DOTA_GAMERULES_STATE_WAIT_FOR_MAP_TO_LOAD
        if ____cond10 then
            do
                break
            end
        end
        do
            do
                break
            end
        end
    until true
end
function AddonGameMode.Precache(self, context)
end
function AddonGameMode.Activate(self)
    GameRules.Addon = __TS__New(____exports.AddonGameMode)
end
return ____exports

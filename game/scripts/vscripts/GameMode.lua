local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 11,["8"] = 11,["9"] = 11,["11"] = 76,["12"] = 77,["13"] = 74,["14"] = 15,["15"] = 17,["16"] = 18,["17"] = 15,["18"] = 21,["19"] = 23,["20"] = 23,["21"] = 23,["22"] = 23,["23"] = 23,["24"] = 21,["25"] = 26,["26"] = 28,["27"] = 30,["28"] = 31,["29"] = 33,["30"] = 26,["31"] = 36,["32"] = 38,["33"] = 39,["34"] = 40,["35"] = 41,["36"] = 36,["37"] = 44,["38"] = 46,["39"] = 47,["40"] = 48,["41"] = 44,["42"] = 51,["43"] = 53,["45"] = 54,["50"] = 58,["51"] = 58,["52"] = 60,["53"] = 61,["54"] = 62,["55"] = 63,["56"] = 58,["68"] = 51,["69"] = 80,["70"] = 80,["71"] = 84,["72"] = 86,["73"] = 84});
local ____exports = {}
____exports.AddonGameMode = __TS__Class()
local AddonGameMode = ____exports.AddonGameMode
AddonGameMode.name = "AddonGameMode"
function AddonGameMode.prototype.____constructor(self)
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
    GameRules:SetCustomGameSetupTimeout(60)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 0)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 0)
    self:Setup_3v3v3v3()
end
function AddonGameMode.prototype.Setup_3v3v3v3(self)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_1, 3)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_2, 3)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_3, 3)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_4, 3)
end
function AddonGameMode.prototype.Setup_4v4v4(self)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_1, 4)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_2, 4)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_3, 4)
end
function AddonGameMode.prototype.OnGameStateChange(self)
    local CurrentState = GameRules:State_Get()
    repeat
        local ____switch10 = CurrentState
        local ____cond10 = ____switch10 == DOTA_GAMERULES_STATE_WAIT_FOR_MAP_TO_LOAD
        if ____cond10 then
            do
                do
                    local i = 0
                    while i <= PlayerResource:GetNumConnectedHumanPlayers() do
                        local PlayerId = i
                        local Hero = PlayerResource:GetSelectedHeroEntity(PlayerId)
                        print(Hero and Hero:GetName())
                        print(PlayerResource:GetSteamAccountID(PlayerId))
                        i = i + 1
                    end
                end
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

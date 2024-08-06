local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 1,["10"] = 11,["11"] = 11,["12"] = 11,["14"] = 14,["15"] = 94,["16"] = 95,["17"] = 92,["18"] = 16,["19"] = 18,["20"] = 19,["21"] = 16,["22"] = 22,["23"] = 24,["24"] = 24,["25"] = 24,["26"] = 24,["27"] = 24,["28"] = 22,["29"] = 27,["30"] = 29,["31"] = 30,["32"] = 32,["33"] = 33,["34"] = 35,["35"] = 27,["36"] = 38,["37"] = 40,["38"] = 41,["39"] = 42,["40"] = 43,["41"] = 44,["42"] = 38,["43"] = 47,["44"] = 49,["45"] = 50,["46"] = 51,["47"] = 52,["48"] = 47,["49"] = 55,["50"] = 57,["52"] = 59,["56"] = 63,["72"] = 55,["73"] = 77,["75"] = 79,["77"] = 81,["78"] = 81,["79"] = 83,["80"] = 85,["81"] = 87,["83"] = 81,["87"] = 77,["88"] = 98,["89"] = 98,["90"] = 102,["91"] = 104,["92"] = 102});
local ____exports = {}
local Utils = require("utils.Utils")
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
    self.GameMode:SetSelectionGoldPenaltyEnabled(false)
    GameRules:SetHeroSelectPenaltyTime(65)
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
                self:RandomHeroesAfterTimeout()
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
function AddonGameMode.prototype.RandomHeroesAfterTimeout(self)
    return __TS__AsyncAwaiter(function(____awaiter_resolve)
        __TS__Await(Utils:Sleep(120))
        do
            local i = 0
            while i <= PlayerResource:GetNumConnectedHumanPlayers() do
                local Hero = PlayerResource:GetSelectedHeroEntity(i)
                if Hero == nil then
                    PlayerResource:GetPlayer(i):MakeRandomHeroSelection()
                end
                i = i + 1
            end
        end
    end)
end
function AddonGameMode.Precache(self, context)
end
function AddonGameMode.Activate(self)
    GameRules.Addon = __TS__New(____exports.AddonGameMode)
end
return ____exports

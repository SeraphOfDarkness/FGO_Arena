local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 1,["10"] = 11,["11"] = 11,["12"] = 11,["14"] = 14,["15"] = 110,["16"] = 111,["17"] = 108,["18"] = 16,["19"] = 18,["20"] = 19,["21"] = 16,["22"] = 22,["23"] = 24,["24"] = 24,["25"] = 24,["26"] = 24,["27"] = 24,["28"] = 22,["29"] = 27,["30"] = 29,["31"] = 30,["32"] = 32,["33"] = 33,["34"] = 27,["35"] = 36,["36"] = 38,["37"] = 39,["38"] = 40,["39"] = 41,["40"] = 42,["41"] = 36,["42"] = 45,["43"] = 47,["44"] = 48,["45"] = 49,["46"] = 50,["47"] = 45,["48"] = 53,["49"] = 55,["51"] = 57,["55"] = 61,["56"] = 63,["64"] = 69,["80"] = 53,["81"] = 85,["83"] = 87,["85"] = 89,["86"] = 89,["87"] = 91,["88"] = 92,["89"] = 94,["90"] = 96,["91"] = 96,["94"] = 89,["98"] = 85,["99"] = 101,["100"] = 103,["101"] = 104,["102"] = 105,["103"] = 101,["104"] = 114,["105"] = 114,["106"] = 118,["107"] = 120,["108"] = 118});
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
        local ____cond10 = ____switch10 == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP
        if ____cond10 then
            do
                if IsInToolsMode() then
                    self:DebugModeConfiguration()
                end
                break
            end
        end
        ____cond10 = ____cond10 or ____switch10 == DOTA_GAMERULES_STATE_HERO_SELECTION
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
                local Player = PlayerResource:GetPlayer(i)
                local Hero = PlayerResource:GetSelectedHeroEntity(i)
                if Hero == nil then
                    if Player ~= nil then
                        Player:MakeRandomHeroSelection()
                    end
                end
                i = i + 1
            end
        end
    end)
end
function AddonGameMode.prototype.DebugModeConfiguration(self)
    self:Setup_3v3v3v3()
    PlayerResource:SetCustomTeamAssignment(0, DOTA_TEAM_CUSTOM_1)
    GameRules:BotPopulate()
end
function AddonGameMode.Precache(self, context)
end
function AddonGameMode.Activate(self)
    GameRules.Addon = __TS__New(____exports.AddonGameMode)
end
return ____exports

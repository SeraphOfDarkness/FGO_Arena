local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local Utils = require("utils.UtilList")
____exports.AddonGameMode = __TS__Class()
local AddonGameMode = ____exports.AddonGameMode
AddonGameMode.name = "AddonGameMode"
function AddonGameMode.prototype.____constructor(self)
    self.PlayersPerTeam = 0
    self.GameMode = GameRules:GetGameModeEntity()
    self:RegisterEventListeners()
    self:DefaultConfiguration()
end
function AddonGameMode.prototype.DefaultConfiguration(self)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, self.PlayersPerTeam)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, self.PlayersPerTeam)
    GameRules:SetHeroSelectionTime(60)
    GameRules:SetHeroSelectPenaltyTime(35)
    self.GameMode:SetUseTurboCouriers(true)
    self.GameMode:SetPauseEnabled(false)
    self.GameMode:SetSelectionGoldPenaltyEnabled(false)
end
function AddonGameMode.prototype.Setup3v3v3v3(self)
    self.PlayersPerTeam = 3
    do
        local i = DOTA_TEAM_CUSTOM_1
        while i <= DOTA_TEAM_CUSTOM_4 do
            GameRules:SetCustomGameTeamMaxPlayers(i, self.PlayersPerTeam)
            i = i + 1
        end
    end
end
function AddonGameMode.prototype.Setup4v4v4(self)
    self.PlayersPerTeam = 4
    do
        local i = DOTA_TEAM_CUSTOM_1
        while i <= DOTA_TEAM_CUSTOM_3 do
            GameRules:SetCustomGameTeamMaxPlayers(i, self.PlayersPerTeam)
            i = i + 1
        end
    end
end
function AddonGameMode.prototype.SpawnMastersAndCouriers(self)
    do
        local i = 0
        while i <= PlayerResource:GetNumConnectedHumanPlayers() do
            local PlayerId = i
            local Player = PlayerResource:GetPlayer(PlayerId)
            if Utils:IsValidObject(Player) then
                local Team = PlayerResource:GetTeam(PlayerId)
                local OffsetIndex = PlayerResource:GetNumCouriersForTeam(Team)
                local TeamStr = "Team"
                repeat
                    local ____switch11 = Team
                    local ____cond11 = ____switch11 == DOTA_TEAM_CUSTOM_1
                    if ____cond11 then
                        do
                            TeamStr = TeamStr .. 1
                            break
                        end
                    end
                    ____cond11 = ____cond11 or ____switch11 == DOTA_TEAM_CUSTOM_2
                    if ____cond11 then
                        do
                            TeamStr = TeamStr .. 2
                            break
                        end
                    end
                    ____cond11 = ____cond11 or ____switch11 == DOTA_TEAM_CUSTOM_3
                    if ____cond11 then
                        do
                            TeamStr = TeamStr .. 3
                            break
                        end
                    end
                    ____cond11 = ____cond11 or ____switch11 == DOTA_TEAM_CUSTOM_4
                    if ____cond11 then
                        do
                            TeamStr = TeamStr .. 4
                            break
                        end
                    end
                    do
                        do
                            break
                        end
                    end
                until true
                self:SpawnMastersForPlayer(PlayerId, TeamStr, OffsetIndex)
                self:SpawnCourierForPlayer(PlayerId, TeamStr, OffsetIndex)
            end
            i = i + 1
        end
    end
end
function AddonGameMode.prototype.SpawnMastersForPlayer(self, PlayerId, TeamStr, OffsetIndex)
    do
        local i = 1
        while i <= 2 do
            local SpawnerStr = ((TeamStr .. "Master") .. tostring(i)) .. "Spawner"
            local Spawner = Entities:FindByName(nil, SpawnerStr)
            if Utils:IsValidObject(Spawner) then
                local SpawnerPos = Spawner and Spawner:GetAbsOrigin()
                local OffsetPos = Vector(250, 0, 0) * OffsetIndex
                local MasterPos = SpawnerPos and SpawnerPos:__add(OffsetPos)
                local PlayerController = PlayerResource:GetPlayer(PlayerId)
                local Master = CreateUnitByName(
                    "Master" .. tostring(i),
                    MasterPos,
                    false,
                    PlayerController,
                    PlayerController,
                    PlayerResource:GetTeam(PlayerId)
                )
                Master:SetControllableByPlayer(PlayerId, false)
                Master:SetHealth(1)
                Master:SetMana(1)
            end
            i = i + 1
        end
    end
end
function AddonGameMode.prototype.SpawnCourierForPlayer(self, PlayerId, TeamStr, OffsetIndex)
    local SpawnerStr = TeamStr .. "CourierSpawner"
    local Spawner = Entities:FindByName(nil, SpawnerStr)
    if Utils:IsValidObject(Spawner) then
        local SpawnerPos = Spawner and Spawner:GetAbsOrigin()
        local OffsetPos = Vector(250, 0, 0) * OffsetIndex
        local CourierPos = SpawnerPos and SpawnerPos:__add(OffsetPos)
        local PlayerController = PlayerResource:GetPlayer(PlayerId)
        local Courier = PlayerController and PlayerController:SpawnCourierAtPosition(CourierPos)
    end
end
function AddonGameMode.prototype.RandomHeroAfterTimeout(self)
    return __TS__AsyncAwaiter(function(____awaiter_resolve)
        __TS__Await(Utils:Sleep(90))
        do
            local i = 0
            while i <= PlayerResource:GetNumConnectedHumanPlayers() do
                local PlayerId = i
                local Hero = PlayerResource:GetSelectedHeroEntity(PlayerId)
                if not Utils:IsValidObject(Hero) then
                    local Player = PlayerResource:GetPlayer(PlayerId)
                    if Player ~= nil then
                        Player:MakeRandomHeroSelection()
                    end
                end
                i = i + 1
            end
        end
    end)
end
function AddonGameMode.prototype.OnGameStateChange(self)
    local CurrentState = GameRules:State_Get()
    repeat
        local ____switch26 = CurrentState
        local ____cond26 = ____switch26 == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP
        if ____cond26 then
            do
                if IsInToolsMode() then
                    self:DebugConfiguration()
                end
                break
            end
        end
        ____cond26 = ____cond26 or ____switch26 == DOTA_GAMERULES_STATE_HERO_SELECTION
        if ____cond26 then
            do
                self:RandomHeroAfterTimeout()
                break
            end
        end
        ____cond26 = ____cond26 or ____switch26 == DOTA_GAMERULES_STATE_WAIT_FOR_MAP_TO_LOAD
        if ____cond26 then
            do
                self:SpawnMastersAndCouriers()
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
function AddonGameMode.prototype.DebugConfiguration(self)
    self:Setup3v3v3v3()
    PlayerResource:SetCustomTeamAssignment(0, DOTA_TEAM_CUSTOM_1)
end
function AddonGameMode.prototype.RegisterEventListeners(self)
    ListenToGameEvent(
        "game_rules_state_change",
        function() return self:OnGameStateChange() end,
        nil
    )
end
function AddonGameMode.Precache(context)
end
function AddonGameMode.Activate()
    GameRules.Addon = __TS__New(____exports.AddonGameMode)
end
return ____exports

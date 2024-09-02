local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local ____exports = {}
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
function AddonGameMode.prototype.OnGameStateChange(self)
    local CurrentState = GameRules:State_Get()
    repeat
        local ____switch9 = CurrentState
        local ____cond9 = ____switch9 == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP
        if ____cond9 then
            do
                if IsInToolsMode() then
                    self:DebugConfiguration()
                end
                break
            end
        end
        ____cond9 = ____cond9 or ____switch9 == DOTA_GAMERULES_STATE_WAIT_FOR_MAP_TO_LOAD
        if ____cond9 then
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

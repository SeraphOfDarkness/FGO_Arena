//import * as Utils from "./utils/UtilList"

declare global 
{
    interface CDOTAGameRules 
    {
        Addon: AddonGameMode;
    }
}

export class AddonGameMode 
{
    PlayersPerTeam = 0;
    GameMode: CDOTABaseGameMode;

    DefaultConfiguration(): void
    {
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.GOODGUYS, this.PlayersPerTeam);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.BADGUYS, this.PlayersPerTeam);
    }

    Setup3v3v3v3(): void
    {
        this.PlayersPerTeam = 3;
        for (let i = DotaTeam.CUSTOM_1; i <= DotaTeam.CUSTOM_4; i++)
        {
            GameRules.SetCustomGameTeamMaxPlayers(i, this.PlayersPerTeam);
        }
    }

    Setup4v4v4(): void
    {
        this.PlayersPerTeam = 4;
        for (let i = DotaTeam.CUSTOM_1; i <= DotaTeam.CUSTOM_3; i++)
        {
            GameRules.SetCustomGameTeamMaxPlayers(i, this.PlayersPerTeam);
        }
    }

    OnGameStateChange(): void
    {
        const CurrentState = GameRules.State_Get();

        switch (CurrentState)
        {
            case GameState.CUSTOM_GAME_SETUP:
            {
                if (IsInToolsMode())
                {
                    this.DebugConfiguration();
                }
                break;
            }
            case GameState.WAIT_FOR_MAP_TO_LOAD:
            {
                break;
            }
            default: 
            {
                break;
            }
        }
    }

    DebugConfiguration(): void
    {
        this.Setup3v3v3v3();
        PlayerResource.SetCustomTeamAssignment(0, DotaTeam.CUSTOM_1);
    }

    RegisterEventListeners(): void
    {
        ListenToGameEvent("game_rules_state_change", () => this.OnGameStateChange(), undefined);
    }

    constructor()
    {
        this.GameMode = GameRules.GetGameModeEntity();
        this.RegisterEventListeners();
        this.DefaultConfiguration();
    }

    public static Precache(this: void, context: CScriptPrecacheContext) 
    {
    }

    public static Activate(this: void) 
    {
        GameRules.Addon = new AddonGameMode();
    }
}

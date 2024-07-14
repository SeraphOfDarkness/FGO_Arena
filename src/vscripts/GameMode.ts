import * as Utils from "./utils/Utils"

declare global 
{
    interface CDOTAGameRules 
    {
        Addon: AddonGameMode;
    }
}

export class AddonGameMode
{
    GameMode: CDOTABaseGameMode;

    Configure(): void
    {
        this.RegisterEventListeners();
        this.DefaultConfiguration();
    }

    RegisterEventListeners(): void
    {
        ListenToGameEvent('game_rules_state_change', ()=>this.OnGameStateChange(), undefined);
    }

    DefaultConfiguration(): void
    {
        GameRules.SetCustomGameSetupTimeout(60);
        
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.GOODGUYS, 0);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.BADGUYS, 0);

        this.Setup_3v3v3v3();
    }

    Setup_3v3v3v3(): void
    {
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_1, 3);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_2, 3);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_3, 3);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_4, 3);
    }

    Setup_4v4v4(): void
    {
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_1, 4);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_2, 4);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_3, 4);
    }

    OnGameStateChange(): void
    {
        const CurrentState = GameRules.State_Get();
        switch (CurrentState)
        {
            case GameState.WAIT_FOR_MAP_TO_LOAD:
            {
                for(let i = 0; i <= PlayerResource.GetNumConnectedHumanPlayers(); i++)
                {
                    const PlayerId = i as PlayerID;
                    const Hero = PlayerResource.GetSelectedHeroEntity(PlayerId);
                    print(Hero?.GetName());
                    print(PlayerResource.GetSteamAccountID(PlayerId));
                }
                break;
            }
            default:
            {
                break;
            }
        }
    }

    constructor()
    {
        this.GameMode = GameRules.GetGameModeEntity();
        this.Configure();
    }

    public static Precache(context: CScriptPrecacheContext): void
    {
    }

    public static Activate(): void
    {
        GameRules.Addon = new AddonGameMode();
    }
}
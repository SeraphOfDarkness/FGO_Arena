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
    PlayersPerTeam: number = 0;

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
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.GOODGUYS, this.PlayersPerTeam);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.BADGUYS, this.PlayersPerTeam);

        this.GameMode.SetSelectionGoldPenaltyEnabled(false);
        GameRules.SetHeroSelectPenaltyTime(65);

        this.Setup_3v3v3v3();
    }

    Setup_3v3v3v3(): void
    {
        this.PlayersPerTeam = 3;
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_1, this.PlayersPerTeam);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_2, this.PlayersPerTeam);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_3, this.PlayersPerTeam);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_4, this.PlayersPerTeam);
    }

    Setup_4v4v4(): void
    {
        this.PlayersPerTeam = 4;
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_1, this.PlayersPerTeam);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_2, this.PlayersPerTeam);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_3, this.PlayersPerTeam);
    }

    OnGameStateChange(): void
    {
        const CurrentState = GameRules.State_Get();

        switch (CurrentState)
        {
            case GameState.HERO_SELECTION:
            {
                this.RandomHeroesAfterTimeout();
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

    async RandomHeroesAfterTimeout(): Promise<void>
    {
        await Utils.Sleep(120);

        for (let i = 0; i <= PlayerResource.GetNumConnectedHumanPlayers(); i++)
        {
            const Hero = PlayerResource.GetSelectedHeroEntity(i as PlayerID);

            if (Hero === undefined)
            {
                PlayerResource.GetPlayer(i as PlayerID)!.MakeRandomHeroSelection();
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
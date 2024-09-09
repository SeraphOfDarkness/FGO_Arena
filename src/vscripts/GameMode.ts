import * as Utils from "./utils/UtilList"

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

        GameRules.SetHeroSelectionTime(60);
        GameRules.SetHeroSelectPenaltyTime(35);

        this.GameMode.SetUseTurboCouriers(true);
        this.GameMode.SetPauseEnabled(false);
        this.GameMode.SetSelectionGoldPenaltyEnabled(false);
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

    SpawnMastersAndCouriers(): void
    {
        for (let i = 0; i <= PlayerResource.GetNumConnectedHumanPlayers(); i++)
        {
            const PlayerId = i as PlayerID;
            const Player = PlayerResource.GetPlayer(PlayerId);

            if (Utils.IsValidObject(Player))
            {
                const Team = PlayerResource.GetTeam(PlayerId);
                const OffsetIndex = PlayerResource.GetNumCouriersForTeam(Team);

                let TeamStr = "Team";

                switch (Team)
                {
                    case DotaTeam.CUSTOM_1:
                    {
                        TeamStr = TeamStr + 1;
                        break;
                    }
                    case DotaTeam.CUSTOM_2:
                    {
                        TeamStr = TeamStr + 2;
                        break;
                    }
                    case DotaTeam.CUSTOM_3:
                    {
                        TeamStr = TeamStr + 3;
                        break;
                    }
                    case DotaTeam.CUSTOM_4:
                    {
                        TeamStr = TeamStr + 4;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }

                this.SpawnMastersForPlayer(PlayerId, TeamStr, OffsetIndex);
                this.SpawnCourierForPlayer(PlayerId, TeamStr, OffsetIndex);
            }
        }
    }

    SpawnMastersForPlayer(PlayerId: PlayerID, TeamStr: string, OffsetIndex: number): void
    {
        for (let i = 1; i <= 2; i++)
        {
            const SpawnerStr = TeamStr + "Master" + i + "Spawner";
            const Spawner = Entities.FindByName(undefined, SpawnerStr);
            
            if (Utils.IsValidObject(Spawner))
            {
                const SpawnerPos = Spawner?.GetAbsOrigin() as Vector;
                const OffsetPos = (Vector(250, 0, 0) * OffsetIndex) as Vector;
                const MasterPos = SpawnerPos?.__add(OffsetPos);
                const PlayerController = PlayerResource.GetPlayer(PlayerId);
                const Master = CreateUnitByName("Master" + i, MasterPos, false, PlayerController, PlayerController, PlayerResource.GetTeam(PlayerId));
                Master.SetControllableByPlayer(PlayerId, false);
                Master.SetHealth(1);
                Master.SetMana(1);
            }
        }
    }

    SpawnCourierForPlayer(PlayerId: PlayerID, TeamStr: string, OffsetIndex: number): void
    {
        const SpawnerStr = TeamStr + "CourierSpawner";
        const Spawner = Entities.FindByName(undefined, SpawnerStr);

        if (Utils.IsValidObject(Spawner))
        {
            const SpawnerPos = Spawner?.GetAbsOrigin() as Vector;
            const OffsetPos = (Vector(250, 0, 0) * OffsetIndex) as Vector;
            const CourierPos = SpawnerPos?.__add(OffsetPos);
            const PlayerController = PlayerResource.GetPlayer(PlayerId);
            const Courier = PlayerController?.SpawnCourierAtPosition(CourierPos);
        }
    }

    async RandomHeroAfterTimeout(): Promise<void>
    {
        await Utils.Sleep(90);
        for(let i = 0; i <= PlayerResource.GetNumConnectedHumanPlayers(); i++)
        {
            const PlayerId = i as PlayerID;
            const Hero = PlayerResource.GetSelectedHeroEntity(PlayerId);

            if (!Utils.IsValidObject(Hero))
            {
                const Player = PlayerResource.GetPlayer(PlayerId);
                Player?.MakeRandomHeroSelection();
            }
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
            case GameState.HERO_SELECTION:
            {
                this.RandomHeroAfterTimeout();
                break;
            }
            case GameState.WAIT_FOR_MAP_TO_LOAD:
            {
                this.SpawnMastersAndCouriers();
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

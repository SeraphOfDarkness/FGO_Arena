import "./libs/timers"
import { AddonGameMode } from "./GameMode";

// Connect GameMode.Activate and GameMode.Precache to the dota engine
Object.assign(getfenv(), 
{
    Activate: AddonGameMode.Activate,
    Precache: AddonGameMode.Precache,
});
import "./libs/timers";
import { AddonGameMode } from "./GameMode";

Object.assign(getfenv(), 
{
    Activate: AddonGameMode.Activate,
    Precache: AddonGameMode.Precache,
});
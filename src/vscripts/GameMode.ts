declare global 
{
    interface CDOTAGameRules 
    {
        Addon: AddonGameMode;
    }
}

export class AddonGameMode 
{
    public static Precache(this: void, context: CScriptPrecacheContext) 
    {
    }

    public static Activate(this: void) 
    {
        GameRules.Addon = new AddonGameMode();
    }
}

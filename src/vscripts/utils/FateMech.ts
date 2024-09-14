export function ChangeSkin(Unit: CDOTA_BaseNPC, ModelName: string, ModelScale: number = 1)
{
    Unit.SetOriginalModel(ModelName);
    Unit.SetModel(ModelName);
    Unit.SetModelScale(ModelScale);
}
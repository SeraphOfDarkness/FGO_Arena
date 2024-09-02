export function RunOnServerOnly(): void
{
    if (!IsServer())
    {
        return;
    }
}
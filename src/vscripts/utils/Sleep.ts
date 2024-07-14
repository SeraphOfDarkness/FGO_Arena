export function Sleep(duration: number) : Promise<unknown>
{
    return new Promise((resolve, reject) => 
    {
        Timers.CreateTimer(duration, () => resolve(""));
    });
}

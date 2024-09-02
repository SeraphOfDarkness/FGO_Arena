export function IsValidObject(Object: unknown): boolean
{
    let Result = false;

    if (Object !== undefined)
    {
        Result = true;
    }

    return Result;
}

export function Sleep(Duration: number): Promise<unknown>
{
    const Result = new Promise((resolve, reject) => 
        { 
            Timers.CreateTimer(Duration, () => resolve(""));
        });
    return Result;
}
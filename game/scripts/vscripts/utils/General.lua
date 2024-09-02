local ____lualib = require("lualib_bundle")
local __TS__Promise = ____lualib.__TS__Promise
local __TS__New = ____lualib.__TS__New
local ____exports = {}
function ____exports.IsValidObject(self, Object)
    local Result = false
    if Object ~= nil then
        Result = true
    end
    return Result
end
function ____exports.Sleep(self, Duration)
    local Result = __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            Timers:CreateTimer(
                Duration,
                function() return resolve(nil, "") end
            )
        end
    )
    return Result
end
return ____exports

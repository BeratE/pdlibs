import "CoreLibs/object"

mylib = mylib or {}

-- Dump table contents in json-like format
function mylib.dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"'..k..'"'
            end
            s = s .. k .. ': ' .. mylib.dump(v) .. ', '
        end
        return s .. '} '
    else
       return tostring(o)
    end
end

-- Measure the execution time of a given function
function mylib.profile(fun, args, name)
    playdate.resetElapsedTime()
    local ret = fun(args)
    local elapsed = playdate.getElapsedTime() * 1000
    print("DEBUG - Profile(".. (name or "") .. ") - took " .. elapsed .. "ms")
    return ret
end


pdlibs = pdlibs or {}
pdlibs.math = pdlibs.math or {}

function pdlibs.math.round(num, decimals)
    decimals = 10^(decimals or 0)
    num = num * decimals
    if num >= 0 then num = math.floor(num + 0.5) else num = math.ceil(num - 0.5) end
    return num / decimals
end

function pdlibs.math.clamp(num, min, max)
    return math.min(max, (math.max(min, num)))
end
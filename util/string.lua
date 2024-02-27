-- Utility functions for strings

pdlibs = pdlibs or {}
pdlibs.string = pdlibs.string or {}

local alphanumerical = {}  do -- [0-9a-zA-Z]
    for c = 48, 57  do table.insert(alphanumerical, string.char(c)) end --[0-9]
    for c = 65, 90  do table.insert(alphanumerical, string.char(c)) end --[a-z]
    for c = 97, 122 do table.insert(alphanumerical, string.char(c)) end --[A-Z]
end

-- Generate random string with given length, use given optional charset.
function pdlibs.string.random(length, charset)
    if (not length or length <= 0) then return "" end
    charset = charset or alphanumerical
    local c = charset[math.random(#charset-1)]
    return c .. pdlibs.string.random(length-1)
end

function pdlibs.string.toArray(string)
    array = {}
    for i = 1, #string do
        array[i] = string:sub(i,i)
    end
    return array
end
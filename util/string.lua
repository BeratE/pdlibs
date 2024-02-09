-- Utility functions for strings

mylib = mylib or {}
mylib.string = mylib.string or {}

local alphanumerical = {}  do -- [0-9a-zA-Z]
    for c = 48, 57  do table.insert(alphanumerical, string.char(c)) end --[0-9]
    for c = 65, 90  do table.insert(alphanumerical, string.char(c)) end --[a-z]
    for c = 97, 122 do table.insert(alphanumerical, string.char(c)) end --[A-Z]
end

-- Generate random string with given length, use given optional charset.
function mylib.string.random(length, charset)
    if (not length or length <= 0) then return "" end
    charset = charset or alphanumerical
    local c = charset[math.random(#charset-1)]
    return c .. mylib.string.random(length-1)
end
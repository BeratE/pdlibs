-- Utility functions for strings

mylib = mylib or {}
mylib.string = mylib.string or {}

local charset <const> = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

function mylib.string.random(length)
    if (length > 0) then
        local c = charset:sub(math.random(#charset), 1)
        return mylib.string.random(length-1) .. c
    end
    return ""
end
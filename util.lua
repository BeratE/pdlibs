import "CoreLibs/object"

mylib = mylib or {}

-- Dump table contents in json-like format
function mylib.dump(o)
    if type(o) == 'table' then
        -- Check if Object
        if (type(o.isa) == "function") then
            return ".."
        end
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
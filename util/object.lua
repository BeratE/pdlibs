import "CoreLibs/object"

-- Mixin support, allows the use of Mixins/Interfaces
function Object:implements(...)
    for _, cls in pairs({...}) do
        for k, v in pairs(cls) do
            if self[k] == nil and type(v) == "function" then
                self[k] = v
            end
        end
    end
end

--[[ USAGE
    class('PairPrinter').extends(Object)

    function PairPrinter:printPairs()
    	for k, v in pairs(self) do
    		if k ~= 'super' then -- this is a bit of a hack
    			print(k, v)
    		end
    	end
    end


    class('Point').extends(Object)
    Point:implements(PairPrinter)

    function Point:new(x, y)
    	self.x = x or 0
    	self.y = y or 0
    end


    local p = Point()
    p:printPairs()
]]
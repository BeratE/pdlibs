import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

--[[ Execute child behavior given percentage [0, 100] of time. 
 Accepts function returning percentage as argument. ]]
class('Chance', {}, mylib.behavior).extends(mylib.behavior.Decorator)

function mylib.behavior.Chance:init(percentage, child, failstatus)
    mylib.behavior.Chance.super.init(self, child)
    self.failstatus = failstatus or mylib.behavior.Status.FAILURE
    self:setPercentage(percentage)
end

function mylib.behavior.Chance:onUpdate()
    if (math.random(1, 100) >= self.getPercentage()) then
        return failstatus
    end
    return self.child:update()
end

function mylib.behavior.Chance:setPercentage(percentage)
    if (type(percentage) == "function") then
        self.getPercentage = percentage
    elseif(type(percentage) == "number") then
        assert(percentage <= 100 and percentage >= 0, "Invalid percentage number passed to Chance behavior")
        self.getPercentage = function ()
            return percentage
        end
    end
end
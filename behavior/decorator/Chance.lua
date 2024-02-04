import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

-- Execute child behavior given percentage of time
class('Chance', {}, mylib.behavior).extends(mylib.behavior.Decorator)

function mylib.behavior.Chance:init(percentage, child)
    mylib.behavior.Chance.super.init(self, child)
    self:setPercentage(percentage)
end

function mylib.behavior.Chance:onUpdate()
    if (math.random(1, 100) > self.percentage) then
        return mylib.behavior.Status.SUCCESS
    end
    return self.child:update()
end

function mylib.behavior.Chance:setPercentage(percentage)
    assert(type(percentage) == "number" and 
            percentage <= 100 and percentage >= 0,
            "Invalid percentage passed to Chance behavior")
    self.percentage = percentage
end
import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

-- Execute child behavior given percentage of time
class('Chance', {}, mylib.behavior).extends(mylib.behavior.Decorator)

function mylib.behavior.Chance:init(percentage, child)
    mylib.behavior.Chance.super.init(self, child)
    self.percentage = percentage
end

function mylib.behavior.Chance:onUpdate()
    if (math.random(1, 100) > self.percentage) then
        return mylib.behavior.Status.SUCCESS
    end
    return self.child:update()
end
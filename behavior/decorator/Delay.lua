import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

local currTimeMS <const> = playdate.getCurrentTimeMilliseconds

-- Basic Succeeder. Always do action and return success.
class('Delay', {}, mylib.behavior).extends(mylib.behavior.Decorator)

function mylib.behavior.Delay:init(delayMs, child)
    mylib.behavior.Delay.super.init(self, child)
    self.delay = delayMs
end

function mylib.behavior.Delay:onActivate()
    mylib.behavior.Delay.super.onActivate(self)
    self.enterTime = currTimeMS()
end

function mylib.behavior.Delay:onUpdate()
    if (currTimeMS() < (self.enterTime + self.delay)) then
        return mylib.behavior.Status.RUNNING
    end
    return self.child:update()
end
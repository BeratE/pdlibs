import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

local currTimeMS <const> = playdate.getCurrentTimeMilliseconds

-- Basic Succeeder. Always do action and return success.
class('Delay', {}, pdlibs.behavior).extends(pdlibs.behavior.Decorator)

function pdlibs.behavior.Delay:init(delayMs, child)
    pdlibs.behavior.Delay.super.init(self, child)
    self.delay = delayMs
end

function pdlibs.behavior.Delay:onActivate()
    pdlibs.behavior.Delay.super.onActivate(self)
    self.enterTime = currTimeMS()
end

function pdlibs.behavior.Delay:onUpdate()
    if (currTimeMS() < (self.enterTime + self.delay)) then
        return pdlibs.behavior.Status.RUNNING
    end
    return self.child:update()
end
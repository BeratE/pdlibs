import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

-- Always do action and return success.
class('Do', {}, mylib.behavior).extends(mylib.behavior.Decorator)

function mylib.behavior.Do:init(child)
    mylib.behavior.Do.super.init(self, child)
end

function mylib.behavior.Do:onUpdate()
    self.child:update()
    if (self.child:getStatus() == mylib.behavior.Status.RUNNING) then
        return mylib.behavior.Status.RUNNING
    end
    return mylib.behavior.Status.SUCCESS
end
import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

-- Basic Succeeder. Always do action and return success.
class('Do', {}, mylib.behavior).extends(mylib.behavior.Decorator)

function mylib.behavior.Do:init(child)
    mylib.behavior.Do.super.init(self, child)
end

function mylib.behavior.Do:onUpdate()
    local status = self.child:update()
    if (status == mylib.behavior.Status.RUNNING) then
        return status
    end
    return mylib.behavior.Status.SUCCESS
end
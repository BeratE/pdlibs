import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"
import "pdlibs/behavior/leaf/Action"

-- Basic Succeeder. Always do action and return success.
class('Fail', {}, mylib.behavior).extends(mylib.behavior.Decorator)

function mylib.behavior.Fail:init(child)
    mylib.behavior.Fail.super.init(self, child)
end

function mylib.behavior.Fail:onUpdate()
    local status = self.child:update()
    if (status == mylib.behavior.Status.RUNNING) then
        return status
    end
    return mylib.behavior.Status.FAILURE
end
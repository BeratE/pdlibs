import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"
import "pdlibs/behavior/leaf/Action"

-- Basic Succeeder. Always do action and return success.
class('Fail', {}, pdlibs.behavior).extends(pdlibs.behavior.Decorator)

function pdlibs.behavior.Fail:init(child)
    pdlibs.behavior.Fail.super.init(self, child)
end

function pdlibs.behavior.Fail:onUpdate()
    local status = self.child:update()
    if (status == pdlibs.behavior.Status.RUNNING) then
        return status
    end
    return pdlibs.behavior.Status.FAILURE
end
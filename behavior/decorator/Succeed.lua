import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"
import "pdlibs/behavior/leaf/Action"

-- Basic Succeeder. Always do action and return success.
class('Succeed', {}, pdlibs.behavior).extends(pdlibs.behavior.Decorator)

function pdlibs.behavior.Succeed:init(child)
    if (type(child) == "nil") then
        child = pdlibs.behavior.Action()
    end
    pdlibs.behavior.Succeed.super.init(self, child)
end

function pdlibs.behavior.Succeed:onUpdate()
    local status = self.child:update()
    if (status == pdlibs.behavior.Status.RUNNING) then
        return status
    end
    return pdlibs.behavior.Status.SUCCESS
end
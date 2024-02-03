import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

-- Always do action and return success.
class('Invert', {}, mylib.behavior).extends(mylib.behavior.Decorator)

function mylib.behavior.Invert:init(child)
    mylib.behavior.Invert.super.init(self, child)
end

function mylib.behavior.Invert:onUpdate()
    local status = self.child:update()
    if (status == mylib.behavior.Status.SUCCESS) then
        return mylib.behavior.Status.FAILURE
    elseif (status == mylib.behavior.Status.FAILURE) then
        return mylib.behavior.Status.SUCCESS
    end
    return status
end
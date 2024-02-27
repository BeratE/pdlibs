import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

-- Repeat a given behavior until limit is reached or child returns failure.
class('Repeat', {}, pdlibs.behavior).extends(pdlibs.behavior.Decorator)

function pdlibs.behavior.Repeat:init(limit, child)
    pdlibs.behavior.Repeat.super.init(self, child)
    self:setLimit(limit)
end

function pdlibs.behavior.Repeat:onUpdate()
    while self.nTicks < self.limit do
        local status = self.child:update()
        print(self.nTicks)
        if (status == pdlibs.behavior.Status.RUNNING or
            status == pdlibs.behavior.Status.FAILURE) then
            return status
        end
    end
    return pdlibs.behavior.Status.SUCCESS
end

function pdlibs.behavior.Repeat:setLimit(limit)
    assert(type(limit) == "number", "Illegal limit argument passed to Repeat behavior")
    self.limit = limit
end
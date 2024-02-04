import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

-- Repeat a given behavior until limit is reached or child returns failure.
class('Repeat', {}, mylib.behavior).extends(mylib.behavior.Decorator)

function mylib.behavior.Repeat:init(limit, child)
    mylib.behavior.Repeat.super.init(self, child)
    self:setLimit(limit)
end

function mylib.behavior.Repeat:onUpdate()
    while self.nTicks < self.limit do
        local status = self.child:update()
        print(self.nTicks)
        if (status == mylib.behavior.Status.RUNNING or
            status == mylib.behavior.Status.FAILURE) then
            return status
        end
    end
    return mylib.behavior.Status.SUCCESS
end

function mylib.behavior.Repeat:setLimit(limit)
    assert(type(limit) == "number", "Illegal limit argument passed to Repeat behavior")
    self.limit = limit
end
import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

-- Repeat a given behavior until limit is reached or child returns failure
class('Repeat', {}, mylib.behavior).extends(mylib.behavior.Decorator)

function mylib.behavior.Repeat:init(child, limit)
    mylib.behavior.Repeat.super.init(self, child)
    self.limit = limit
end

function mylib.behavior.Repeat:onUpdate()
    while true do
        local status = child:update()
        if (status == mylib.behavior.Status.RUNNING) then
            break;
        elseif (status == mylib.behavior.Status.FAILURE) then
            return mylib.behavior.Status.FAILURE
        elseif (self.limit and self.nTicks >= self.limit) then
            return mylib.behavior.Status.SUCCESS
        end
    end
    return mylib.behavior.Status.RUNNING
end
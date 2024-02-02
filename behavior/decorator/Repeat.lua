import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

-- Repeat a given behavior until limit is reached or child returns failure
class('Repeat', {}, mylib.behaviour).extends(mylib.behaviour.Decorator)

function mylib.behaviour.Repeat:init(child, limit)
    mylib.behaviour.Repeat.super.init(self, child)
    self.limit = limit
end

function mylib.behaviour.Repeat:onUpdate()
    while true do
        local status = child:update()
        if (status == BH_STATUS.RUNNING) then
            break;
        elseif (status == BH_STATUS.FAILURE) then
            return BH_STATUS.FAILURE
        elseif (self.limit and self.nTicks >= self.limit) then
            return BH_STATUS.SUCCESS
        end
    end
    return BH_STATUS.RUNNING
end
import "CoreLibs/object"

import "libs/behavior/decorator/BehaviorDecorator"

-- Repeat a given behavior until limit is reached or child returns failure
class('RepeatBehavior').extends(BehaviorDecorator)

function RepeatBehavior:init(child, limit)
    RepeatBehavior.super.init(self, child)
    self.limit = limit
end

function RepeatBehavior:onUpdate()
    while true do
        local status = child:update()
        if (status == BH_STATUS.RUNNING) then
            break;
        end
        if (status == BH_STATUS.FAILURE) then
            return BH_STATUS.FAILURE
        end
        if (self.limit and self.nTicks >= self.limit) then
            return BH_STATUS.SUCCESS
        end
    end
    return BH_STATUS.RUNNING
end
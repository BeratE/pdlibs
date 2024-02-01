import "CoreLibs/object"

import "libs/behavior/composite/SequenceBehavior"

-- A filter takes a condition and a behavior. 
-- The behavior is only executed if the condition fails
class('FilterBehavior').extends(SequenceBehavior)

function FilterBehavior:init(condition, behavior)
    FilterBehavior.super.init(self, {condition, behavior})
end

function FilterBehavior:reset()
    FilterBehavior.super.reset(self)
    self.currChildIdx = 1
end

function FilterBehavior:onUpdate()
    while true do
        local status = self.children[self.currChildIdx]:update()
        -- If child fails or keeps running do same
        if (status ~= BH_STATUS.SUCCESS) then
            return status
        end
        self.currChildIdx += 1
        if (self.currChildIdx > self.nChildren) then
            return BH_SUCESS
        end
    end
end
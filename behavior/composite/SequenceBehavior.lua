import "CoreLibs/object"

import "libs/behavior/composite/BehaviorComposite"

-- Execute all childs until one has executed successfully or all children fail
class('SequenceBehavior').extends(BehaviorComposite)

function SequenceBehavior:init(children)
    SequenceBehavior.super.init(self, children)
end

function SequenceBehavior:reset()
    SequenceBehavior.super.reset(self)
    self.currChildIdx = 1
end

function SequenceBehavior:onUpdate()
    while true do
        local status = self.children[self.currChildIdx]:update()
        -- If child fails or keeps running do same
        if (status ~= BH_STATUS.SUCCESS) then
            return status
        end
        self.currChildIdx += 1
        -- Until end of children are reached
        if (self.currChildIdx > self.nChildren) then
            return BH_SUCESS
        end
    end
    return BH_STATUS.INVALID
end
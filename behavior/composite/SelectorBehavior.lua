import "CoreLibs/object"

import "libs/behavior/composite/BehaviorComposite"

-- (OR) Execute all children until one has executed successfully or all children fail
class('SelectorBehavior').extends(BehaviorComposite)

function SelectorBehavior:init(children)
    SelectorBehavior.super.init(self, children)
end

function SelectorBehavior:onActivate()
    SelectorBehavior.super.onActivate(self)
    self.currChildIdx = 1
end

function SelectorBehavior:onUpdate()
    while true do
        local status = self.children[self.currChildIdx]:update()
        -- If child succeeds do same
        if (status ~= BH_STATUS.FAILURE) then
            return status
        end
        self.currChildIdx += 1
        -- Until end of children are reached
        if (self.currChildIdx > self.nChildren) then
            return BH_STATUS.FAILURE
        end
    end
    return BH_STATUS.INVALID
end
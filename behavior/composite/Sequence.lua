import "CoreLibs/object"

import "pdlibs/behavior/composite/Composite"

-- (AND) Execute all childs until one has failed or all children succeeded
class('Sequence', {}, mylib.behaviour).extends(mylib.behaviour.Composite)

function mylib.behaviour.Sequence:init(children)
    mylib.behaviour.Sequence.super.init(self, children)
end

function mylib.behaviour.Sequence:onActivate()
    mylib.behaviour.Sequence.super.onActivate(self)
    self.currChildIdx = 1
end

function mylib.behaviour.Sequence:onUpdate()
    while true do
        local status = self.children[self.currChildIdx]:update()
        -- If child fails or keeps running do same
        if (status ~= BH_STATUS.SUCCESS) then
            return status
        end
        self.currChildIdx += 1
        -- Until end of children are reached
        if (self.currChildIdx > self.nChildren) then
            return BH_STATUS.SUCCESS
        end
    end
    return BH_STATUS.INVALID
end
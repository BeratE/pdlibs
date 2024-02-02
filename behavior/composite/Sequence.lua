import "CoreLibs/object"

import "pdlibs/behavior/composite/Composite"

-- (AND) Execute all childs until one has failed or all children succeeded.
class('Sequence', {}, mylib.behavior).extends(mylib.behavior.Composite)

function mylib.behavior.Sequence:init(children)
    mylib.behavior.Sequence.super.init(self, children)
end

function mylib.behavior.Sequence:onActivate()
    mylib.behavior.Sequence.super.onActivate(self)
    self.currChildIdx = 1
end

function mylib.behavior.Sequence:onUpdate()
    while true do
        local status = self.children[self.currChildIdx]:update()
        -- If child fails or keeps running do same
        if (status ~= mylib.behavior.Status.SUCCESS) then
            return status
        end
        self.currChildIdx += 1
        -- Until end of children are reached
        if (self.currChildIdx > self.nChildren) then
            return mylib.behavior.Status.SUCCESS
        end
    end
end
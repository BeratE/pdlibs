import "CoreLibs/object"

import "pdlibs/behavior/composite/Composite"

-- (AND) Execute all childs until one has failed or all children succeeded.
class('Sequence', {}, pdlibs.behavior).extends(pdlibs.behavior.Composite)

function pdlibs.behavior.Sequence:init(children)
    pdlibs.behavior.Sequence.super.init(self, children)
end

function pdlibs.behavior.Sequence:onActivate()
    pdlibs.behavior.Sequence.super.onActivate(self)
    self.currChildIdx = 1
end

function pdlibs.behavior.Sequence:onUpdate()
    while true do
        local status = self:getCurrentChild():update()
        -- If child fails or keeps running do same
        if (status ~= pdlibs.behavior.Status.SUCCESS) then
            return status
        end
        self.currChildIdx += 1
        -- Until end of children are reached
        if (self.currChildIdx > #self.children) then
            return pdlibs.behavior.Status.SUCCESS
        end
    end
end

function pdlibs.behavior.Sequence:getCurrentChild()
    return self.children[self.currChildIdx]
end
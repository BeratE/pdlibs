import "CoreLibs/object"

import "pdlibs/behavior/composite/Composite"

-- (OR) Execute all children until one has executed successfully or all children fail.
class('Selector', {}, pdlibs.behavior).extends(pdlibs.behavior.Composite)

function pdlibs.behavior.Selector:init(children)
    pdlibs.behavior.Selector.super.init(self, children)
end

function pdlibs.behavior.Selector:onActivate()
    pdlibs.behavior.Selector.super.onActivate(self)
    self.currChildIdx = 1
end

function pdlibs.behavior.Selector:onUpdate()
    while (self.currChildIdx <= #self.children) do
        local status = self.children[self.currChildIdx]:update()
        if (status ~= pdlibs.behavior.Status.FAILURE) then
            return status -- If child succeeds do same
        end
        self.currChildIdx = self:_getNextChildIdx()
    end
    return pdlibs.behavior.Status.FAILURE
end


function pdlibs.behavior.Selector:_getNextChildIdx()
    return self.currChildIdx + 1
end
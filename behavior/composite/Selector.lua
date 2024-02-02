import "CoreLibs/object"

import "pdlibs/behavior/composite/Composite"

-- (OR) Execute all children until one has executed successfully or all children fail
class('Selector', {}, mylib.behavior).extends(mylib.behavior.Composite)

function mylib.behavior.Selector:init(children)
    mylib.behavior.Selector.super.init(self, children)
end

function mylib.behavior.Selector:onActivate()
    mylib.behavior.Selector.super.onActivate(self)
    self.currChildIdx = 1
end

function mylib.behavior.Selector:onUpdate()
    while true do
        local status = self.children[self.currChildIdx]:update()
        -- If child succeeds do same
        if (status ~= mylib.behavior.Status.FAILURE) then
            return status
        end
        self.currChildIdx += 1
        -- Until end of children are reached
        if (self.currChildIdx > self.nChildren) then
            return mylib.behavior.Status.FAILURE
        end
    end
    return mylib.behavior.Status.INVALID
end
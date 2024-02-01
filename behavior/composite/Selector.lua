import "CoreLibs/object"

import "libs/behavior/composite/Composite"

-- (OR) Execute all children until one has executed successfully or all children fail
class('Selector', {}, mylib.behaviour).extends(mylib.behaviour.Composite)

function mylib.behaviour.Selector:init(children)
    mylib.behaviour.Selector.super.init(self, children)
end

function mylib.behaviour.Selector:onActivate()
    mylib.behaviour.Selector.super.onActivate(self)
    self.currChildIdx = 1
end

function mylib.behaviour.Selector:onUpdate()
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
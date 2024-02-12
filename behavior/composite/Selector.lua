import "CoreLibs/object"

import "pdlibs/behavior/composite/Composite"

-- (OR) Execute all children until one has executed successfully or all children fail.
class('Selector', {}, mylib.behavior).extends(mylib.behavior.Composite)

function mylib.behavior.Selector:init(children)
    mylib.behavior.Selector.super.init(self, children)
end

function mylib.behavior.Selector:onActivate()
    mylib.behavior.Selector.super.onActivate(self)
    self.currChildIdx = 1
end

function mylib.behavior.Selector:onUpdate()
    while (self.currChildIdx <= #self.children) do
        local status = self.children[self.currChildIdx]:update()
        -- If child succeeds do same
        if (status ~= mylib.behavior.Status.FAILURE) then
            return status
        end
        self.currChildIdx = self:_getNextChildIdx()
    end
    return mylib.behavior.Status.FAILURE
end


function mylib.behavior.Selector:_getNextChildIdx()
    return self.currChildIdx +  1
end
import "CoreLibs/object"

import "pdlibs/behavior/composite/Composite"

--[[ Selects a child and executes the behavior at random,
 Proceed to another random child if execution was successfull.]]
class('Random', {}, mylib.behavior).extends(mylib.behavior.Composite)

function mylib.behavior.Random:init(children)
    mylib.behavior.Random.super.init(self, children)
    self.currChildIdx = 1
end

function mylib.behavior.Random:onActivate()
    mylib.behavior.Random.super.onActivate(self)
    self:selectNewChild()
end

function mylib.behavior.Random:onUpdate()
    local status = self:getCurrentChild():update()
    if (status ~= mylib.behavior.Status.RUNNING) then
        self:selectNewChild()
    end
    return status
end

function mylib.behavior.Random:selectNewChild()
    self.currChildIdx = math.random(1, self.nChildren)
    --print("Random behavior select child ".. self.currChildIdx)
end

function mylib.behavior.Random:getCurrentChild()
    return self.children[self.currChildIdx]
end
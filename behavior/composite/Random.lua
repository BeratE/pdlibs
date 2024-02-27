import "CoreLibs/object"

import "pdlibs/behavior/composite/Composite"

--[[ Selects a child and executes the behavior at random,
 Proceed to another random child if execution was successfull. --]]
class('Random', {}, pdlibs.behavior).extends(pdlibs.behavior.Composite)

function pdlibs.behavior.Random:init(children)
    pdlibs.behavior.Random.super.init(self, children)
    self.currChildIdx = 1
end

function pdlibs.behavior.Random:onActivate()
    pdlibs.behavior.Random.super.onActivate(self)
    self:selectNewChild()
end

function pdlibs.behavior.Random:onUpdate()
    local status = self:getCurrentChild():update()
    if (status ~= pdlibs.behavior.Status.RUNNING) then
        self:selectNewChild()
    end
    return status
end

function pdlibs.behavior.Random:selectNewChild()
    self.currChildIdx = math.random(1, #self.children)
    --print("Random behavior select child ".. self.currChildIdx)
end

function pdlibs.behavior.Random:getCurrentChild()
    return self.children[self.currChildIdx]
end
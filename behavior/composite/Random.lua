import "CoreLibs/object"

import "pdlibs/behavior/composite/Composite"

-- Selects a child and executes the behavior at random
class('Random', {}, mylib.behaviour).extends(mylib.behaviour.Composite)

function mylib.behaviour.Random:init(children)
    mylib.behaviour.Random.super.init(self, children)
end

function mylib.behaviour.Random:onActivate()
    mylib.behaviour.Random.super.onActivate(self)
    self.currChildIdx = math.random(1, self.nChildren)
end

function mylib.behaviour.Random:onUpdate()
    return self.children[self.currChildIdx]:update()
end
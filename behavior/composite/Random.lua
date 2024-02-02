import "CoreLibs/object"

import "pdlibs/behavior/composite/Composite"

-- Selects a child and executes the behavior at random
class('Random', {}, mylib.behavior).extends(mylib.behavior.Composite)

function mylib.behavior.Random:init(children)
    mylib.behavior.Random.super.init(self, children)
end

function mylib.behavior.Random:onActivate()
    mylib.behavior.Random.super.onActivate(self)
    self.currChildIdx = math.random(1, self.nChildren)
end

function mylib.behavior.Random:onUpdate()
    return self.children[self.currChildIdx]:update()
end
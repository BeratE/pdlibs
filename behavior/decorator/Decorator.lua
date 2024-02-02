import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

-- Decorate for a single child node, process the node on execution
class('Decorator', {}, mylib.behaviour).extends(mylib.behaviour.Decorator)

function mylib.behaviour.Decorator:init(child)
    mylib.behaviour.Decorator.super.init(self)
    self.child = child
    assert(child and child:isa(mylib.behaviour.Behavior), "Invalid object passed to behavior Decorator")
end

function mylib.behaviour.Decorator:onUpdate()
    self.child:update()
end
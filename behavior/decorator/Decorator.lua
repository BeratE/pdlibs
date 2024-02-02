import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

-- Decorate for a single child node, process the node on execution
class('Decorator', {}, mylib.behavior).extends(mylib.behavior.Behavior)

function mylib.behavior.Decorator:init(child)
    mylib.behavior.Decorator.super.init(self)
    self.child = child
    assert(child and child:isa(mylib.behavior.Behavior), "Invalid object passed to behavior Decorator")
end

function mylib.behavior.Decorator:onUpdate()
    self.child:update()
end
import "CoreLibs/object"

import "libs/behavior/Behavior"

-- Decorate for a single child node, process the node on execution
class('BehaviorDecorator').extends(Decorator)

function BehaviorDecorator:init(child)
    BehaviorDecorator.super.init(self)
    self.child = child
    assert(child and child:isa(Behavior), "Invalid object passed to BehaviorDecorator")
end

function BehaviorDecorator:onUpdate()
    self.child:update()
end
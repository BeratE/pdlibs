import "CoreLibs/object"

import "libs/behavior/base/Behavior"

class('BehaviorDecorator').extends(Decorator)

function BehaviorDecorator:init(child)
    BehaviorDecorator.super.init(self)
    self.child = child
    assert(child and child:isa(Behavior), "Invalid objecct passed to BehaviorDecorator")
end

function BehaviorDecorator:onUpdate()
    self.child:update()
end
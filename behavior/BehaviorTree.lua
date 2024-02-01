import "CoreLibs/object"

import "libs/behavior/Behavior"

-- Behavior tree containing behaviors as nodes 
class('BehaviorTree').extends()

function BehaviorTree:init(rootBehavior)
    BehaviourTree.super.init(self)
    self.root = rootBehavior
    assert(self.root and self.root:isa(Behavior), "Invalid object passed to BehaviorTree")
end

-- Update root node
function BehaviorTree:update()
    return self.root.update()
end
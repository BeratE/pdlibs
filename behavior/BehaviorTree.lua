import "CoreLibs/object"

import "libs/behavior/Behavior"

-- Behavior tree containing behaviors as nodes 
class('BehaviorTree', {}, mylib.behaviour).extends()

function mylib.behaviour.BehaviorTree:init(rootBehavior)
    BehaviourTree.super.init(self)
    self.root = rootBehavior
    assert(self.root and self.root:isa(mylib.behaviour.Behavior), "Invalid object passed to BehaviorTree")
end

-- Update root node
function mylib.behaviour.BehaviorTree:update()
    return self.root.update()
end
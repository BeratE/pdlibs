import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

-- Behavior tree containing behaviors as nodes 
class('BehaviorTree', {}, mylib.behavior).extends()

function mylib.behavior.BehaviorTree:init(rootBehavior)
    mylib.behavior.BehaviorTree.super.init(self)
    self.root = rootBehavior
    assert(self.root and self.root:isa(mylib.behavior.Behavior), "Invalid object passed to BehaviorTree")
end

-- Update root node
function mylib.behavior.BehaviorTree:update()
    return self.root:update()
end
import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

-- Behavior tree containing behaviors as nodes .
class('BehaviorTree', {}, mylib.behavior).extends()

function mylib.behavior.BehaviorTree:init(root)
    mylib.behavior.BehaviorTree.super.init(self)
    self:setRoot(root)
end

-- Update root node.
function mylib.behavior.BehaviorTree:update()
    return self.root:update()
end

function mylib.behavior.BehaviorTree:setRoot(root)
    assert(root and root:isa(mylib.behavior.Behavior), "Invalid root object passed to BehaviorTree")
    root.parent = self
    self.root = root
end

function mylib.behavior.BehaviorTree:getRoot()
    return self.root
end
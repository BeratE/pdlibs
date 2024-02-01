import "CoreLibs/object"

import "libs/behavior/base/Behavior"

class('BehaviorTree').extends()

function BehaviorTree:init(rootBehavior)
    BehaviourTree.super.init(self)
    self.root = rootBehavior
end

function BehaviorTree:update()
    if (self.root ~= nil) then
        self.root.update()
    end
end
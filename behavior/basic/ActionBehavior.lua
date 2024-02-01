import "CoreLibs/object"

import "libs/behavior/Behavior"

-- Basic Leaf Node (Task), executes a given function or the own onUpdate method.
class('ActionBehavior').extends(Behaviour)

function ActionBehavior:init(actionFunction)
    ActionBehavior.super.init(self)
    -- If an action function is given override the onUpdate behavior
    if (actionFunction) then
        self.actionFunction = actionFunction
        assert(type(actionFunction) == "function", "Invalid object passed to ActionBehavior")
        self.onUpdate = function (self)
            self.actionFunction(self)
        end
    end
end
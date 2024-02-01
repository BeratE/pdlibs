import "CoreLibs/object"

import "libs/behavior/Behavior"

-- Basic Leaf Node (Task), executes a given function or the own onUpdate method.
class('Action', {}, mylib.behaviour).extends(mylib.behaviour.Behaviour)

function mylib.behaviour.Action:init(actionFunction)
    mylib.behaviour.Action.super.init(self)
    -- If an action function is given override the onUpdate behavior
    if (actionFunction) then
        self.actionFunction = actionFunction
        assert(type(actionFunction) == "function", "Invalid object passed to Action behavior")
        self.onUpdate = function (self)
            self.actionFunction(self)
        end
    end
end
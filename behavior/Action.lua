import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

-- Basic Leaf Node (Task), executes a given function or the own onUpdate method.
class('Action', {}, mylib.behavior).extends(mylib.behavior.Behavior)

function mylib.behavior.Action:init(actionFunction)
    mylib.behavior.Action.super.init(self)
    -- If an action function is given override the onUpdate behavior
    if (actionFunction) then
        assert(type(actionFunction) == "function", "Invalid object passed to Action behavior")
        self.onUpdate = actionFunction
    end
end
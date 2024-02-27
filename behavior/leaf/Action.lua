import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

-- Basic Leaf Node (Task), executes a given function or the own onUpdate method.
class('Action', {}, pdlibs.behavior).extends(pdlibs.behavior.Behavior)

function pdlibs.behavior.Action:init(actionFunction)
    pdlibs.behavior.Action.super.init(self)
    if (not actionFunction) then
        actionFunction = function () end
    end
    assert(type(actionFunction) == "function", "Action behavior requires a function object")
    self.actionFunction = actionFunction
end

function pdlibs.behavior.Action:onUpdate()
    return self.actionFunction()
end
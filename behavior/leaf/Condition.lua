import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

-- Condition for returning either success or failure.
class('Condition', {}, mylib.behavior).extends(mylib.behavior.Behavior)

function mylib.behavior.Condition:init(conditionFunction)
    mylib.behavior.Condition.super.init(self)
    if (conditionFunction) then
        assert(type(conditionFunction) == "function", "Action behavior requires a function object")
        self.onUpdate = function ()
            local status = conditionFunction()
            if (status ~= mylib.behavior.Status.SUCCESS) then
                status = mylib.behavior.Status.FAILURE
            end
            return status
        end
    end
end
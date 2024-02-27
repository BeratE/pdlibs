import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

-- Condition for returning either success or failure.
class('Condition', {}, pdlibs.behavior).extends(pdlibs.behavior.Behavior)

function pdlibs.behavior.Condition:init(conditionFunction)
    pdlibs.behavior.Condition.super.init(self)
    if (conditionFunction) then
        assert(type(conditionFunction) == "function", "Action behavior requires a function object")
        self.onUpdate = function ()
            local status = conditionFunction()
            if (status ~= pdlibs.behavior.Status.SUCCESS) then
                status = pdlibs.behavior.Status.FAILURE
            end
            return status
        end
    end
end
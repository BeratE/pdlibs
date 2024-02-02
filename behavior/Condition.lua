import "CoreLibs/object"

import "pdlibs/behavior/Action"

class('Condition', {}, mylib.behavior).extends(mylib.behavior.Action)

function mylib.behavior.Condition:init(conditionFunction)
    mylib.behavior.Condition.super.init(self, conditionFunction)
end
import "CoreLibs/object"

import "pdlibs/vars"
import "pdlibs/behavior/Behavior"

-- Set given variable to value
mylib.behavior.var = mylib.behavior.var or {}
class('Set', {}, mylib.behavior.var).extends(mylib.behavior.Behavior)

function mylib.behavior.var.Set:init(varName, value)
    mylib.behavior.var.Set.super.init(self)
    self.varName = varName
    self.value = value
end

function mylib.behavior.var.Set:onUpdate()
    mylib.setVar(self.varName, self.value)
    return mylib.behavior.Status.SUCCESS
end
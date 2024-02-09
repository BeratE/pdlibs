import "CoreLibs/object"

import "pdlibs/util/debug/var"
import "pdlibs/behavior/Behavior"

-- Set given variable to value
mylib.behavior.var = mylib.behavior.var or {}
class('Set', {}, mylib.behavior.var).extends(mylib.behavior.Behavior)

function mylib.behavior.var.Set:init(varName, value)
    mylib.behavior.var.Set.super.init(self)
    self.namespace = namespace
    self.varName = varName
    self.value = value
end

function mylib.behavior.var.Set:onUpdate()
    mylib.var.set(self.varName, self.value, self.namespace)
    return mylib.behavior.Status.SUCCESS
end
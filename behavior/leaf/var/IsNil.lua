import "CoreLibs/object"

import "pdlibs/util/var"
import "pdlibs/behavior/Behavior"

-- Check if variable is null
mylib.behavior.var = mylib.behavior.var or {}
class('IsNil', {}, mylib.behavior.var).extends(mylib.behavior.Behavior)

function mylib.behavior.var.IsNil:init(varName, namespace)
    mylib.behavior.var.IsNil.super.init(self)
    self.namespace = namespace
    self.varName = varName
end

function mylib.behavior.var.IsNil:onUpdate()
    return mylib.var.get(varName, self.namespace) ~= nil
end

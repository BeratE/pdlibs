import "CoreLibs/object"

import "pdlibs/vars"
import "pdlibs/behavior/Behavior"

-- Check if variable is null
mylib.behavior.var = mylib.behavior.var or {}
class('IsNil', {}, mylib.behavior.var).extends(mylib.behavior.Behavior)

function mylib.behavior.var.IsNil:init(varName)
    mylib.behavior.var.IsNil.super.init(self)
    self.varName = varName
end

function mylib.behavior.var.IsNil:onUpdate()
    return mylib.getVar(varName) ~= nil
end

import "CoreLibs/object"

import "pdlibs/vars"
import "pdlibs/behavior/Behavior"

-- Abstract class for stack operation leaf nodes
mylib.behavior.var = mylib.behavior.var or {}
class('SetVar', {}, mylib.behavior.var).extends(mylib.behavior.Behavior)

function mylib.behavior.var.SetVar:init(varName, value)
    mylib.behavior.var.stack.SetVar.init(self)
    self.varName = varName
    self.value = value
end

function mylib.behavior.var.SetVar:onUpdate()
    mylib.setVar(self.varName, self.value)
    return mylib.behavior.Status.SUCCESS
end
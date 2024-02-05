import "CoreLibs/object"

import "pdlibs/vars"
import "pdlibs/behavior/Behavior"

-- Abstract class for stack operation leaf nodes
mylib.behavior.var = mylib.behavior.var or {}
class('IsNull', {}, mylib.behavior.var).extends(mylib.behavior.Behavior)

function mylib.behavior.var.IsNull:init(varName)
    mylib.behavior.var.stack.IsNull.init(self)
    self.varName = varName
end

function mylib.behavior.var.IsNull:onUpdate()
    return mylib.getVar(varName) ~= nil
end

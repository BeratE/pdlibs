import "CoreLibs/object"

import "pdlibs/vars"
import "pdlibs/behavior/Behavior"

-- Abstract class for stack operation leaf nodes
mylib.behavior.stack = mylib.behavior.stack or {}
class('Stack', {}, mylib.behavior.stack).extends(mylib.behavior.Behavior)

function mylib.behavior.stack.Stack:init(stackVar)
    mylib.behavior.stack.Stack.super.init(self)
    mylib.letVar(stackVar, {})
    self.stackVar = stackVar
end


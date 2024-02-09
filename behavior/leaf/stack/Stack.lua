import "CoreLibs/object"

import "pdlibs/var"
import "pdlibs/behavior/Behavior"

-- Abstract class for stack operation leaf nodes
mylib.behavior.stack = mylib.behavior.stack or {}
class('Stack', {}, mylib.behavior.stack).extends(mylib.behavior.Behavior)

function mylib.behavior.stack.Stack:init(stackVar, namespace)
    mylib.behavior.stack.Stack.super.init(self)
    mylib.var.let(stackVar, {}, namespace)
    self.namespace = namespace
    self.stackVar = stackVar
end


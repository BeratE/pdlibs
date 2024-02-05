import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

-- Abstract class for stack operation leaf nodes
mylib.behavior.stack = mylib.behavior.stack or {
    namespace = {} -- Namespace for stacks
}
class('Stack', {}, mylib.behavior.stack).extends(mylib.behavior.Behavior)

function mylib.behavior.stack.Stack:init(stackVar)
    mylib.behavior.stack.Stack.super.init(self)
    self.stackVar = mylib.behavior.stack.declare(stackVar)
end

function mylib.behavior.stack:getStack(stackVar)
    return mylib.behavior.stack.namespace[stackVar]
end

function mylib.behavior.stack.declare(stackVar)
    assert(type(stackVar) == "string", "Behavior stack requires string as variable name")
    mylib.behavior.stack.namespace[stackVar] = {}
    return stackVar
end


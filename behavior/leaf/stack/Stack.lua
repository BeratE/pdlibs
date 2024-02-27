import "CoreLibs/object"

import "pdlibs/util/var"
import "pdlibs/behavior/Behavior"

-- Abstract class for stack operation leaf nodes
pdlibs.behavior.stack = pdlibs.behavior.stack or {}
class('Stack', {}, pdlibs.behavior.stack).extends(pdlibs.behavior.Behavior)

function pdlibs.behavior.stack.Stack:init(stackVar, namespace)
    pdlibs.behavior.stack.Stack.super.init(self)
    pdlibs.var.let(stackVar, {}, namespace)
    self.namespace = namespace
    self.stackVar = stackVar
end


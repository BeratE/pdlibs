import "CoreLibs/object"

import "pdlibs/behavior/leaf/stack/Stack"

local next = next -- constant time indexing to next primitive

-- Check if the given stack is empty
class('Empty', {}, mylib.behavior.stack).extends(mylib.behavior.stack.Stack)

function mylib.behavior.stack.Empty:init(stackVar, namespace)
    mylib.behavior.stack.Empty.super.init(self, stackVar, namespace)
end

function mylib.behavior.stack.Empty:onUpdate()
    return (next(mylib.var.get(self.stackVar, self.namespace)) == {})
end
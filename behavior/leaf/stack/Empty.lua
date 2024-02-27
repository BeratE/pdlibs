import "CoreLibs/object"

import "pdlibs/behavior/leaf/stack/Stack"

local next = next -- constant time indexing to next primitive

-- Check if the given stack is empty
class('Empty', {}, pdlibs.behavior.stack).extends(pdlibs.behavior.stack.Stack)

function pdlibs.behavior.stack.Empty:init(stackVar, namespace)
    pdlibs.behavior.stack.Empty.super.init(self, stackVar, namespace)
end

function pdlibs.behavior.stack.Empty:onUpdate()
    return (next(pdlibs.var.get(self.stackVar, self.namespace)) == {})
end
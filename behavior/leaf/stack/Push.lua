import "CoreLibs/object"

import "pdlibs/behavior/leaf/stack/Stack"

-- Push given item onto the given stack
class('Push', {}, pdlibs.behavior.stack).extends(pdlibs.behavior.stack.Stack)

function pdlibs.behavior.stack.Push:init(stackVar, itemValue, namespace)
    pdlibs.behavior.stack.Push.super.init(self, stackVar, namespace)
    self.itemValue = itemValue
end

function pdlibs.behavior.stack.Push:onUpdate()
    table.insert(pdlibs.var.get(self.stackVar, self.namespace), self.itemValue)
    return pdlibs.behavior.Status.SUCCESS
end
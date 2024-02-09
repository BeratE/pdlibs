import "CoreLibs/object"

import "pdlibs/behavior/leaf/stack/Stack"

-- Push given item onto the given stack
class('Push', {}, mylib.behavior.stack).extends(mylib.behavior.stack.Stack)

function mylib.behavior.stack.Push:init(stackVar, itemValue, namespace)
    mylib.behavior.stack.Push.super.init(self, stackVar, namespace)
    self.itemValue = itemValue
end

function mylib.behavior.stack.Push:onUpdate()
    table.insert(mylib.var.get(self.stackVar, self.namespace), self.itemValue)
    return mylib.behavior.Status.SUCCESS
end
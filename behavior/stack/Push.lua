import "CoreLibs/object"

import "pdlibs/behavior/stack/Stack"

-- Push given item onto the given stack
class('Push', {}, mylib.behavior.stack).extends(mylib.behavior.stack.Stack)

function mylib.behavior.stack.Push:init(item, stackVar)
    mylib.behavior.stack.Push.super.init(self, stackVar)
    self.item = item
end

function mylib.behavior.stack.Push:onUpdate()
    table.insert(mylib.behavior.stack.namespace[self.stackVar], self.item)
    return mylib.behavior.Status.SUCCESS
end
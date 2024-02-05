import "CoreLibs/object"

import "pdlibs/behavior/stack/Stack"

-- Push given item onto the given stack
class('Push', {}, mylib.behavior.stack).extends(mylib.behavior.stack.Stack)

function mylib.behavior.stack.Push:init(stackVar, itemValue)
    mylib.behavior.stack.Push.super.init(self, stackVar)
    self.itemValue = itemValue
end

function mylib.behavior.stack.Push:onUpdate()
    table.insert(mylib.getVar(self.stackVar), self.itemValue)
    return mylib.behavior.Status.SUCCESS
end
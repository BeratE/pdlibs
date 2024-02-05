import "CoreLibs/object"

import "pdlibs/behavior/stack/Stack"

-- Pop stack and store value in given itemVar
class('Pop', {}, mylib.behavior.stack).extends(mylib.behavior.stack.Stack)

function mylib.behavior.stack.Pop:init(stackVar, itemVar)
    mylib.behavior.stack.Pop.super.init(self, stackVar)
    self.itemVar = itemVar
end

function mylib.behavior.stack.Pop:onUpdate()
    mylib.setVar(self.itemVar, table.remove(mylib.getVar(self.stackVar)))
    return mylib.behavior.Status.SUCCESS
end
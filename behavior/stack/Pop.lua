import "CoreLibs/object"

import "pdlibs/behavior/stack/Stack"

-- Pop stack and store value in given itemVar
class('Pop', {}, mylib.behavior.stack).extends(mylib.behavior.stack.Stack)

function mylib.behavior.stack.Pop:init(item, stackVar)
    mylib.behavior.stack.Pop.super.init(self, stackVar)
    self.itemVar = item
end

function mylib.behavior.stack.Pop:onUpdate()
    self.itemVar = table.remove(mylib.behavior.stack.namespace[self.stackVar])
    print(self.itemVar)
    return mylib.behavior.Status.SUCCESS
end
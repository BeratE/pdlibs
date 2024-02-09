import "CoreLibs/object"

import "pdlibs/behavior/leaf/stack/Stack"

-- Pop stack, store value in itemVar if given 
class('Pop', {}, mylib.behavior.stack).extends(mylib.behavior.stack.Stack)

function mylib.behavior.stack.Pop:init(stackVar, itemVar)
    mylib.behavior.stack.Pop.super.init(self, stackVar)
    self.itemVar = itemVar
end

function mylib.behavior.stack.Pop:onUpdate()
    local val = table.remove(mylib.var.get(self.stackVar))
    if (self.itemVar ~= nil) then
        mylib.var.set(self.itemVar, val)
    end
    return mylib.behavior.Status.SUCCESS
end
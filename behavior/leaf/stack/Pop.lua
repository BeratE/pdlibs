import "CoreLibs/object"

import "pdlibs/behavior/leaf/stack/Stack"

-- Pop stack, store value in itemVar if given 
class('Pop', {}, pdlibs.behavior.stack).extends(pdlibs.behavior.stack.Stack)

function pdlibs.behavior.stack.Pop:init(stackVar, itemVar, namespace)
    pdlibs.behavior.stack.Pop.super.init(self, stackVar, namespace)
    self.itemVar = itemVar
end

function pdlibs.behavior.stack.Pop:onUpdate()
    local val = table.remove(pdlibs.var.get(self.stackVar, self.namespace))
    if (self.itemVar ~= nil) then
        pdlibs.var.set(self.itemVar, val, self.namespace)
    end
    return pdlibs.behavior.Status.SUCCESS
end
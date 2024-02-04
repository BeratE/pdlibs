import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

-- Execute child action and return inverse completion status
class('Invert', {}, mylib.behavior).extends(mylib.behavior.Decorator)

function mylib.behavior.Invert:init(child)
    mylib.behavior.Invert.super.init(self, child)
end

function mylib.behavior.Invert:onUpdate()
    local status = self.child:update()
    if (type(status) == "boolean") then
        status = not status
    end
    return status
end
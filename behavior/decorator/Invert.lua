import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

-- Execute child action and return inverse completion status
class('Invert', {}, pdlibs.behavior).extends(pdlibs.behavior.Decorator)

function pdlibs.behavior.Invert:init(child)
    pdlibs.behavior.Invert.super.init(self, child)
end

function pdlibs.behavior.Invert:onUpdate()
    local status = self.child:update()
    if (type(status) == "boolean") then
        status = not status
    end
    return status
end
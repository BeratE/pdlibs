import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

-- Execute child behavior and always return running
class('Run', {}, pdlibs.behavior).extends(pdlibs.behavior.Decorator)

function pdlibs.behavior.Run:init(child)
    pdlibs.behavior.Run.super.init(self, child)
end

function pdlibs.behavior.Run:onUpdate()
    local status = self.child:update()
    return pdlibs.behavior.Status.RUNNING
end
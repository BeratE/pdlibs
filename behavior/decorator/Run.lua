import "CoreLibs/object"

import "pdlibs/behavior/decorator/Decorator"

-- Execute child behavior and always return running
class('Run', {}, mylib.behavior).extends(mylib.behavior.Decorator)

function mylib.behavior.Run:init(child)
    mylib.behavior.Run.super.init(self, child)
end

function mylib.behavior.Run:onUpdate()
    local status = self.child:update()
    return mylib.behavior.Status.RUNNING
end
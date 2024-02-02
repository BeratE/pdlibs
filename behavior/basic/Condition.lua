import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

class('Condition', {}, mylib.behavior).extends(mylib.behavior.Behavior)

function mylib.behavior.Condition:init()
    mylib.behavior.Condition.super.init(self)
end
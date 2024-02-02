import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

class('Condition', {}, mylib.behaviour).extends(mylib.behaviour.Behaviour)

function mylib.behaviour.Condition:init()
    mylib.behaviour.Condition.super.init(self)
end
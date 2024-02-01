import "CoreLibs/object"

import "libs/behavior/Behavior"

class('ConditionBehavior').extends(Behaviour)

function ConditionBehavior:init()
    ConditionBehavior.super.init(self)
end
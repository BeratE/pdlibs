import "CoreLibs/object"

import "pdlibs/behavior/composite/Sequence"

-- A filter executes a given behaviour only if a condition has been fulfulled
class('Filter', {}, mylib.behaviour).extends(mylib.behaviour.Sequence)

function mylib.behaviour.Filter:init(condition, behavior)
    mylib.behaviour.Filter.super.init(self, {condition, behavior})
end
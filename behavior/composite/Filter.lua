import "CoreLibs/object"

import "pdlibs/behavior/composite/Sequence"

-- A filter executes a given behavior only if a condition has been fulfulled
class('Filter', {}, mylib.behavior).extends(mylib.behavior.Sequence)

function mylib.behavior.Filter:init(condition, behavior)
    mylib.behavior.Filter.super.init(self, {condition, behavior})
end
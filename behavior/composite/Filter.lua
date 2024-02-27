import "CoreLibs/object"

import "pdlibs/behavior/composite/Sequence"
import "pdlibs/behavior/leaf/Condition"

-- A filter executes a given behavior only if a condition has been fulfulled.
class('Filter', {}, pdlibs.behavior).extends(pdlibs.behavior.Sequence)

function pdlibs.behavior.Filter:init(condition, behavior)
    if (type(condition) == "function") then
        condition = pdlibs.behavior.Condition(condition)
    end
    pdlibs.behavior.Filter.super.init(self, {condition, behavior})
end
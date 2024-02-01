import "CoreLibs/object"

import "libs/behavior/composite/SequenceBehavior"

-- A filter executes a given behaviour only if a condition has been fulfulled
class('FilterBehavior').extends(SequenceBehavior)

function FilterBehavior:init(condition, behavior)
    FilterBehavior.super.init(self, {condition, behavior})
end
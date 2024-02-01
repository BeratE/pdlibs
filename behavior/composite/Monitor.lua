import "CoreLibs/object"

import "libs/behavior/composite/Parallel"

-- Monitors a condition and performs the given behavior while its successfull
class('Monitor', {}, mylib.behaviour).extends(mylib.behaviour.Parallel)

function Monitor:init(condition, behavior)
    Monitor.super.init(self, {condition, behavior})
end
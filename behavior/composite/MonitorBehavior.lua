import "CoreLibs/object"

import "libs/behavior/composite/ParallelBehavior"

-- Monitors a condition and performs the given behavior while its successfull
class('MonitorBehavior').extends(ParallelBehavior)

function MonitorBehavior:init(condition, behavior)
    MonitorBehavior.super.init(self, {condition, behavior})
end
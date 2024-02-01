import "CoreLibs/object"

import "libs/behavior/composite/Parallel"

-- Monitors a condition and performs the given behavior while its successfull
class('Monitor', {}, mylib.behaviour).extends(mylib.behaviour.Parallel)

function mylib.behaviour.Monitor:init(condition, behavior)
    mylib.behaviour.Monitor.super.init(self, {condition, behavior})
end
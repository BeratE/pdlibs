import "CoreLibs/object"

import "pdlibs/behavior/composite/Parallel"

-- Monitors a condition and performs the given behavior while its successfull.
class('Monitor', {}, mylib.behavior).extends(mylib.behavior.Parallel)

function mylib.behavior.Monitor:init(condition, behavior)
    mylib.behavior.Monitor.super.init(self,
        mylib.behavior.Parallel.Require.All, -- success policy
        mylib.behavior.Parallel.Require.One, -- failure policy
        {condition, behavior})
end
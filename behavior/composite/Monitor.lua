import "CoreLibs/object"

import "pdlibs/behavior/composite/Parallel"
import "pdlibs/behavior/leaf/Condition"

-- Monitors a condition and performs the given behavior while its successfull.
class('Monitor', {}, pdlibs.behavior).extends(pdlibs.behavior.Parallel)

function pdlibs.behavior.Monitor:init(condition, behavior)
    if (type(condition) == "function") then
        condition = pdlibs.behavior.Condition(condition)
    end
    pdlibs.behavior.Monitor.super.init(self,
        pdlibs.behavior.Parallel.Require.All, -- success policy
        pdlibs.behavior.Parallel.Require.One, -- failure policy
        {condition, behavior})
end
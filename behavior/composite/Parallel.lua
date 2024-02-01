import "CoreLibs/object"

import "libs/behavior/composite/Composite"

-- Success/Fail Policy of executed children in parallel execution
ParallelPolicy = {
    RequireOne = 1,
    RequireAll = 2
}

-- Allow behaviors to run in parallel and for them to be aborted if some or all of them fail
class('Parallel', {}, mylib.behaviour).extends(mylib.behaviour.Composite)

function mylib.behaviour.Parallel:init(children, successPolicy, failurePolicy)
    mylib.behaviour.Parallel.super.init(self, children)
    self.successPolicy = successPolicy or ParallelPolicy.RequireAll
    self.failurePolicy = failurePolicy or ParallelPolicy.RequireOne
end

function mylib.behaviour.Parallel:onUpdate()
    local successCount = 0
    local failureCount = 0
    for _, child in self.children do
        if child:isRunning() then
            child:update()
        end
        if (child:getStatus() == BH_STATUS.SUCCESS) then
            successCount += 1
            if (self.successPolicy == ParallelPolicy.RequireOne) then
                return BH_STATUS.SUCCESS
            end
        end
        if (child:getStatus() == BH_STATUS.FAILURE) then
            failureCount += 1
            if (self.failurePolicy == ParallelPolicy.RequireOne) then
                return BH_STATUS.FAILURE
            end
        end
    end
    if (self.failurePolicy == ParallelPolicy.RequireAll and failureCount == self.nChildren) then
        return BH_STATUS.FAILURE
    end
    if (self.successPolicy == ParallelPolicy.RequireAll and successCount == self.nChildren) then
        return BH_STATUS.SUCCESS
    end
    return BH_STATUS.RUNNING
end

function mylib.behaviour.Parallel:onTerminate(status)
    mylib.behaviour.Parallel.super.onTerminate(self)
    for _, child in ipairs(self.children) do
        child:abort()
    end
end
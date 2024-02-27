import "CoreLibs/object"

import "pdlibs/behavior/composite/Composite"

-- Allow behaviors to run in parallel and for them to be aborted if some or all of them fail.
class('Parallel', {}, pdlibs.behavior).extends(pdlibs.behavior.Composite)

-- Success/Fail Policy of executed children in parallel execution.
pdlibs.behavior.Parallel.Require = {
    One = 1,
    All = 2
}

function pdlibs.behavior.Parallel:init(successPolicy, failurePolicy, children)
    pdlibs.behavior.Parallel.super.init(self, children)
    self.successPolicy = successPolicy or pdlibs.behavior.Parallel.Require.All
    self.failurePolicy = failurePolicy or pdlibs.behavior.Parallel.Require.One
end

function pdlibs.behavior.Parallel:onUpdate()
    local successCount = 0
    local failureCount = 0
    for i, child in ipairs(self.children) do
        local status = child:update()
        if (status == pdlibs.behavior.Status.SUCCESS) then
            successCount += 1
            if (self.successPolicy == pdlibs.behavior.Parallel.Require.One) then
                return pdlibs.behavior.Status.SUCCESS
            end
        end
        if (status == pdlibs.behavior.Status.FAILURE) then
            failureCount += 1
            if (self.failurePolicy == pdlibs.behavior.Parallel.Require.One) then
                return pdlibs.behavior.Status.FAILURE
            end
        end
    end
    if (self.failurePolicy == pdlibs.behavior.Parallel.Require.All and failureCount == #self.children) then
        return pdlibs.behavior.Status.FAILURE
    end
    if (self.successPolicy == pdlibs.behavior.Parallel.Require.All and successCount == #self.children) then
        return pdlibs.behavior.Status.SUCCESS
    end
    return pdlibs.behavior.Status.RUNNING
end

function pdlibs.behavior.Parallel:onTerminate(status)
    pdlibs.behavior.Parallel.super.onTerminate(self)
    for _, child in ipairs(self.children) do
        child:abort()
    end
end
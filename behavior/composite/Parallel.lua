import "CoreLibs/object"

import "pdlibs/behavior/composite/Composite"

-- Allow behaviors to run in parallel and for them to be aborted if some or all of them fail.
class('Parallel', {}, mylib.behavior).extends(mylib.behavior.Composite)

-- Success/Fail Policy of executed children in parallel execution.
mylib.behavior.Parallel.Require = {
    One = 1,
    All = 2
}

function mylib.behavior.Parallel:init(successPolicy, failurePolicy, children)
    mylib.behavior.Parallel.super.init(self, children)
    self.successPolicy = successPolicy or mylib.behavior.Parallel.Require.All
    self.failurePolicy = failurePolicy or mylib.behavior.Parallel.Require.One
end

function mylib.behavior.Parallel:onUpdate()
    local successCount = 0
    local failureCount = 0
    for i, child in ipairs(self.children) do
        local status = child:update()
        if (status == mylib.behavior.Status.SUCCESS) then
            successCount += 1
            if (self.successPolicy == mylib.behavior.Parallel.Require.One) then
                return mylib.behavior.Status.SUCCESS
            end
        end
        if (status == mylib.behavior.Status.FAILURE) then
            failureCount += 1
            if (self.failurePolicy == mylib.behavior.Parallel.Require.One) then
                return mylib.behavior.Status.FAILURE
            end
        end
    end
    if (self.failurePolicy == mylib.behavior.Parallel.Require.All and failureCount == #self.children) then
        return mylib.behavior.Status.FAILURE
    end
    if (self.successPolicy == mylib.behavior.Parallel.Require.All and successCount == #self.children) then
        return mylib.behavior.Status.SUCCESS
    end
    return mylib.behavior.Status.RUNNING
end

function mylib.behavior.Parallel:onTerminate(status)
    mylib.behavior.Parallel.super.onTerminate(self)
    for _, child in ipairs(self.children) do
        child:abort()
    end
end
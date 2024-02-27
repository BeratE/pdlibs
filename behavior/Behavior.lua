import "CoreLibs/object"

-- Abstract node in an BehaviorTree, as interface that can be actived, run and deactived.
pdlibs = pdlibs or {}
pdlibs.behavior = pdlibs.behavior or {}
class('Behavior', {}, pdlibs.behavior).extends()

-- Behavior Status
pdlibs.behavior.Status = {
    -- Completion Status
    SUCCESS = true,
    FAILURE = false,
    -- Execution Hints
    INVALID   = nil,
    RUNNING   = 1,
    ABORTED   = 2,
}

function pdlibs.behavior.Behavior:init()
    pdlibs.behavior.Behavior.super.init(self)
    self.status = pdlibs.behavior.Status.INVALID
    self.parent = nil
end

-- Called once, immediately before first call to update.
function pdlibs.behavior.Behavior:onActivate()
    self.status = pdlibs.behavior.Status.RUNNING
    self.nTicks = 0
end

-- Called once, immediately after last call to update.
function pdlibs.behavior.Behavior:onTerminate(status)
end

-- Update the behavior. Override this.
function pdlibs.behavior.Behavior:onUpdate()
    return pdlibs.behavior.Status.SUCCESS
end

-- Called when the behavior is aborted. Override if necessary.
function pdlibs.behavior.Behavior:onAbort()
    self:onTerminate()
end

-- Wrapper function for updating the behavior. Dont override!
function pdlibs.behavior.Behavior:update()
    if (not self:isRunning()) then
        self:onActivate()
    end
    self.nTicks += 1
    self.status = self:onUpdate()
    if (not self:isRunning()) then
        self:onTerminate()
    end
    return self.status
end

-- Call to imediately end a running behavior.
function pdlibs.behavior.Behavior:abort()
    if (self.status == pdlibs.behavior.Status.RUNNING) then
        self.status = pdlibs.behavior.Status.ABORTED
        self:onAbort()
    end
end

-- Check if behavior is currently running.
function pdlibs.behavior.Behavior:isRunning()
    return self.status == pdlibs.behavior.Status.RUNNING
end

-- Get the status from the last call to update.
function pdlibs.behavior.Behavior:getStatus()
    return self.status
end

function pdlibs.behavior.Behavior:setParent(parent)
    self.parent = parent
end

function pdlibs.behavior.Behavior:isRoot()
    return self.parent == nil
end
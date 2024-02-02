import "CoreLibs/object"

-- Abstract node in an BehaviorTree, as interface that can be actived, run and deactived
mylib = mylib or {}
mylib.behavior = mylib.behavior or {}
class('Behavior', {}, mylib.behavior).extends()

-- Behavior Status
mylib.behavior.Status = {
    -- Completion Status
    FAILURE = -1,
    SUCCESS =  0,
    -- Execution Hints
    INVALID   = nil,
    RUNNING   = 1,
    ABORTED   = 2,
}

function mylib.behavior.Behavior:init()
    mylib.behavior.Behavior.super.init(self)
    self.status = mylib.behavior.Status.INVALID
end

-- Wrapper function for updating the behavior
function mylib.behavior.Behavior:update()
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

-- Call to imediately end a running behavior
function mylib.behavior.Behavior:abort()
    if (self.status == mylib.behavior.Status.RUNNING) then
        self.status = mylib.behavior.Status.ABORTED
        self:onTerminate()
    end
end

function mylib.behavior.Behavior:isRunning()
    return self.status == mylib.behavior.Status.RUNNING
end

function mylib.behavior.Behavior:getStatus()
    return self.status
end

-- Called once, immediately before first call to update
function mylib.behavior.Behavior:onActivate()
    self.status = mylib.behavior.Status.RUNNING
    self.nTicks = 0
end

-- Called once, immediately after last call to update
function mylib.behavior.Behavior:onTerminate(status)
end

-- Update the behavior
function mylib.behavior.Behavior:onUpdate()
    return mylib.behavior.Status.SUCCESS
end
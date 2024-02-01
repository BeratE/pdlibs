import "CoreLibs/object"

-- Behaviour Status
BH_STATUS = {
    -- Completion Status
    FAILURE = -1,
    SUCCESS =  0,
    -- Execution Hints
    INVALID   = 1,
    RUNNING   = 2,
    ABORTED   = 3,
}

-- Abstract node in an BehaviourTree, as interface that can be actived, run and deactived
mylib = mylib or {}
mylib.behaviour = {}
class('Behavior', {}, mylib.behaviour).extends()

function mylib.behaviour.Behavior:init()
    mylib.behaviour.Behavior.super.init(self)
    self.status = BH_STATUS.INVALID
end

-- Wrapper function for updating the behavior
function mylib.behaviour.Behavior:update()
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
function mylib.behaviour.Behaviour:abort()
    if (self.status == BH_STATUS.RUNNING) then
        self.status = BH_STATUS.ABORTED
        self.onTerminate()
    end
end

function mylib.behaviour.Behavior:isRunning()
    return self.status == BH_STATUS.RUNNING
end

function mylib.behaviour.Behavior:getStatus()
    return self.status
end

-- Called once, immediately before first call to update
function mylib.behaviour.Behavior:onActivate()
    self.status = BH_STATUS.RUNNING
    self.nTicks = 0
end

-- Called once, immediately after last call to update
function mylib.behaviour.Behavior:onTerminate(status)
end

-- Update the behavior
function mylib.behaviour.Behavior:onUpdate()
    return BH_STATUS.SUCCESS
end
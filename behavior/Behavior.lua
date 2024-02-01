import "CoreLibs/object"

-- Behaviour Status
BH_STATUS = {
    -- Completion Status
    FAILURE = -1,
    SUCCESS =  0,
    -- Execution Hints
    INVALID   = 1,
    RUNNING   = 2,
}

-- Abstract node in an BehaviourTree, as interface that can be actived, run and deactived
class('Behavior').extends()

function Behavior:init()
    Behavior.super.init(self)
    self:reset()
end

-- Wrapper function for updating the behavior
function Behavior:update()
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
function Behaviour:abort()
    if (self.status == BH_STATUS.RUNNING) then
        self.onTerminate()
    end
end

function Behavior:isRunning()
    return self.status == BH_STATUS.RUNNING
end

function Behavior:getStatus()
    return self.status
end

function Behaviour:reset()
    self.status = BH_STATUS.INVALID
    self.nTicks = 0
end

-- Called once, immediately before first call to update
function Behavior:onActivate()
    self.status = BH_STATUS.RUNNING
end

-- Called once, immediately after last call to update
function Behavior:onTerminate(status)
end

-- Update the behavior
function Behavior:onUpdate()
    return BH_STATUS.SUCCESS
end
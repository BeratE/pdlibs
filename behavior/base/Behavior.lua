import "CoreLibs/object"

BH_STATUS = {
    -- Completion Status
    FAILURE = -1,
    SUCCESS =  0,
    -- Execution Hints
    INVALID   = 1,
    RUNNING   = 2,
}

class('Behavior').extends()

-- Abstract interface that can be actived, run and deactived
function Behavior:init()
    Behavior.super.init(self)
    self.status = BH_STATUS.INVALID
    local nTicks = 0
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

function Behavior:isRunning()
    return self.status == BH_STATUS.RUNNING
end

function Behavior:getStats()
    return self.status
end
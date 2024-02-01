import "CoreLibs/object"

import "libs/state/State"

-- StateMachine used to handle transitions between states.
class('StateMachine').extends()

function StateMachine:init(scene)
    StateMachine.super.init(self)
    self.currentState = scene
    self.previousState = nil
end

-- Switch to the given state
function StateMachine:switch(state,
    --[[optional]] skipExit,
    --[[optional]] skipEnter)
    if (self.currentState and not skipExit) then
        self.currentState:onExit()
    end
    self.previousState = self.currentState
    self.currentState = state
    if (self.currentState and not skipEnter) then
        self.currentState:onEnter()
    end
end

-- Revert to the previous state
function StateMachine:revert(
    --[[optional]] skipExit,
    --[[optional]] skipEnter)
    scene = self.currentState
    if (self.currentState and not skipExit) then
        self.currentState:onExit()
    end
    self.currentState = self.previousState
    self.previousState = scene
    if (self.currentState and not skipEnter) then
        self.currentState:onEnter()
    end
end

-- Update the current state
function StateMachine:update()
    if (self.currentState) then
        self.currentState:onUpdate()
    end
end

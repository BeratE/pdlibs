import "CoreLibs/object"

import "pdlibs/state/State"

-- StateMachine used to handle transitions between states.
class('StateMachine', {}, pdlibs.state).extends()

function pdlibs.state.StateMachine:init(state)
    pdlibs.state.StateMachine.super.init(self)
    self.currentState = state or pdlibs.state.State()
    self.previousState = pdlibs.state.State()
end

-- Switch to the given state
function pdlibs.state.StateMachine:switch(state,
    --[[optional]] skipExit,
    --[[optional]] skipEnter)
    if (not skipExit) then
        self.currentState:onExit()
    end
    self.previousState = self.currentState
    self.currentState = state
    if (not skipEnter) then
        self.currentState:onEnter()
    end
end

-- Revert to the previous state
function pdlibs.state.StateMachine:revert(
    --[[optional]] skipExit,
    --[[optional]] skipEnter)
    scene = self.currentState
    if (not skipExit) then
        self.currentState:onExit()
    end
    self.currentState = self.previousState
    self.previousState = scene
    if (not skipEnter) then
        self.currentState:onEnter()
    end
end

-- Update the current state
function pdlibs.state.StateMachine:update()
    self.currentState:onUpdate()
end

-- Override object isa function
function pdlibs.state.StateMachine:isa(class)
    self.currentState:isa(class)
end
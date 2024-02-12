import "CoreLibs/object"

import "pdlibs/state/State"

-- StateMachine used to handle transitions between states.
class('StateMachine', {}, mylib.state).extends()

function mylib.state.StateMachine:init(state)
    mylib.state.StateMachine.super.init(self)
    self.currentState = state or mylib.state.State()
    self.previousState = mylib.state.State()
end

-- Switch to the given state
function mylib.state.StateMachine:switch(state,
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
function mylib.state.StateMachine:revert(
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
function mylib.state.StateMachine:update()
    self.currentState:onUpdate()
end

-- Override object isa function
function mylib.state.StateMachine:isa(class)
    self.currentState:isa(class)
end
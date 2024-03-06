import "CoreLibs/object"

import "pdlibs/state/State"

-- StateMachine used to handle transitions between states.
class('StateMachine', {}, pdlibs.state).extends()

function pdlibs.state.StateMachine:init(state)
    pdlibs.state.StateMachine.super.init(self)
    self.current = state or pdlibs.state.State()
    self.previous = pdlibs.state.State()
end

-- Switch to the given state
function pdlibs.state.StateMachine:switch(state,
    --[[optional]] skipExit,
    --[[optional]] skipEnter)
    if (not skipExit) then
        self.current:onExit()
    end
    self.previous = self.current
    self.current = state
    if (not skipEnter) then
        self.current:onEnter()
    end
end

-- Revert to the previous state
function pdlibs.state.StateMachine:revert(
    --[[optional]] skipExit,
    --[[optional]] skipEnter)
    scene = self.current
    if (not skipExit) then
        self.current:onExit()
    end
    self.current = self.previous
    self.previous = scene
    if (not skipEnter) then
        self.current:onEnter()
    end
end

-- Update the current state
function pdlibs.state.StateMachine:update()
    self.current:onUpdate()
end

-- Override object isa function
function pdlibs.state.StateMachine:isa(class)
    self.current:isa(class)
end
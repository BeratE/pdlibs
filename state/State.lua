import "CoreLibs/object"


pdlibs = pdlibs or {}
pdlibs.state = {}

-- Abstract representation of a state.
class('State', {}, pdlibs.state).extends()

-- Called when creating the state (object constructor)
function pdlibs.state.State:init()
end

-- Called when entering the state.
function pdlibs.state.State:onEnter()
end

-- Called when exiting the state.
function pdlibs.state.State:onExit()
end

-- Called on every update iteration.
function pdlibs.state.State:onUpdate()
end
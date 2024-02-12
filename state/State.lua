import "CoreLibs/object"

-- Abstract representation of a state.
mylib = mylib or {}
mylib.state = {}
class('State', {}, mylib.state).extends()

-- Called when creating the state (object constructor)
function mylib.state.State:init()
end

-- Called when entering the state.
function mylib.state.State:onEnter()
end

-- Called when exiting the state.
function mylib.state.State:onExit()
end

-- Called on every update iteration.
function mylib.state.State:onUpdate()
end
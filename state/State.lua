import "CoreLibs/object"

-- Abstract representation of a state.
class('State').extends()

-- Called when entering the state.
function State:onEnter()
end

-- Called when exiting the state.
function State:onExit()
end

-- Called on every update iteration.
function State:onUpdate()
end
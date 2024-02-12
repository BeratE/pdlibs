import "CoreLibs/object"

import "pdlibs/behavior/leaf/Action"

-- Decorate for a single child node, process the node on execution.
class('Decorator', {}, mylib.behavior).extends(mylib.behavior.Behavior)

function mylib.behavior.Decorator:init(child)
    mylib.behavior.Decorator.super.init(self)
    self:setChild(child)
end

function mylib.behavior.Decorator:onUpdate()
    self.child:update()
end

function mylib.behavior.Decorator:setChild(child)
    -- Wrap child if type of child is a function
    if (type(child) == "nil") then
        child = mylib.behavior.Action()
    end
    if (type(child) == "function") then
        local actionFunction = child
        child = mylib.behavior.Action(actionFunction)
    end
    assert(child and child:isa(mylib.behavior.Behavior), "Invalid child object passed to behavior Decorator")
    child:setParent(self)
    self.child = child
end

function mylib.behavior.Decorator:getChild()
    return self.child
end

function mylib.behavior.Decorator:setParent(parent)
    self.child.parent = parent
    self.parent = parent
end
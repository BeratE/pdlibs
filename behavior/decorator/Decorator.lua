import "CoreLibs/object"

import "pdlibs/behavior/leaf/Action"

-- Decorate for a single child node, process the node on execution.
class('Decorator', {}, pdlibs.behavior).extends(pdlibs.behavior.Behavior)

function pdlibs.behavior.Decorator:init(child)
    pdlibs.behavior.Decorator.super.init(self)
    self:setChild(child)
end

function pdlibs.behavior.Decorator:onUpdate()
    self.child:update()
end

function pdlibs.behavior.Decorator:setChild(child)
    -- Wrap child if type of child is a function
    if (type(child) == "nil") then
        child = pdlibs.behavior.Action()
    end
    if (type(child) == "function") then
        local actionFunction = child
        child = pdlibs.behavior.Action(actionFunction)
    end
    assert(child and child:isa(pdlibs.behavior.Behavior), "Invalid child object passed to behavior Decorator")
    child:setParent(self)
    self.child = child
end

function pdlibs.behavior.Decorator:getChild()
    return self.child
end

function pdlibs.behavior.Decorator:setParent(parent)
    self.child.parent = parent
    self.parent = parent
end
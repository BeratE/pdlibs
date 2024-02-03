import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

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
    assert(child and child:isa(mylib.behavior.Behavior), "Invalid child object passed to behavior Decorator")
    if (self.child ~= nil) then
        child:setParent(self.child:getParent())
    end
    self.child = child
end

function mylib.behavior.Decorator:getChild()
    return self.child
end

function mylib.behavior.Decorator:setParent(parent)
    self.child:setParent(parent)
end

function mylib.behavior.Decorator:getParent()
    return self.child.parent
end
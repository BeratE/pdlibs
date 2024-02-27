import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

-- Compositie node containing many children.
class('Composite', {}, pdlibs.behavior).extends(pdlibs.behavior.Behavior)

function pdlibs.behavior.Composite:init(children)
    pdlibs.behavior.Composite.super.init(self)
    self:setChildren(children)
end

function pdlibs.behavior.Composite:setChildren(children)
    assert(children and type(children) == "table", "Composite behavior requires a table of children objects")
    self.children = {}
    for _, child in pairs(children) do
        self:addChildBack(child)
    end
end

function pdlibs.behavior.Composite:getChild(index)
    return self.children[index]
end

function pdlibs.behavior.Composite:addChild(child, index)
    assert(child:isa(pdlibs.behavior.Behavior), "Invalid child object passed to Composite behavior")
    child:setParent(self)
    table.insert(self.children, index, child)
end

function pdlibs.behavior.Composite:removeChild(index)
    return table.remove(self.children, index)
end

function pdlibs.behavior.Composite:addChildFront(child)
    self:addChild(child, 1)
end

function pdlibs.behavior.Composite:addChildBack(child)
    self:addChild(child, #self.children+1)
end

function pdlibs.behavior.Composite:removeChildFront()
    return self:removeChild(1)
end

function pdlibs.behavior.Composite:removeChildBack()
    return self:removeChild(#self.children)
end


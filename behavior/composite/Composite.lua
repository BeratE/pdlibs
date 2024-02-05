import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

-- Compositie node containing many children.
class('Composite', {}, mylib.behavior).extends(mylib.behavior.Behavior)

function mylib.behavior.Composite:init(children)
    mylib.behavior.Composite.super.init(self)
    self:setChildren(children)
end

function mylib.behavior.Composite:setChildren(children)
    assert(children and type(children) == "table", "Composite behavior requires a table of children objects")
    self.children = {}
    for _, child in pairs(children) do
        self:addChildBack(child)
    end
end

function mylib.behavior.Composite:getChild(index)
    return self.children[index]
end

function mylib.behavior.Composite:addChild(child, index)
    assert(child:isa(mylib.behavior.Behavior), "Invalid child object passed to Composite behavior")
    child:setParent(self)
    table.insert(self.children, index, child)
end

function mylib.behavior.Compositie:removeChild(index)
    return table.remove(self.children, index)
end

function mylib.behavior.Composite:addChildFront(child)
    self:addChild(child, 1)
end

function mylib.behavior.Composite:addChildBack(child)
    self:addChild(child, #self.children+1)
end

function mylib.behavior.Composite:removeChildFront()
    return self:removeChild(1)
end

function mylib.behavior.Composite:removeChildBack()
    return self:removeChild(#self.children)
end


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
    self.nChildren = 0
    for _, child in pairs(children) do
        assert(child:isa(mylib.behavior.Behavior), "Invalid child object passed to Composite behavior")
        child.parent = self
        self.nChildren += 1
    end
    self.children = children
end
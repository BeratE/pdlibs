import "CoreLibs/object"

import "pdlibs/behavior/Behavior"

-- Compositie node containing many children.
class('Composite', {}, mylib.behavior).extends(mylib.behavior.Behavior)

function mylib.behavior.Composite:init(children)
    mylib.behavior.Composite.super.init(self)
    self.children = children
    assert(self.children and type(self.children) == "table", "Invalid children object passed to behavior Composite")
    self.nChildren = 0
    for _, child in pairs(self.children) do
        self.nChildren += 1
        assert(child and child:isa(mylib.behavior.Behavior), "Invalid child object passed to behavior Composite")
    end
end
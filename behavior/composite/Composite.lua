import "CoreLibs/object"

import "libs/behavior/Behavior"

-- Compositie node containing many children
class('Composite', {}, mylib.behaviour).extends(mylib.behaviour.Behavior)

function mylib.behaviour.Composite:init(children)
    mylib.behaviour.Composite.super.init(self)
    self.children = children
    assert(self.children and type(self.children) == "table", "Invalid children object passed to behavior Composite")
    self.nChildren = 0
    for _, child in pairs(self.children) do
        self.nChildren += 1
        assert(child and child:isa(mylib.behaviour.Behavior), "Invalid child object passed to behavior Composite")
    end
end
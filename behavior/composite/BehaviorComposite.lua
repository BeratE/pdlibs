import "CoreLibs/object"

import "libs/behavior/Behavior"

-- Compositie node containing many children
class('BehaviorComposite').extends(Behavior)

function BehaviorComposite:init(children)
    BehaviorComposite.super.init(self)
    self.children = children
    assert(self.children and type(self.children) == "table", "Invalid children object passed to BehaviorComposite")
    self.nChildren = 0
    for _, child in pairs(self.children) do
        self.nChildren += 1
        assert(child and child:isa(Behavior), "Invalid child object passed to BehaviorComposite")
    end
end
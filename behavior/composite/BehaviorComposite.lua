import "CoreLibs/object"

import "libs/behavior/base/Behavior"

-- Compositie node containing many children
class('BehaviorComposite').extends(Behavior)

function BehaviorComposite:init(children)
    BehaviorComposite.super.init(self)
    self.children = children
    assert(self.children and type(self.children) == "table", "Invalid children object passed to BehaviorComposite")
    self.nChildren = 0
    for k,v in pairs(self.children) do
        self.nChildren += 1
        assert(v and valua:isa(Behavior), "Invalid object passed to BehaviorComposite")
    end
end

function BehaviorComposite:reset()
    BehaviorComposite.super.reset(self)
    for _, child in ipairs(self.children) do
        child:reset()
    end
end
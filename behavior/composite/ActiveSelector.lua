import "CoreLibs/object"

import "pdlibs/behavior/composite/Selector"

--[[ An active selector aborts a currently running child with low priority
 in favor of a child with higher priority. Children are prioritized in descending order. --]]
class('ActiveSelector', {}, mylib.behavior).extends(mylib.behavior.Selector)

function mylib.behavior.ActiveSelector:init(children)
    mylib.behavior.ActiveSelector.super.init(self, children)
end

function mylib.behavior.ActiveSelector:onActivate()
    mylib.behavior.ActiveSelector.super.onActivate(self)
    self.prevChildIdx = 0
end

function mylib.behavior.ActiveSelector:onUpdate()
    self.currChildIdx = 1
    local status = mylib.behavior.ActiveSelector.super.onUpdate(self)
    if (self.prevChildIdx > self.currChildIdx) then
        self.children[self.prevChildIdx]:abort()
    end
    self.prevChildIdx = self.currChildIdx
    return status
end
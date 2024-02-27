import "CoreLibs/object"

import "pdlibs/behavior/composite/Selector"

--[[ An active selector aborts a currently running child with low priority
 in favor of a child with higher priority. Children are prioritized in descending order. --]]
class('ActiveSelector', {}, pdlibs.behavior).extends(pdlibs.behavior.Selector)

function pdlibs.behavior.ActiveSelector:init(children)
    pdlibs.behavior.ActiveSelector.super.init(self, children)
end

function pdlibs.behavior.ActiveSelector:onActivate()
    pdlibs.behavior.ActiveSelector.super.onActivate(self)
    self.prevChildIdx = 0
end

function pdlibs.behavior.ActiveSelector:onUpdate()
    self.currChildIdx = 1
    local status = pdlibs.behavior.ActiveSelector.super.onUpdate(self)
    if (self.prevChildIdx > self.currChildIdx) then
        self.children[self.prevChildIdx]:abort()
    end
    self.prevChildIdx = self.currChildIdx
    return status
end
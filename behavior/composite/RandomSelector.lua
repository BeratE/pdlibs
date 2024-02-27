import "CoreLibs/object"

import "pdlibs/behavior/composite/Selector"
import "pdlibs/util/string"

-- Create random string for probability function to avoid name collission
local getP <const> = "_RSgetP_" .. pdlibs.string.random(6)

--[[ Accepts array of {p, c}, where child c is selected with probability p in [0,1]. 
 Parameter p can either be a number or a function. ]]
class('RandomSelector', {}, pdlibs.behavior).extends(pdlibs.behavior.Selector)

function pdlibs.behavior.RandomSelector:init(children)
    pdlibs.behavior.RandomSelector.super.init(self, children)
end

function pdlibs.behavior.RandomSelector:onActivate()
    pdlibs.behavior.RandomSelector.super.onActivate(self)
    self.currChildIdx = self:_getNextChildIdx()
end

-- Overwrite behavior to unpack children
function pdlibs.behavior.RandomSelector:addChild(child, index)
    assert(type(child) == "table" and #child == 2,
        "Invalid child object passed to RandomSelector behavior")
    assert(type(child[1]) == "number" or type(child[1]) == "function",
        "Expecting number or function as child probability RandomSelector behavior")

    local p, c = table.unpack(child)
    c[getP] = p
    if (type(p) ~= "function") then
        c[getP] = function () return p end
    end

    pdlibs.behavior.RandomSelector.super.addChild(self, c, index)
end

function pdlibs.behavior.RandomSelector:_getNextChildIdx()
    local r = math.random(1000)/1000
    local pSum = 0
    for i, child in ipairs(self.children) do
        pSum += child[getP]()
        if (r <= pSum) then
            return i
        end
    end
    return #self.children + 1
end
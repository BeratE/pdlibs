import "CoreLibs/object"

import "pdlibs/struct/Queue"

-- A BoundedQueue stores a maximum number of bound elements
class('BoundedQueue', {}, pdlibs.struct).extends(pdlibs.struct.Queue)

function pdlibs.struct.BoundedQueue:init(bound, list)
    pdlibs.struct.BoundedQueue.super.init(self, list)
    self.bound = bound
end

-- Push item to back of queue and pop last item if bound is reached
function pdlibs.struct.BoundedQueue:push(item)
    pdlibs.struct.BoundedQueue.super.push(self, item)
    return self:boundCheck()
end

function pdlibs.struct.BoundedQueue:boundCheck()
    if (self.bound and self:size() > self.bound) then
        return self:pop()
    end
end
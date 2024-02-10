import "CoreLibs/object"

import "pdlibs/struct/Queue"

-- A BoundedQueue stores a maximum number of bound elements
class('BoundedQueue', {}, mylib.struct).extends(mylib.struct.Queue)

function mylib.struct.BoundedQueue:init(bound, list)
    mylib.struct.BoundedQueue.super.init(self, list)
    self.bound = bound
end

-- Push item to back of queue and pop last item if bound is reached
function mylib.struct.BoundedQueue:push(item)
    mylib.struct.BoundedQueue.super.push(self, item)
    return self:boundCheck()
end

function mylib.struct.BoundedQueue:boundCheck()
    if (self.bound and self:size() > self.bound) then
        return self:pop()
    end
end
import "CoreLibs/object"

import "pdlibs/struct/Queue"

-- A BoundedQueue stores a maximum number of bound elements
class('BoundedQueue', {}, mylib.struct).extends(mylib.struct.Queue)

function mylib.struct.BoundedQueue:init(bound)
    mylib.struct.BoundedQueue.super.init(self)
    self.bound = bound
end

-- Push item to back of queue and pop last item if bound is reached
function mylib.struct.BoundedQueue:push(item)
    if (self:size() >= self.bound) then
        self:pop()
    end
    mylib.struct.BoundedQueue.super.push(self, item)
end
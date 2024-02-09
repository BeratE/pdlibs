import "CoreLibs/object"

import "pdlibs/struct/Queue"

-- A BoundedQueue stores a maximum number of bound elements
class('BoundedQueue', {}, mylib.struct).extends(mylib.struct.Queue)

function mylib.struct.BoundedQueue:init(bound, list)
    mylib.struct.BoundedQueue.super.init(self, list)
    -- Init bound
    self.bound = bound
    self.boundCheck = function() end
    if (bound ~= nil) then
        self.boundCheck = function ()
            if (self:size() >= self.bound) then
                self:pop()
            end
        end
    end
end

-- Push item to back of queue and pop last item if bound is reached
function mylib.struct.BoundedQueue:push(item)
    self:boundCheck()
    mylib.struct.BoundedQueue.super.push(self, item)
end
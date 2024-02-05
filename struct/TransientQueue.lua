import "CoreLibs/object"

import "pdlibs/struct/Queue"

-- A TransientQueue is a queue that stores its elements for the given number of frames.
class('TransientQueue', {}, mylib.struct).extends(mylib.struct.Queue)

function mylib.struct.TransientQueue:init(numBufferTicks)
    mylib.struct.TransientQueue.super.init(self)
    self.NUM_BUFFER_TICKS = numBufferTicks or 15
    self.nTicks = 0
end

-- Update the framebuffer and remove deprecate elements.
function mylib.struct.TransientQueue:tick()
    local item = self:peek()
    if item then
        if (item[2] + self.NUM_BUFFER_TICKS <= self.nTicks)  then
            self:pop()
        end
    end
    self.nTicks += 1
end

-- Push item with current frame number as timestamp, items are stored as {item, framenumber}.
function mylib.struct.TransientQueue:push(item)
    mylib.struct.TransientQueue.super.push(self, {item, self.nTicks})
end

-- Return item at index as string, note that indexing starts at self.first.
function mylib.struct.TransientQueue:getItemAtIndex(index)
    return self.out[index][1]
end
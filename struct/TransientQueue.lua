import "CoreLibs/object"

import "pdlibs/struct/Queue"

-- A TransientQueue is a queue that stores its elements for the given number of frames.
class('TransientQueue', {}, pdlibs.struct).extends(pdlibs.struct.Queue)

function pdlibs.struct.TransientQueue:init(numBufferTicks)
    pdlibs.struct.TransientQueue.super.init(self)
    self.NUM_BUFFER_TICKS = numBufferTicks or 15
    self.nTicks = 0
end

-- Update the framebuffer and remove deprecate elements.
function pdlibs.struct.TransientQueue:tick()
    local item = pdlibs.struct.TransientQueue.super.peek(self)
    if item then
        if (item[2] + self.NUM_BUFFER_TICKS <= self.nTicks)  then
            self:pop()
        end
    end
    self.nTicks += 1
end

-- Push item with current frame number as timestamp, items are stored as {item, framenumber}.
function pdlibs.struct.TransientQueue:push(item)
    pdlibs.struct.TransientQueue.super.push(self, {item, self.nTicks})
end

function pdlibs.struct.TransientQueue:peek()
    local item = pdlibs.struct.TransientQueue.super.peek(self)
    if (item) then return item[1] end
end

-- Helper functions

-- Return item at index as string, note that indexing starts at self.first.
function pdlibs.struct.TransientQueue:_getItemAtRawIndex(index)
    local item = pdlibs.struct.TransientQueue.super._getItemAtRawIndex(self, index)
    if (item) then return item[1] end
end
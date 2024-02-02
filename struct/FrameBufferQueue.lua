import "CoreLibs/object"

import "pdlibs/struct/Queue"

-- A FrameBufferQueue is a queue that stores its elements for the given number of frames.
class('FrameBufferQueue', {}, mylib.struct).extends(mylib.struct.Queue)

function mylib.struct.FrameBufferQueue:init(numBufferFrames)
    mylib.struct.FrameBufferQueue.super.init(self)
    self.numBufferFrames = numBufferFrames or 15
    self.currFrame = 0
end

-- Update the framebuffer and remove deprecate elements.
function mylib.struct.FrameBufferQueue:update()
    local item = self:peek()
    if item then
        if (item[2] + self.numBufferFrames <= self.currFrame)  then
            self:pop()
        end
    end
    self.currFrame += 1
end

-- Push item with current frame number as timestamp, items are stored as {item, framenumber}.
function mylib.struct.FrameBufferQueue:push(item)
    mylib.struct.FrameBufferQueue.super.push(self, {item, self.currFrame})
end

-- Return item at index as string, note that indexing starts at self.first.
function mylib.struct.FrameBufferQueue:getItemAtIndex(index)
    return self.out[index][1]
end
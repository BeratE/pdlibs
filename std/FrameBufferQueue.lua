import "CoreLibs/object"

import "libs/std/Queue"

class('FrameBufferQueue').extends(Queue)

function FrameBufferQueue:init(numBufferFrames)
    FrameBufferQueue.super.init(self)
    self.NUM_BUFFER_FRAMES = numBufferFrames or 15
    self.currFrame = 0
end

-- Update the framebuffer and remove deprecate elements
function FrameBufferQueue:update()
    local item = self:peek()
    if item then
        if (item[2] + self.NUM_BUFFER_FRAMES <= self.currFrame)  then
            self:pop()
        end
    end
    self.currFrame += 1
end

-- Push item with current frame number as timestamp
function FrameBufferQueue:push(item)
    FrameBufferQueue.super.push(self, {item, self.currFrame})
end

-- Override
function FrameBufferQueue:elementToString(index)
    return tostring(self.out[index][1])
end
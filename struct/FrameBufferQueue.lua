import "CoreLibs/object"

import "pdlibs/struct/Queue"

class('FrameBufferQueue', {}, mylib.struct).extends(mylib.struct.Queue)

function mylib.struct.FrameBufferQueue:init(numBufferFrames)
    mylib.struct.FrameBufferQueue.super.init(self)
    self.numBufferFrames = numBufferFrames or 15
    self.currFrame = 0
end

-- Update the framebuffer and remove deprecate elements
function mylib.struct.FrameBufferQueue:update()
    local item = self:peek()
    if item then
        if (item[2] + self.numBufferFrames <= self.currFrame)  then
            self:pop()
        end
    end
    self.currFrame += 1
end

-- Push item with current frame number as timestamp
function mylib.struct.FrameBufferQueue:push(item)
    mylib.struct.FrameBufferQueue.super.push(self, {item, self.currFrame})
end

-- Override
function mylib.struct.FrameBufferQueue:elementToString(index)
    return tostring(self.out[index][1])
end
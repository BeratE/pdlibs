import "CoreLibs/object"

import "pdlibs/struct/BoundedQueue"

mylib = mylib or {}
mylib.ngram = mylib.ngram or {}


class('Ngram', nil, mylib.ngram).extends()

function mylib.ngram.Ngram:init(N, eventSpace, sequenceBufferBound)
    assert(type(N) == "number" and N > 0, "N-Gram requires positive integer N")
    self.N = N
    self.windowSize = N-1
    -- Init Sequence Buffer
    self.sequenceBuffer = BoundedQueue(sequenceBufferBound)
    -- Init Event Space
    assert(type(eventSpace) == "table", "N-Gram requires table as event space")
    self.eventSpace = eventSpace
    self.spaceSize = {}
    self.spaceSize.event  = #eventSpace
    self.spaceSize.window = self.spaceSize.event ^ self.windowSize
    self.spaceSize.pattern = self.windowMatchSpaceSize * self.eventSpaceSize
end


-- P (event e is next) = P(matching pattern ending in e is next )
function mylib.ngram.Ngram:addEvent(event)
    
end
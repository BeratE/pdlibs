import "CoreLibs/object"

import "pdlibs/struct/BoundedQueue"

mylib = mylib or {}

--[[ General N-Gram implementation with Laplace-Smoothing.
 Sequences are stored as table list of events (from event space). --]]
class('Ngram', nil, mylib).extends()

function mylib.Ngram:init(order, eventSpace,
        --[[optional]] initSequence,  -- Initial input sequence
        --[[optional]] sequenceBound) -- Upper limit on stored sequence lenght
    self:_initOrder(order)
    self:_initEventSpace(eventSpace)
    self.model = {}
    self:_initModel(order, self.model)
    self.sequence = mylib.struct.BoundedQueue(sequenceBound)
    self:pushSequence(initSequence or {})
end

-- Add an event to the sequence
function mylib.Ngram:pushEvent(event)
    if (self.model[event]) then
        -- Check for patterns
        if (self.sequence:size() >= self.windowSize) then
            local m = self.model
            for _, w in ipairs(self:window()) do
                m = m[w]
            end
            m[event]._count += 1
        end
        -- Update Unigram
        self.model[event]._count += 1
        local e = self.sequence:push(event)
        if e then self.model[e]._count -= 1 end
    end
end

-- Add a sequence of the events
function mylib.Ngram:pushSequence(sequence)
    if (type(sequence) == "string") then
        for i = 1, #sequence do
            self:pushEvent(sequence:sub(i,i))
        end
    elseif (type(sequence) == "table") then
        for _, e in ipairs(sequence) do
            self:pushEvent(e)
        end
    end
end

-- Returns the probability of event occurring in the future
function mylib.Ngram:pEvent(event)
    if (not self.model[event]) then
        return 0 -- event not in eventspace has zero probability
    end
    local nEventInWindow = self:_countEventInWindow(event, 1)
    local nEventPattern = (self.model[event]._count - nEventInWindow + self.windowSpaceSize)
    return nEventPattern / self:_nAllPattern()
end

-- Returns the probability that event will occurr next in the sequence
function mylib.Ngram:pEventNext(event)
    
end

-- Returns the probability that pattern will occurr in the future
function mylib.Ngram:pPattern(pattern)
    local p = 1
    
    return p / nAllPattern
end

-- Returns the probability that pattern will occurr next in the sequence
function mylib.Ngram:pPatternNext(pattern)
    
end

-- Retrieve window from the sequencebuffer in [i, j]
function mylib.Ngram:window(i, j)
    i = i or self.sequence:size() - self.windowSize + 1
    j = j or i + self.windowSize - 1
    return self.sequence:sub(i, j)
end

--[[ Returns unigram table containing the occurrences for each event 
 and total occurrences --]]
function mylib.Ngram:getUnigram()
    local t = {}
    local n = 0
    for _, e in ipairs(self.eventSpace) do
        t[e] = self.model[e]._count
        n += t[e]
    end
    return t, n
end

-- Helper functions

function mylib.Ngram:_countEventInWindow(event, i, j)
    local n = 0
    local window = self:window(i, j)
    for _, e in ipairs(window) do
        if e == event then n += 1 end
    end
    return n
end

function mylib.Ngram:_nAllPattern()
    -- (Sum of all pattern occurrences so far) + (1 * E^N [Laplace-Smoothing])
    return ((self.sequence:size() - self.windowSize) + self.patternSpaceSize)
end


function mylib.Ngram:_initOrder(order)
    assert(type(order) == "number" and order > 0, "N-Gram requires positive integer order")
    self.order = order
    self.windowSize = order-1
end

function mylib.Ngram:_initEventSpace(eventSpace)
    if (type(eventSpace) == "string") then
        self.eventSpace = {}
        for i = 1, #eventSpace do
            local c = eventSpace:sub(i,i)
            self.eventSpace[i] = c
        end
    else 
        assert(type(eventSpace) == "table", "N-Gram recieved invalid event space")
        self.eventSpace = eventSpace
    end
    self.eventSpaceSize  = #eventSpace
    self.windowSpaceSize = self.eventSpaceSize ^ self.windowSize
    self.patternSpaceSize = self.windowSpaceSize * self.eventSpaceSize
end

function mylib.Ngram:_initModel(N, model)
    if (N <= 0) then return end
    for _, event in ipairs(self.eventSpace) do
        model[event] = { }
        if (N == self.order or N == 1) then
            model[event]._count = 0
        end
        self:_initModel(N-1, model[event])
    end
end
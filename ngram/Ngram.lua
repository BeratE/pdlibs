import "CoreLibs/object"

import "pdlibs/struct/BoundedQueue"
import "pdlibs/util/string"

mylib = mylib or {}

local next = next -- constant time indexing to next primitive

--[[ General N-Gram implementation with Laplace-Smoothing.
 Sequences and patterns are stored as arrays of events (from event space). ]]
class('Ngram', nil, mylib).extends()

function mylib.Ngram:init(order, eventSpace,
        --[[optional]] sequenceBound, -- Upper limit on stored sequence lenght (default order * 100) for now
        --[[optional]] initSequence)  -- Initial input sequence
    -- Init Order
    assert(type(order) == "number" and order > 0, "N-Gram requires positive integer order")
    assert((sequenceBound == nil) or (sequenceBound > order), "N-Gram recieved invalid sequence bound")
    assert(type(eventSpace) == "table" or type(eventSpace) == "string", "N-Gram recieved invalid event space")
    self.order = order
    -- Initialize Event Space and compute space sizes |E|^i, with i in [1, N]
    if (type(eventSpace) == "string") then
        eventSpace = mylib.string.toArray(eventSpace)
    end
    -- Deep copy event space
    self.eventSpace = {}
    for _, v in pairs(eventSpace) do
        table.insert(self.eventSpace, v)
    end
    self.spaceSize = { #self.eventSpace }
    for i = 2, self.order do
        self.spaceSize[i] = self.spaceSize[i-1] * self.spaceSize[1]
    end
    self.windowSpaceSize = self.spaceSize[self.order-1] or 0
    -- Construct Model
    self.model = {}
    local buildModelRec
    buildModelRec = function (N, model)
        if (N <= 0) then return end
        for _, event in ipairs(self.eventSpace) do
            model[event] = {}
            if (N == 1 or N == self.order) then
                model[event]._count = 0
            end
            buildModelRec(N-1, model[event])
        end
    end
    buildModelRec(self.order, self.model)
    -- Initialize sequence
    self.sequenceBound = sequenceBound or self.order * 100
    self.sequence = mylib.struct.BoundedQueue(self.sequenceBound)
    self:pushSequence(initSequence or {})
end

--[[ Add a sequence of events to the sequence. ]]
function mylib.Ngram:pushSequence(sequence)
    if (type(sequence) == "string") then
        return self:pushSequence(mylib.string.toArray(sequence))
    end
    for _, e in ipairs(sequence) do
        self:pushEvent(e)
    end
end

--[[ Add an event to the sequence memory. ]]
function mylib.Ngram:pushEvent(event)
    if (self.model[event]) then
        -- Update unigram and patterns
        self.model[event]._count += 1
        if (self:getSequenceLength() >= (self.order - 1)) then
            self:modelByIt(self:windowIt())[event]._count += 1
        end
        -- Update sequence and reduce counts of popped event
        local poppedEvent = self.sequence:push(event)
        if poppedEvent then
            self.model[poppedEvent]._count -= 1
            local m = self.model[poppedEvent]
            local it = self:sequenceIt()
            for i = 1, self.order-1 do m = m[it()] end
            m._count -= 1
        end
    end
end

-- [[ Probability ]]

--[[ Returns the probability that event will occurr next in the sequence. ]]
function mylib.Ngram:pEventNext(event)
    if (self.model[event] and self:getSequenceLength() >= (self.order - 1)) then
        local m, sum = self:modelByIt(self:windowIt()), 0
        for _, e in ipairs(self.eventSpace) do
            sum += m[e]._count
        end
        return (m[event]._count + 1) / (sum + self.spaceSize[1])
    end
    return self:pEvent(event)
end

--[[ Returns the probability of event occurring in the future. ]]
function mylib.Ngram:pEvent(event)
    if (self.model[event]) then
        local cnt = self.model[event]._count
        -- Remove number of occurrences of event in first window
        local it = self:sequenceIt()
        for i = 1, self.order - 1 do
            if (it() == event) then cnt -= 1 end
        end
        return (cnt + self.windowSpaceSize) / self:sumAllPatternOccurr()
    end
    return 0
end

--[[ Returns the probability that pattern will occurr in the future.
 Accepts any pattern up to length order. ]]
 function mylib.Ngram:pPattern(pattern)
    local N = #pattern
    if (N <= self.order) then
        local m = self:modelByPattern(pattern)
        return (m._count + 1) / self:sumAllPatternOccurr(N)
    end
    return 0
end

-- [[ Distribution ]]

--[[ Returns the probability mass function (pmf) 
 of the given events (default all) as pairs of event/probability. ]]
function mylib.Ngram:pmf(events)
    events = events or self.eventSpace
    local pmf = {}
    for _, e in ipairs(events) do
        pmf[e] = self:pEventNext(e)
    end
    return pmf
end

--[[ Returns the discrete integral of their probability mass function (pmf) 
 of the given events (default all) as key/value pairs and total sum. ]]
function mylib.Ngram:pmfSum(events)
    events = events or self.eventSpace
    local dist, sum = {}, 0
    for _, event in ipairs(events) do
        sum += self:pEventNext(event)
        dist[event] = sum
    end
    return dist, sum
end

-- [[ Iterators ]]

--[[ Iterate (event, proability) over given events (default eventspace),
 use: "for e, p in pmfIt() do .. end". ]]
function mylib.Ngram:pmfIt(events)
    events = events or self.eventSpace
    local i = 0
    return function ()
        i += 1
        local e = events[i]
        return e, self:pEventNext(e)
    end
end

--[[ Iterator (event, sum of proability) over given events (default eventspace),
 use like "for e, s in pmfSumIt() do .. end". ]]
function mylib.Ngram:pmfSumIt(events)
    events = events or self.eventSpace
    local s, i = 0, 0
    return function ()
        i += 1
        local e = events[i]
        s += self:pEventNext(e)
        return e, s
    end
end

--[[ Returns an iterator to the sequence starting at given index (default 1). ]]
function mylib.Ngram:sequenceIt(startIndex)
    -- Store variables in local closure for faster access
    local seq = self.sequence
    local j = seq:_toRawIndex(startIndex or 1) - 1
    local seqIdx = self.sequence._getItemAtRawIndex
    local it = function ()
        j = j + 1
        return seqIdx(seq, j)
    end
    return it, seqIdx(seq, startIndex), nil
end

--[[ Returns an iterator to the window, i.e. last (order-1) events of the sequence. ]]
function mylib.Ngram:windowIt()
    local wp = self:getSequenceLength() - self.order + 2
    return self:sequenceIt(wp)
end

-- [[ Retrieval ]]

--[[ Returns unigram table (event, occurrences) and total number of occurrences.
 Also called a frequency distribution. 
 Divide by total number of occurrences to obtain relative frequency]]
function mylib.Ngram:unigram()
    local t, n = {}, 0
    for _, e in ipairs(self.eventSpace) do
        t[e] = self.model[e]._count
        n += t[e]
    end
    return t, n
end

--[[ Return the last event that was pushed to the sequence. ]]
function mylib.Ngram:getLastEvent()
    return self.sequence.out[self.sequence:_toRawIndex(self:getSequenceLength())]
end

--[[ Retrieve subtree of model by following the given pattern. ]]
function mylib.Ngram:modelByPattern(pattern)
    if (type(pattern) == "string") then
        return self:modelByPattern(mylib.string.toArray(pattern))
    end
    local m = self.model
    for _, w in ipairs(pattern or {}) do m = m[w] end
    return m
end

--[[ Retrieve subtree of model by following the given iterator (until nil). ]]
function mylib.Ngram:modelByIt(it)
    local m, e = self.model, it()
    while e do m, e = m[e], it() end
    return m
end

--[[ Returns sum of all occurrences of pattern of length N (default order). ]]
function mylib.Ngram:sumAllPatternOccurr(N)
    N = N or self.order
    return ((self:getSequenceLength() - (N-1)) + self.spaceSize[N])
end

--[[ Return the number of events currently stored in the memory sequence. ]]
function mylib.Ngram:getSequenceLength()
    return self.sequence:size()
end

function mylib.Ngram:getWindowSize()
    return self.order - 1
end

function mylib.Ngram:isReady()
    return self:getSequenceLength() >= self:getWindowSize()
end

--[[ (Static) Return the count offset occurrences of given event in given pattern. ]]
function mylib.Ngram.countEventInPattern(event, pattern)
    local n = 0
    for _, e in ipairs(pattern) do
        if e == event then n += 1 end
    end
    return n
end
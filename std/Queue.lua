import "CoreLibs/object"

-- Basic queue data structure
class('Queue').extends()

function Queue:init()
    Queue.super.init(self)
    self:reset()
end

function Queue:reset()
    self.first = 1
    self.last = 0
    self.out = {}
end

-- Push item to back of queue
function Queue:push(item)
    self.last = self.last + 1
    self.out[self.last] = item
end

-- Pop item from the front of the queue
function Queue:pop()
    if (self.first <= self.last) then
        local value = self.out[self.first]
        self.out[self.first] = nil
        self.first = self.first + 1
        return value
    else
        self:reset()
    end
end

-- Peek item from the front of the queue without popping
function Queue:peek()
    if (self.first <= self.last) then
        return self.out[self.first]
    else
        self:reset()
    end
end

-- Return the number of elements currently in the queue
function Queue:size()
    return self.last - self.first + 1
end

-- Return iterator function to the queue
function Queue:iterator()
    return function ()
        return self:pop()
    end
end

-- Pop queue until its empty
function Queue:clear()
    while(self:pop()) do
    end
    self:reset()
end

-- Transform contents of the queue into a string
function Queue:toString()
    txt = ""
    for i = self.first, self.last, 1 do
        txt = txt .. self:elementToString(i) .. " "
    end
    return txt
end

function Queue:elementToString(index)
    return tostring(self.out[index])
end


-- Remove items from startIndex to endIndex (including) from the queue
function Queue:remove(startIndex, endIndex)
    -- print("Queue: (" .. self:toString() .. ") remove [" .. startIndex .. ", " .. endIndex .. "]")
    local size = self:size()
    if (endIndex <= size) then
        for i = 1, startIndex-1 do
            Queue.push(self, Queue.pop(self))
        end
        for i = startIndex, endIndex do
            Queue.pop(self)
        end
        for i = endIndex +1, size do
            Queue.push(self, Queue.pop(self))
        end
    end
end

function Queue:isFirstItem(item)
    return self:peek() == item
end
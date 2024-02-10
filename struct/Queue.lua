import "CoreLibs/object"

-- Basic queue data structure.
mylib = mylib or {}
mylib.struct = mylib.struct or {}
class('Queue', {}, mylib.struct).extends()

function mylib.struct.Queue:init(list)
    mylib.struct.Queue.super.init(self)
    self:set(list)
end

--[[ Initialize the queue from a given list.
 NOTE: the list must be consecutively integer indexed.]]
function mylib.struct.Queue:set(list)
    self.out = list or {}
    self.last = #self.out
    self.first = 1
end

-- Push item to back of queue.
function mylib.struct.Queue:push(item)
    self.last = self.last + 1
    self.out[self.last] = item
end

-- Pop item from the front of the queue.
function mylib.struct.Queue:pop()
    if (self.first <= self.last) then
        local value = self.out[self.first]
        self.out[self.first] = nil
        self.first = self.first + 1
        return value
    end
    self:set()
end

-- Peek item from the front of the queue without popping.
function mylib.struct.Queue:peek()
    if (self.first <= self.last) then
        return self.out[self.first]
    end
    self:set()
end

-- Remove items from startIndex to endIndex (including) from the queue.
function mylib.struct.Queue:remove(startIndex, endIndex)
    -- print("Queue: (" .. self:toString() .. ") remove [" .. startIndex .. ", " .. endIndex .. "]")
    local size = self:size()
    if (endIndex <= size) then
        for i = 1, startIndex-1 do
            mylib.struct.Queue.push(self, mylib.struct.Queue.pop(self))
        end
        for i = startIndex, endIndex do
            mylib.struct.Queue.pop(self)
        end
        for i = endIndex +1, size do
            mylib.struct.Queue.push(self, mylib.struct.Queue.pop(self))
        end
    end
end

function mylib.struct.Queue:sub(startIndex, endIndex)
    startIndex = self:_toRawIndex(startIndex or 1)
    endIndex   = self:_toRawIndex(endIndex or self:size())
    local t = {}
    for i = startIndex, endIndex do
        table.insert(t, self:_getItemAtRawIndex(i))
    end
    return t
end

-- Return the number of elements currently in the queue.
function mylib.struct.Queue:size()
    return self.last - self.first + 1
end

-- Return iterator function to the queue.
function mylib.struct.Queue:iterator()
    return function ()
        return self:pop()
    end
end

-- Pop queue until its empty.
function mylib.struct.Queue:clear()
    while(self:pop()) do end
    self:set()
end

-- Transform contents of the queue into a string.
function mylib.struct.Queue:toString()
    txt = ""
    for i = self.first, self.last do
        txt = txt .. tostring(self:_getItemAtRawIndex(i)) .. " "
    end
    return txt
end

-- Transform the queue into a basic list table
function mylib.struct.Queue:toList()
    list = {}
    for i = self.first, self.last do
        table.insert(list, self:_getItemAtRawIndex(i))
    end
    return i
end

-- Helper functions

function mylib.struct.Queue:_getItemAtRawIndex(index)
    return self.out[index]
end

function mylib.struct.Queue:_toRawIndex(index)
    return index + self.first - 1
end
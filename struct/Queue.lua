import "CoreLibs/object"

-- Basic queue data structure.
mylib = mylib or {}
mylib.struct = mylib.struct or {}
class('Queue', {}, mylib.struct).extends()

function mylib.struct.Queue:init(list)
    mylib.struct.Queue.super.init(self)
    self:reset()
    if (list) then
        self:fromList(list)
    end
end

-- Initialize the queue from a given list
function mylib.struct.Queue:fromList(list)
    self.out = list
    self.first = 1
    self.last = #list
end

function mylib.struct.Queue:reset()
    self.first = 1
    self.last = 0
    self.out = {}
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
    else
        self:reset()
    end
end

-- Peek item from the front of the queue without popping.
function mylib.struct.Queue:peek()
    if (self.first <= self.last) then
        return self.out[self.first]
    else
        self:reset()
    end
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
    while(self:pop()) do
    end
    self:reset()
end

-- Transform contents of the queue into a string.
function mylib.struct.Queue:toString()
    txt = ""
    for i = self.first, self.last, 1 do
        txt = txt .. self:itemToString(i) .. " "
    end
    return txt
end

-- Return item at index as string, note that indexing starts at self.first.
function mylib.struct.Queue:itemToString(index)
    return tostring(self:getItemAtRawIndex(index))
end

-- Check if given item is at the front.
function mylib.struct.Queue:isFirstItem(item)
    return self:peek() == item
end

-- Return a reference to a random element in the queue.
function mylib.struct.Queue:getRandomItem()
    if (self.first <= self.last) then
        return self:getItemAtRawIndex(math.random(self.first, self.last))
    end
end

-- Get the item at index, note that indexing starts at self.first.
function mylib.struct.Queue:getItemAtRawIndex(index)
    return self.out[index]
end

-- Transform the queue into a basic list table
function mylib.struct.Queue:toList()
    list = {}
    for i = self.first, self.last do
        table.insert(list, self:getItemAtRawIndex(i))
    end
    return i
end
import "CoreLibs/object"

-- Double Linked-List data structure.
mylib = mylib or {}
mylib.struct = mylib.struct or {}
class("LinkedList", {}, mylib.struct).extends()
class("LinkedListNode", {next = nil, prev = nil, value = nil}, mylib.struct).extends()

function mylib.struct.LinkedListNode:init(value, prev, next)
    self.value = value
    self.prev = prev
    self.next = next
end

-- Delete a node, connect prev and next in the list.
function mylib.struct.LinkedListNode:delete()
    -- Remove reference to prev
    if (self.prev ~= nil) then
        self.prev.next = self.next
        if (self.next ~= nil) then
            self.next.prev = self.prev
        end
        self.prev = nil
    end
    -- Remove reference to next
    if (self.next ~= nil) then
        self.next.prev = self.prev
        if (self.prev ~= nil) then
            self.prev.next = self.next
        end
        self.next = nil
    end
    -- Remove reference to value
    self.value = nil
end


function mylib.struct.LinkedList:init(items)
    self.front = nil
    self.back = nil
    if (items) then
        if type(items) == "table" then
            local prevItem = nil
            local item = nil
            for _, v in ipairs(items) do
                prevItem = item
                item = LinkedListNode(v)
                if (self.first == nil) then
                    self.first = item
                end
                if (prevItem ~= nil) then
                    prevItem.next = item
                    item.prev = prevItem
                end
            end
            self.last = item
        else
            self:addFront(items)
        end
    end
end

-- Insertion

-- Add item to the back of the list.
function mylib.struct.LinkedList:addBack(item)
    if (self.last ~= nil) then
        self.last.next = mylib.struct.LinkedListNode(item, self.last, nil)
        self.last = self.last.next
    else
        self.first = mylib.struct.LinkedListNode(item)
        self.last = self.first
    end
end

-- Add item to the front of the list.
function mylib.struct.LinkedList:addFront(item)
    if (self.first ~= nil) then
        self.first.prev = mylib.struct.LinkedListNode(item, nil, self.first)
        self.last = self.last.next
    else
        self.first = mylib.struct.LinkedListNode(item)
        self.last = self.first
    end
end

-- Removal

-- Remove item from the back of the list.
function mylib.struct.LinkedList:removeBack()
    if (self.last ~= nil) then
        if (self.last.prev ~= nil) then
            self.last = self.last.prev
            self.last.next:delete()
            self.last.next = nil
        else
            self.last = nil
            self.first = nil
        end
    end
end

-- Remove item from the front of the list.
function mylib.struct.LinkedList:removeFront()
    if (self.first ~= nil) then
        if (self.first.next ~= nil) then
            self.first = self.first.next
            self.first.prev = nil
        else
            self.last = nil
            self.first = nil
        end
    end
end

-- Remove the given item from the list.
function mylib.struct.LinkedList:remove(item)
    local currItem = self.front
    while (currItem ~= nil) do
        if (currItem.value == item) then
            if (currItem == self.front) then
                self.front = self.front.next
            end
            if (currItem == self.back) then
                self.back = self.back.prev
            end
            currItem:delete()
        end
    end
end

-- Clear the whole list.
function mylib.struct.LinkedList:clear()
    local item = self.first
    while item do
        local tmp = item
        item:delete()
        item = tmp.next
    end
end

-- Retrieval

-- Return an iterator the the list.
function mylib.struct.LinkedList:iterator()
    local currItem = self.first
    return function ()
        if (currItem) then
            local val = currItem.value
            currItem = currItem.next
            return val
        end
        return nil
    end
end

-- Get an item at a specified index.
function mylib.struct.LinkedList:get(index)
    local iter = self:iterator()
    local elem = nil
    for _ = 1, index do
        elem = iter()
    end
    return elem
end
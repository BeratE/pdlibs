import "CoreLibs/object"

-- Very basic double ended linked list data structure
mylib = mylib or {}
mylib.struct = mylib.struct or {}
class("LinkedList", {}, mylib.struct).extends()
class("LinkedListNode", {next = nil, prev = nil, value = nil}, mylib.struct).extends()

function mylib.struct.LinkedListNode:init(value, prev, next)
    self.value = value
    self.prev = prev
    self.next = next
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

function mylib.struct.LinkedList:addBack(item)
    if (self.last ~= nil) then
        self.last.next = LinkedListNode(item, self.last, nil)
        self.last = self.last.next
    else
        self.first = LinkedListNode(item)
        self.last = self.first
    end
end

function mylib.struct.LinkedList:addFront(item)
    if (self.first ~= nil) then
        self.first.prev = LinkedListNode(item, nil, self.first)
        self.last = self.last.next
    else
        self.first = LinkedListNode(item)
        self.last = self.first
    end
end

function mylib.struct.LinkedList:removeBack()
    if (self.last ~= nil) then
        if (self.last.prev ~= nil) then
            self.last = self.last.prev
            self.last.next = nil
        else
            self.last = nil
            self.first = nil
        end
    end
end

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
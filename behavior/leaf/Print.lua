import "CoreLibs/object"

import "pdlibs/behavior/Behavior"
import "pdlibs/util"

-- Dump the given object to console .. useful for debugging
class('Print', {}, mylib.behavior).extends(mylib.behavior.Behavior)

function mylib.behavior.Print:init(o)
    self.onUpdate = function ()
        if (type(o) == "function") then
            print(o())
        elseif (type(o) == "table") then
            print(mylib.dump(o))
        else
            print(o)
        end
        return mylib.behavior.Status.SUCCESS
    end
end
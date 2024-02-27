import "CoreLibs/object"

import "pdlibs/behavior/Behavior"
import "pdlibs/util/debug"

-- Dump the given object to console .. useful for debugging
class('Print', {}, pdlibs.behavior).extends(pdlibs.behavior.Behavior)

function pdlibs.behavior.Print:init(o)
    self.onUpdate = function ()
        if (type(o) == "function") then
            print(o())
        elseif (type(o) == "table") then
            print(pdlibs.dump(o))
        else
            print(o)
        end
        return pdlibs.behavior.Status.SUCCESS
    end
end
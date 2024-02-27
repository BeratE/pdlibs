import "CoreLibs/object"

import "pdlibs/util/var"
import "pdlibs/behavior/Behavior"

-- Check if variable is null
pdlibs.behavior.var = pdlibs.behavior.var or {}
class('IsNil', {}, pdlibs.behavior.var).extends(pdlibs.behavior.Behavior)

function pdlibs.behavior.var.IsNil:init(varName, namespace)
    pdlibs.behavior.var.IsNil.super.init(self)
    self.namespace = namespace
    self.varName = varName
end

function pdlibs.behavior.var.IsNil:onUpdate()
    return pdlibs.var.get(varName, self.namespace) ~= nil
end

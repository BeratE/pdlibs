import "CoreLibs/object"

import "pdlibs/util/var"
import "pdlibs/behavior/Behavior"

-- Set given variable to value
pdlibs.behavior.var = pdlibs.behavior.var or {}
class('Set', {}, pdlibs.behavior.var).extends(pdlibs.behavior.Behavior)

function pdlibs.behavior.var.Set:init(varName, value)
    pdlibs.behavior.var.Set.super.init(self)
    self.namespace = namespace
    self.varName = varName
    self.value = value
end

function pdlibs.behavior.var.Set:onUpdate()
    pdlibs.var.set(self.varName, self.value, self.namespace)
    return pdlibs.behavior.Status.SUCCESS
end
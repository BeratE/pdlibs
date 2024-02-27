-- Utility functions to put variables into an extra namespace 

import "pdlibs/util/string"

pdlibs = pdlibs or {}

pdlibs.var = pdlibs.var or {}              -- Default environment
pdlibs.var.ns = pdlibs.var.ns or {}        -- Namespace functions
setmetatable(pdlibs.var, {__index = _G})
pdlibs._varCurrEnv = pdlibs.var             -- Current variable environment

local defns <const> = "defns"
pdlibs.var[defns] = pdlibs.var[defns] or {}  -- Default namespace

-- [[ Variables ]]

-- Declare variable (in namespace) and return value
function pdlibs.var.let(name, initVal, namespace)
    assert(type(name) == "string", "Require string as variable name")
    local v = pdlibs.var.get(name, namespace) or (initVal or {})
    pdlibs.var.set(name, v, namespace)
    return pdlibs.var.get(name, namespace)
end

-- Get the variable with the name (in namespace)
function pdlibs.var.get(name, namespace)
    return pdlibs.var.ns.get(namespace)[name]
end

-- Set variable with name (in namespace) to value
function pdlibs.var.set(name, value, namespace)
    pdlibs.var.ns.get(namespace)[name] = value
end

-- [[ Environment ]]

-- Set current variable environment to global
function pdlibs.var.setEnvGlobal()
    pdlibs._varCurrEnv = _G
end

-- Set current variable environment to default
function pdlibs.var.setEnvDefault()
    pdlibs._varCurrEnv = pdlibs.var
end

-- [[ Management ]]

-- Get variable namespace or create new if not exists
function pdlibs.var.ns.get(namespace)
    namespace = namespace or defns
    if (pdlibs._varCurrEnv[namespace] == nil) then
        pdlibs._varCurrEnv[namespace] = {}
    end
    return pdlibs._varCurrEnv[namespace]
end

--[[ Generates a new namespace in the current enviroment, 
  returns namespace name, namespace --]]
function pdlibs.var.ns.generate()
    local ns = "ns" .. pdlibs.string.random(6)
    while (pdlibs._varCurrEnv[ns] ~= nil) do
        ns = "ns" .. pdlibs.string.random(6)
    end
    return ns, pdlibs.var.ns.get(ns)
end
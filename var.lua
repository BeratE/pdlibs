-- Utility functions to put variables into an extra namespace 

import "mylib/string"

mylib = mylib or {}

mylib.var = mylib.var or {}              -- Default environment
setmetatable(mylib.var, {__index = _G})
mylib.varCurrEnv = mylib.var             -- Current variable environment

local defns <const> = "defns"
mylib.var[defns] = mylib.var[defns] or {}  -- Default namespace

-- Declare variable (in namespace) and return value
function mylib.var.let(name, initVal, namespace)
    assert(type(name) == "string", "Require string as variable name")
    local v = mylib.var.get(name, namespace) or (initVal or {})
    mylib.var.set(name, v, namespace)
    return mylib.var.get(name, namespace)
end

-- Get the variable with the name (in namespace)
function mylib.var.get(name, namespace)
    return mylib.var.namespace(namespace)[name]
end

-- Set variable with name (in namespace) to value
function mylib.var.set(name, value, namespace)
    mylib.var.namespace(namespace)[name] = value
end

-- Get variable namespace or create new if not exists
function mylib.var.namespace(namespace)
    namespace = namespace or defns
    if (mylib.varCurrEnv[namespace] == nil) then
        mylib.varCurrEnv[namespace] = {}
    end
    return mylib.varCurrEnv[namespace]
end

--[[ Generates a new namespace in the current enviroment, 
  returns namespace name, namespace --]]
function mylib.var.genNewNamespace()
    local ns = "ns" .. mylib.string.random(6)
    while (mylib.varCurrEnv[ns] ~= nil) do
        ns = "ns" .. mylib.string.random(6)
    end
    return ns, mylib.var.namespace(ns)
end

-- Set current variable environment to global
function mylib.var.setEnvGlobal()
    mylib.varCurrEnv = _G
end

-- Set current variable environment to default
function mylib.var.setEnvDefault()
    mylib.varCurrEnv = mylib.var
end
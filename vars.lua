-- Utility functions to put variables into an extra namespace 

mylib = mylib or {}
mylib.vars = mylib.vars or {
    defns = {} -- Default namespace
}              -- Default environment
local defns <const> = "defns"
mylib.currVarEnv = mylib.vars     -- Current variable environment
setmetatable(mylib.vars, {__index = _G})

-- Declare variable and return value
function mylib.letVar(name, initVal, namespace)
    assert(type(name) == "string", "Require string as variable name")
    local v = mylib.getVar(name, namespace) or (initVal or {})
    mylib.setVar(name, v, namespace)
    return mylib.getVar(name, namespace)
end

-- Get the variable with the name
function mylib.getVar(name, namespace)
    return mylib.getVarNamespace(namespace)[name]
end

-- Set variable with name to value
function mylib.setVar(name, value, namespace)
    mylib.getVarNamespace(namespace)[name] = value
end

function mylib.getVarNamespace(namespace)
    namespace = namespace or defns
    if (mylib.currVarEnv[namespace] == nil) then
        mylib.currVarEnv[namespace] = {}
    end
    return mylib.currVarEnv[namespace]
end

function mylib.setVarEnvGlobal()
    mylib.currVarEnv = _G
end

function mylib.setVarEnvDefault()
    mylib.currVarEnv = mylib.vars
end
-- Utility functions to put variables into an extra namespace 
    
mylib = mylib or {}
mylib.vars = mylib.vars or {} -- Default environment
setmetatable(mylib.vars, {__index = _G})
mylib.varEnv = mylib.vars

-- Declare variable and return value
function mylib.letVar(name, initVal)
    assert(type(name) == "string", "Require string as variable name")
    mylib.varEnv[name] = mylib.varEnv[name] or (initVal or {})
    return mylib.varEnv[name]
end

-- Get the variable with the name
function mylib.getVar(name)
    return mylib.varEnv[name]
end

-- Set variable with name to value
function mylib.setVar(name, value)
    mylib.varEnv[name] = value
end

function mylib.setVarEnvGlobal()
    mylib.varEnv = _G
end

function mylib.setVarEnvDefault()
    mylib.varEnv = mylib.vars
end
-- Utility functions to put variables into an extra namespace 
    
mylib = mylib or {}
mylib.vars = mylib.vars or {}

-- Declare variable and return value
function mylib.letVar(name, initVal)
    assert(type(name) == "string", "Require string as variable name")
    mylib.vars[name] = mylib.vars[name] or (initVal or {})
    return mylib.vars[name]
end

-- Get the variable with the name
function mylib.getVar(name)
    return mylib.vars[name]
end

-- Set variable with name to value
function mylib.putVar(name, value)
    mylib.vars[name] = value
end
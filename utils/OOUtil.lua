module("OOUtil", package.seeall)

function super(obj)
    return getmetatable(obj).__index
end

function csuper(obj)
    local ret = {}
    setmetatable(ret, getmetatable(obj))
    return ret
end

-- function class(obj, super)
--     setmetatable(obj, {__index=super})
-- end

function invokeWithSuper(obj, methodName, ...)
    local mt = getmetatable(obj)
    if mt==nil or mt==getmetatable({}) or mt.__index==nil then
        return
    end
    local sobj = mt.__index
    invokeWithSuper(sobj, methodName)
    sobj[methodName](...)
end

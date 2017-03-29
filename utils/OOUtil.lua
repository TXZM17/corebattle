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

function clone(obj)
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        end
        local new_table = {}
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(obj)
end

function isClass(obj, type)
    if obj.type==type then
        return true
    end
    if getmetatable(obj)==getmetatable({}) or getmetatable(obj)==nil then
        return false
    end
    return isClass(getmetatable(obj), type)
end

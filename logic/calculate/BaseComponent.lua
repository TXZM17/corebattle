local BaseComponent = {comp_type="BaseComponent"}

BaseComponent._toAllocateId = 1
BaseComponent.type = "BaseComponent"

function BaseComponent.create()
    local ret = {}
    setmetatable(ret, {__index=BaseComponent})
    ret:init()
    return ret
end

function BaseComponent:init()
    BaseComponent.allocateId(self)
end

function BaseComponent:calculate(context, lastResult)
    error("this is a abstract calculate component", context, lastResult, self.id)
end

--static
function BaseComponent.allocateId(comp)
    comp.id = BaseComponent._toAllocateId
    BaseComponent._toAllocateId = BaseComponent._toAllocateId + 1
end

return BaseComponent

local BaseComponent = require("logic.calculate.BaseComponent")
local EasyComponent = BaseComponent.create()

EasyComponent.type = "EasyComponent"

function EasyComponent.create()
    local ret = {}
    setmetatable(ret, {__index=EasyComponent})
    ret:init()
    return
end

function EasyComponent:init()
    BaseComponent.init(self)
end

function EasyComponent:calculate(context, lastResult)
    print("component:", self.type, self.id)
    lastResult = lastResult or context.hp
    local atk = context.atk
    return true, lastResult-atk
end

return EasyComponent

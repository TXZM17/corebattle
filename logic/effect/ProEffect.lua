local Effect = require("logic.effect.Effect")
local ProEffect = Effect.create()

ProEffect.type = "ProEffect"
ProEffect.CHANGE_TYPE = {
    INCREMENT = 1,
    SCALE = 2,
    BASE_SCALE = 3,
}

function ProEffect.create(proNames, changeType, value)
    local ret = {}
    setmetatable(ret, {__index=ProEffect})
    ret:init(proNames, changeType, value)
    return ret
end

function ProEffect:init(proNames, changeType, value)
    Effect.init(self, proNames, changeType, value)
    self.proNames = proNames
    self.changeType = changeType
    self.value = value
end

function ProEffect:doEffect(target)
    print("=======pro effect do effect")
    for _,proName in pairs(self.proNames) do
        local delta = 0
        if self.changeType==ProEffect.CHANGE_TYPE.INCREMENT then
            delta = self.value
        elseif self.changeType==ProEffect.CHANGE_TYPE.SCALE then
            delta = target.context[proName]*self.value
        elseif self.changeType==ProEffect.CHANGE_TYPE.BASE_SCALE then
            delta = target.baseContext[proName]*self.value
        end
        target.context[proName] = target.context[proName] + delta
        print("ProEffect do effect:", proName, "increased ", delta)
    end
end

function ProEffect:undoEffect(target)
    for _,proName in pairs(self.proNames) do
        local delta = 0
        if self.changeType==ProEffect.CHANGE_TYPE.INCREMENT then
            delta = self.value
        elseif self.changeType==ProEffect.CHANGE_TYPE.SCALE then
            delta = target.context[proName]*self.value
        elseif self.changeType==ProEffect.CHANGE_TYPE.BASE_SCALE then
            delta = target.baseContext[proName]*self.value
        end
        target.context[proName] = target.context[proName] - delta
        print("ProEffect undo effect:", proName, "decreased ", delta)
    end
end

return ProEffect

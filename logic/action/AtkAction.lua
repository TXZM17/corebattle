local Action = require("logic.action.Action")
local AtkAction = Action.create()

AtkAction.type = "AtkAction"
AtkAction.ATTACK_TYPE = {
    NORMAL = 1,
    MAGIC = 2,
    SACRED = 3,
    REBOUND = 4,
}

function AtkAction.create(caster, targets)
    local ret = {}
    setmetatable(ret, {__index=AtkAction})
    ret:init(caster, targets)
    return ret
end

function AtkAction:init(caster, targets)
    Action.init(self, caster, targets)
end

function AtkAction:setParams(params)
    self.attackType = params.attackType
    self.hurtInfo = params.hurtInfo
end

function AtkAction:canPointAtk(target)
    if self.params.pointAtkFilter then
        return self.params.pointAtkFilter(target, self.caster)
    end
    return true
end

function AtkAction:canRangeAtk(target)
    if self.params.rangeAtkFilter then
        return self.params.rangeAtkFilter(target, self.caster)
    end
    return true
end

return AtkAction

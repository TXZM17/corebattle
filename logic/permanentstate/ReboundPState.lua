local PermanentState = require("logic.permanentstate.PermanentState")
local HurtInfo = require("logic.battleinfo.HurtInfo")
local AtkAction = require("logic.action.AtkAction")
local ReboundPState = PermanentState.create()

ReboundPState.type = "ReboundPState"

function ReboundPState.create(owner)
    local ret = {}
    setmetatable(ret, {__index=ReboundPState})
    ret:init(owner)
    return ret
end

function ReboundPState:init(owner)
    PermanentState.init(self, owner)
    --默认为0.1
    self.reboundScale = 0.1
end

function ReboundPState:setReboundScale(scale)
    self.reboundScale = scale
end

function ReboundPState:onHurt(hurtInfo)
    if hurtInfo.attackType==AtkAction.ATTACK_TYPE.REBOUND then
        -- 防止无限反弹
        return true, hurtInfo
    end
    print(string.format("%s:发动了反击", self.owner.name))
    local info = HurtInfo.create({
        attackerId = self.owner.id,
        targetId = hurtInfo.attackerId,
        attackType = AtkAction.ATTACK_TYPE.REBOUND,
        value = hurtInfo.value*self.reboundScale
    })
    local target = self.owner.director:getEntity(hurtInfo.attackerId)
    local action = AtkAction.create(self.owner, target)
    action:setParams({
        attackType=AtkAction.ATTACK_TYPE.REBOUND,
        hurtInfo = info})
    self.owner.director:addAction(action)
    return true, hurtInfo
end

return ReboundPState

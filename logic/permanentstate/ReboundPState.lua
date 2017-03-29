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
    local info = clone(hurtInfo)
    HurtInfo.allocateId(info)
    info.attackerId,info.targetId = info.targetId,info.attackerId
    info.realTargetId = info.targetId
    info.attackType = AtkAction.ATTACK_TYPE.REBOUND
    info.value = info.value*self.reboundScale
    local target = self.owner.director:getEntity(hurtInfo.attackerId)
    local action = AtkAction.create(self.owner, target)
    action:setParams({
        attackType=AtkAction.ATTACK_TYPE.REBOUND,
        hurtInfo = info})
    self.owner.director:addAction(action)
end

return ReboundPState

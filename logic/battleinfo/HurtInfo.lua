local HurtInfo = {}

HurtInfo.type = "HurtInfo"
HurtInfo._toAllocateId = 1

function HurtInfo.create(params)
    local ret = {}
    setmetatable(ret, {__index=HurtInfo})
    ret:init(params)
    return ret
end

function HurtInfo:init(params)
    HurtInfo.allocateId(self)
    self.attackerId = params.attackerId
    self.targetId = params.targetId
    self.realTargetId = params.realTargetId or self.targetId
    -- 攻击类型：物理、魔法、神圣之类的
    self.attackType = params.attackType
    self.value = params.value
end

function HurtInfo.allocateId(info)
    info.id = HurtInfo._toAllocateId
    HurtInfo._toAllocateId = HurtInfo._toAllocateId + 1
end

return HurtInfo

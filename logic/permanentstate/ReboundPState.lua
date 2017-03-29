local PermanentState = require("logic.permanentstate.PermanentState")
local HurtInfo = require("logic.battleinfo.HurtInfo")
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
end

function ReboundPState:onHurt(hurtInfo)
    local info = clone(hurtInfo)
    HurtInfo.allocateId(info)
    local target = self.owner.director:getEntity(hurtInfo.attackerId)
    --TODO
end

return ReboundPState

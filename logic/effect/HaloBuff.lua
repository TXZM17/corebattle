local Buff = require("logic.effect.Buff")

local HaloBuff = Buff.create()
HaloBuff.type = "HaloBuff"

function HaloBuff.create(lastFrame)
    local ret = {}
    setmetatable(ret, {__index=HaloBuff})
    ret:init(lastFrame)
    return ret
end

function HaloBuff:init(lastFrame)
    Buff.init(self, lastFrame)
    -- 保证一旦角色离开光环范围，持续一段时间后效果就失效
    self.lastFrame = lastFrame or 1
    self.remainFrame = self.lastFrame
end

function HaloBuff:update(target)
    Buff.update(self, target)
    self.remainFrame = self.remainFrame - 1
end

function HaloBuff:checkValid(target)
    return self.remainFrame>0 and Buff.checkValid(self, target)
end

return HaloBuff

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
    self.lastFrame = 1
    self.remainFrame = self.lastFrame
end

function HaloBuff:update(target)
    Buff.update(self, target)
    self.remainFrame = self.remainFrame - 1
end

function HaloBuff:updateValid(target)
    return self.remainFrame>0 and Buff.checkValid(self, target)
end

return HaloBuff

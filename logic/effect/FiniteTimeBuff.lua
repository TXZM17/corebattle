local Buff = require("logic.effect.Buff")
local FiniteTimeBuff = Buff.create()

FiniteTimeBuff.type = "FiniteTimeBuff"

function FiniteTimeBuff.create(lastFrame)
    local ret = {}
    setmetatable(ret, {__index=FiniteTimeBuff})
    ret:init(lastFrame)
    return ret
end

function FiniteTimeBuff:init(lastFrame)
    Buff.init(self, lastFrame)
    self.lastFrame = lastFrame
    self.remainFrame = self.lastFrame
end

function FiniteTimeBuff:update(target)
    Buff.update(self, target)
    self.remainFrame = self.remainFrame - 1
end

function FiniteTimeBuff:checkValid(target)
    return self.remainFrame>0 and Buff.checkValid(self, target)
end

return FiniteTimeBuff

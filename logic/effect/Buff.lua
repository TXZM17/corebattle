local Buff = {}

Buff.type = "Buff"
Buff._toAllocateId = 1

function Buff.create(...)
    local ret = {}
    setmetatable(ret, {__index=Buff})
    ret:init(...)
    return ret
end

function Buff:init(...)
    self.params = {...}
    Buff.allocateId(self)
    self._effectList = {}
    self.valid = true
end

function Buff:doBuff(target)
    for _,effect in ipairs(self._effectList) do
        effect:doEffect(target)
    end
end

function Buff:update(target)
    self.valid = self:checkValid(target)
    if not self.valid then
        --在target的removeBuff方法中应该调用undoBuff
        target:removeBuff(self)
        return
    end
    for _,effect in ipairs(self._effectList) do
        effect:update(target)
    end
end

function Buff:undoBuff(target)
    for _,effect in ipairs(self._effectList) do
        effect:undoEffect(target)
    end
end

function Buff:resetBuff()
    self.valid = true
end

function Buff:setInvalid()
    self.valid = false
end

--static
function Buff.allocateId(buff)
    buff.id = Buff._toAllocateId
    Buff._toAllocateId = Buff._toAllocateId + 1
end

function Buff:checkValid(target)
    return self.valid and target.hp<=0
end

return Buff

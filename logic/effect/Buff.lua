local Buff = {}

Buff.type = "Buff"
Buff._toAllocateId = 1

-- Buff是对Effect的包装，它为effect提供生命周期管理和组行为
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
    if not self:checkValid(target) then
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

function Buff:addEffect(effect)
    if self:getEffect(effect.id) then
        --不能重复
        return false
    end
    table.insert(self._effectList, effect)
    return true
end

function Buff:getEffect(effectId)
    for _,v in ipairs(self._effectList) do
        if v.id==effectId then
            return v
        end
    end
end

function Buff:removeEffect(effectId)
    for k,v in ipairs(self._effectList) do
        if v.id==effectId then
            table.remove(self._effectList, k)
            return true
        end
    end
    return false
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
    return self.valid and target:isAlive()
end

return Buff

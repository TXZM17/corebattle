local Effect = {}

Effect.type = "Effect"
Effect._toAllocateId = 1

function Effect.create(...)
    local ret = {}
    setmetatable(ret, {__index=Effect})
    ret:init(...)
    return ret
end

function Effect:init(...)
    self.params = {...}
    Effect.allocateId(self)
end

function Effect:doEffect(target)
    print(string.format("do effect<> Effect type:%s, id:%s do effect to entity: %s-%s", self.effect_type, self.effect_id, target._type, target.id))
end

function Effect:update(target)
    print(string.format("update effect<> Effect type:%s, id:%s do effect to entity: %s-%s", self.effect_type, self.effect_id, target._type, target.id))
end

function Effect:undoEffect(target)
    print(string.format("undo effect<> Effect type:%s, id:%s do effect to entity: %s-%s", self.effect_type, self.effect_id, target._type, target.id))
end

--static
function Effect.allocateId(effect)
    effect.id = Effect._toAllocateId
    Effect._toAllocateId = Effect._toAllocateId + 1
end

return Effect

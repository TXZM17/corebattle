local BattleContext = {}

function BattleContext.create()
    local ret = {}
    setmetatable(ret, {__index=BattleContext})
    ret:init()
    return ret
end

function BattleContext:init()
    self._entitymap = {}
end

function BattleContext:registEntity(entity)
    assert(entity and entity.id)
    self._entitymap[entity.id] = entity
end

function BattleContext:getEntity(entityId)
    return self._entitymap[entityId]
end

function BattleContext:getConstEntity(entityId)
    local entity = self:getEntity(entityId)
    if entity then
        local ret = {}
        setmetatable(ret, entity)
        return ret
    else
        return entity
    end
end

function BattleContext:getAllEntity()
    local ret = {}
    for _,v in pairs(self._entitymap) do
        table.insert(ret, v)
    end
    table.sort(ret, function(x,y)
        return x.id<=y.id
    end)
    return ret
end

function BattleContext:unregistEntity(entityId)
    self._entitymap[entityId] = nil
end

return BattleContext

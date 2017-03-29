local ActionManager = require("logic.action.ActionManager")
local BattleDirector = {}

function BattleDirector.create(context)
    local ret = {}
    setmetatable(ret, {__index=BattleDirector})
    ret:init(context)
    return ret
end

function BattleDirector:init(context)
    self._endFlag = false
    self._frameIndex = 0
    self.context = context
    self._events = {}
    self._actionManager = ActionManager.create(self)
end

function BattleDirector:startBattle()
    print("BattleDirector start");
    math.randomseed(self.context:getSeed())
    self:mainLoop()
end

function BattleDirector:mainLoop()
    while not self:checkEnd() do
        self._frameIndex = self._frameIndex + 1
        print("BattleDirector update:", self._frameIndex)
        -- 处理上一帧的行为
        self._actionManager:update(self._frameIndex)
        -- 这里主要update相关角色，并非所有的实体都需要update的
        self:updateRole()
    end
end

function BattleDirector:updateRole()
    local entityList = self.context:getAllAliveRole()
    for _,entity in ipairs(entityList) do
        entity:update(self._frameIndex)
    end
end

function BattleDirector:endBattle()
    print("BattleDirector end")
    self._endFlag = true
end

function BattleDirector:checkEnd()
    local frameLimit = self._frameIndex>10
    return self._endFlag or frameLimit or #self.context:getAllAliveRole()<1
end

function BattleDirector:addEntity(entity)
    self.context:registEntity(entity)
    entity.director = self
end

function BattleDirector:removeEntity(entityId)
    local entity = self.context:getEntity(entityId)
    if entity then
        entity.director = nil
        self.context:unregistEntity(entityId)
    end
end

function BattleDirector:searchEntity(filterFunc)
    local all = self.context:getAllEntity()
    local ret = {}
    for _,v in ipairs(all) do
        if filterFunc(v) then
            table.insert(ret, v)
        end
    end
    return ret
end

function BattleDirector:getEntity(entityId)
    return self.context:getEntity(entityId)
end

function BattleDirector:getRangeTargets(range)
    -- 我们假定所有的entity处于同一坐标系统内
    local all = self.context:getAllEntity()
    local targets = {}
    for _,v in ipairs(all) do
        if range:inRange(v) then
            table.insert(targets, v)
        end
    end
    return targets
end

function BattleDirector:getAllAliveRole()
    return self.context:getAllAliveRole()
end

function BattleDirector:addAction(action)
    return self._actionManager:addAction(self._frameIndex+1, action)
end

return BattleDirector

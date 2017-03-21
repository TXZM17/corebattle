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
end

function BattleDirector:startBattle()
    print("BattleDirector start");
    self:mainLoop()
end

function BattleDirector:mainLoop()
    local param = {}
    param.entityList = self.context:getAllEntity()
    while not self:checkEnd() do
        self:update(param)
    end
end

function BattleDirector:update(param)
    self._frameIndex = self._frameIndex + 1
    print("BattleDirector update:", self._frameIndex)
    local entityList = param.entityList
    for _,entity in ipairs(entityList) do
        entity:update()
    end
end

function BattleDirector:endBattle()
    print("BattleDirector end")
    self._endFlag = true
end

function BattleDirector:checkEnd()
    local frameLimit = self._frameIndex>10
    return self._endFlag or frameLimit
end

function BattleDirector:addEntity(entity)
    self.context:registEntity(entity)
end

function BattleDirector:removeEntity(entityId)
    self.context:unregistEntity(entityId)
end

return BattleDirector

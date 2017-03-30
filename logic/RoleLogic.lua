local EntityLogic = require("logic.EntityLogic")
local AtkAction = require("logic.action.AtkAction")
local CalculatorChain = require("logic.calculate.CalculatorChain")
local PermanentStateManager = require("logic.permanentstate.PermanentStateManager")
local BuffManager = require("logic.effect.BuffManager")

local RoleLogic = EntityLogic.create({})

RoleLogic.type = "RoleLogic"

-- 属性的计算涉及很多，应该放在logic里面

function RoleLogic.create(context)
    local ret = {}
    setmetatable(ret, {__index=RoleLogic})
    ret:init(context)
    return ret
end

function RoleLogic:init(context)
    EntityLogic.init(self, context)
    -- context中的是RoleLogic的模板属性，一般在战斗开始前就已经被固定，一些极特殊的Effect可以影响此数据
    -- 当前的属性名称加上cur，使用驼峰命名法
    -- 这里需要按照context中的属性初始化cur属性
    -- 属性变动分几个阶段：战斗初始化、角色属性加成、特殊效果（eg:1.5倍加成后的攻击力）
    self._permanentStateManager = PermanentStateManager.create(self)
    self._buffManager = BuffManager.create(self)
    self.baseContext = self.context
    self.context = OOUtil.clone(self.baseContext)
    self.name = self.context.name
    -- 一些effect可以给role添加calculator
    self._chain = CalculatorChain.create(self)
end

function RoleLogic:update(frameIndex)
    print("name:", self:getProValue("name"), "hp:", self:getProValue("hp"), frameIndex)
    self._buffManager:update(frameIndex)
    self:atk()
end

function RoleLogic:atk()
    local targets = self.director:searchEntity(function(entity)
        return entity.id~=self.id and entity.teamId~=self.teamId and entity:isAlive()
    end)
    ArrayUtil.shuffle(targets)
    targets = ArrayUtil.copyArray(targets,1,2)
    if #targets<1 then
        return
    end
    local atkAction = AtkAction.create(self, targets)
    atkAction:setParams({
        attackType=AtkAction.ATTACK_TYPE.NORMAL
    })
    self.director:addAction(atkAction)
end

function RoleLogic:onHurt(hurtInfo)
    local director = self.director
    local attacker = director:getEntity(hurtInfo.attackerId)
    print(string.format("%s ---> %s  value: %s, type: %s", attacker.name, self.name, hurtInfo.value, hurtInfo.attackType))
    local continue,params = self._permanentStateManager:invoke(PermanentStateManager.INVOKE_POINT.BEFORE, "onHurt", {hurtInfo=hurtInfo})
    if not continue then
        return
    end
    hurtInfo = params.hurtInfo
    self:changeProValue("hp", math.max(0, self:getProValue("hp") - hurtInfo.value))
    self._permanentStateManager:invoke(PermanentStateManager.INVOKE_POINT.AFTER, "onHurt", {hurtInfo=hurtInfo})
end

function RoleLogic:onHeal(healInfo)
    print("=====onheal:", self.name, self.id, healInfo.value)
    local continue,params = self._permanentStateManager:invoke(PermanentStateManager.INVOKE_POINT.BEFORE, "onHeal", {healInfo=healInfo})
    if not continue then
        return
    end
    healInfo = params.healInfo
    self:changeProValue("hp", math.min(self:getProValue("hpMax"), self:getProValue("hp") + healInfo.value))
    self._permanentStateManager:invoke(PermanentStateManager.INVOKE_POINT.AFTER, "onHeal", {healInfo=healInfo})
end

function RoleLogic:onPointHurt(hurtInfo)
    --TODO 点伤做些处理
    self:onHurt(hurtInfo)
end

function RoleLogic:onRangeHurt(hurtInfo)
    --TODO aoe伤害处理
    self:onHurt(hurtInfo)
end

function RoleLogic:getRealAtk()
    local atkMin = self:getProValue("atkMin", false)
    local atkMax = self:getProValue("atkMax", false)
    return math.random(atkMin, atkMax)
end

function RoleLogic:addPermanentState(state)
    return self._permanentStateManager:addState(state)
end

function RoleLogic:removePermanentState(state)
    return self._permanentStateManager:removeState(state.id)
end

function RoleLogic:addBuff(buff)
    return self._buffManager:addBuff(buff)
end

function RoleLogic:removeBuff(buffId)
    return self._buffManager:removeBuff(buffId)
end

function RoleLogic:addCalculator(calculator)
    self._chain:addCalculator(calculator)
end

function RoleLogic:removeCalculator(calculatorId)
    self._chain:removeCalculator(calculatorId)
end

function RoleLogic:getProValue(proName, isBase)
    local context = isBase and self.baseContext or self.context
    -- 特殊效果的计算链(包括在初始化函数中内置添加的)
    if not isBase then
        self._chain:calculate(proName)
    end
    return context[proName]
end

function RoleLogic:changeProValue(proName, value, isBase)
    local context = isBase and self.baseContext or self.context
    assert(context[proName], string.format("undefined proName: %s", proName))
    context[proName] = value
end

function RoleLogic:setOrAddProValue(proName, value, isBase)
    local context = isBase and self.baseContext or self.context
    context[proName] = value
end

function RoleLogic:isAlive()
    return self:getProValue("hp", false)>0
end

return RoleLogic

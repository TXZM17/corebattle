local EntityLogic = require("logic.EntityLogic")
local AtkAction = require("logic.action.AtkAction")

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
    self._permanentStates = {}
    self.curHp = self.context.hp
    self.name = self.context.name
    self.curHpMax = self.context.hpMax
end

function RoleLogic:update()
    print("name:", self.name, "hp:", self.curHp)
    self:atk()
end

function RoleLogic:atk()
    local targets = self.director:searchEntity(function(entity)
        return entity.id~=self.id and entity.teamId~=self.teamId and entity.curHp>0
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
    local continue = true
    for _,state in ipairs(self._permanentStates) do
        if state.onHurt then
            continue,hurtInfo = state:onHurt(hurtInfo)
        end
        if not continue then
            return
        end
    end
    self.curHp = math.max(0, self.curHp - hurtInfo.value)
end

function RoleLogic:onHeal(healInfo)
    print("=====onheal:", self.name, self.id, healInfo.value)
    local continue = true
    for _,state in ipairs(self._permanentStates) do
        if state.onHeal then
            continue,healInfo = state:onHurt(healInfo)
        end
        if not continue then
            return
        end
    end
    self.curHp = self.curHp or self.context.hp
    self.curHp = math.min(self.curHpMax, self.curHp + healInfo.value)
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
    return math.random(self.context.atk[1], self.context.atk[2])
end

function RoleLogic:addPermanentState(state)
    table.insert(self._permanentStates, state)
end

function RoleLogic:removePermanentState(state)
    for k,v in ipairs(self._permanentStates) do
        if state.id==v.id then
            table.remove(self._permanentStates, k)
        end
    end
end

return RoleLogic

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
    self.curHp = self.context.hp
    self.name = self.context.name
end

function RoleLogic:update()
    print("id:", self.id, "hp:", self.curHp)
    self:atk()
end

function RoleLogic:atk()
    local targets = self.director:searchEntity(function(entity)
        return entity.id~=self.id and entity.curHp>0
    end)
    ArrayUtil.shuffle(targets)
    targets = ArrayUtil.copyArray(targets,1,2)
    local atkAction = AtkAction.create(self, targets)
    atkAction:setParams({
        attackType=AtkAction.ATTACK_TYPE.NORMAL
    })
    self.director:addAction(atkAction)
end

function RoleLogic:onHurt(hurtInfo)
    print("=====onhurt:", self.name, self.id, hurtInfo.value)
    self.curHp = self.curHp or self.context.hp
    self.curHp = self.curHp - hurtInfo.value
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

return RoleLogic

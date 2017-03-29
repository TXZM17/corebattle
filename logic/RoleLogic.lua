local EntityLogic = require("logic.EntityLogic")
local AtkAction = require("logic.action.AtkAction")

local RoleLogic = EntityLogic.create({})

RoleLogic.type = "RoleLogic"

function RoleLogic.create(context)
    local ret = {}
    setmetatable(ret, {__index=RoleLogic})
    ret:init(context)
    return ret
end

function RoleLogic:init(context)
    EntityLogic.init(self, context)
end

function RoleLogic:update()
    print("id:", self.id, "hp:", self.context:getHp())
    self:atk()
end

function RoleLogic:atk()
    local targets = self.director:searchEntity(function(entity)
        return entity.id~=self.id and entity.context:getHp()>0
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
    self.context:onHurt(hurtInfo)
end

function RoleLogic:onPointHurt(hurtInfo)
    --TODO 点伤做些处理
    self:onHurt(hurtInfo)
end

function RoleLogic:onRangeHurt(hurtInfo)
    --TODO aoe伤害处理
    self:onHurt(hurtInfo)
end

return RoleLogic

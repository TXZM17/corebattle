local EntityLogic = require("logic.EntityLogic")
local AtkEvent = require("logic.event.AtkEvent")
local AtkContext = require("logic.event.AtkContext")

local RoleLogic = EntityLogic.create({})

RoleLogic._type = "RoleLogic"

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
    local atkContext = AtkContext.create(self, targets)
    local event = AtkEvent.create(atkContext)
    self.director:addEvent(event)
end

function RoleLogic:onHurt(hurtNum)
    self.context:onHurt(hurtNum)
end

return RoleLogic

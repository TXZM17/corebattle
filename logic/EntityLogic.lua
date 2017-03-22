local EntityLogic = {}

EntityLogic._toAllocateId = 1
EntityLogic.type = "EntityLogic"

function EntityLogic.create(context)
    local ret = {}
    setmetatable(ret, {__index=EntityLogic})
    ret:init(context)
    return ret
end

function EntityLogic:init(context)
    self.context = context
    EntityLogic.allocateId(self)
end

function EntityLogic:update()
    print("EntityLogic update", self.id)
end

--static func
function EntityLogic.allocateId(entity)
    entity.id = EntityLogic._toAllocateId
    EntityLogic._toAllocateId = EntityLogic._toAllocateId + 1
end

return EntityLogic

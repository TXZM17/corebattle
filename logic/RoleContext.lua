local RoleContext = {}

function RoleContext.create(params)
    local ret = {}
    setmetatable(ret, {__index=RoleContext})
    ret:init(params)
    return ret
end

function RoleContext:init(params)
    self.atk = params.atk or {1,1}
    self.hp = params.hp
    self.modelId = params.id
    self.name = params.name
    self.hpMax = params.hpMax or self.hp
end

return RoleContext

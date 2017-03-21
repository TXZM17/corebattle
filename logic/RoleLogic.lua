local EntityLogic = require("logic.EntityLogic")
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

-- function RoleLogic:update()
--
-- end
--
-- function RoleLogic:atk()
--
-- end

return RoleLogic

local Action = {}

Action.type = "Action"
Action._toAllocateId = 1

function Action.create(caster, targets)
    local ret = {}
    setmetatable(ret, {__index=Action})
    ret:init(caster, targets)
    return ret
end

function Action:init(caster, targets)
    Action.allocateId(self)
    self.caster = caster
    self.targets = targets or {}
end

--static
function Action.allocateId(action)
    action.id = Action._toAllocateId
    Action._toAllocateId = Action._toAllocateId + 1
end

return Action

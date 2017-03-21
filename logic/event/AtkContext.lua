local AtkContext = {}

function AtkContext.create(caster, targets)
    local ret = {}
    setmetatable(ret, {__index=AtkContext})
    ret:init(caster, targets)
    return ret
end

function AtkContext:init(caster, targets)
    self.caster = caster
    self.targets = targets
end

function AtkContext:getCaster()
    return self.caster
end

function AtkContext:getTargets()
    return self.targets
end

return AtkContext

local AtkEvent = {}

function AtkEvent.create(context)
    local ret = {}
    setmetatable(ret, {__index=AtkEvent})
    ret:init(context)
    return ret
end

function AtkEvent:init(context)
    self.context = context
end

function AtkEvent:execute()
    local targets = self.context:getTargets()
    local caster = self.context:getCaster()
    for _,target in ipairs(targets) do
        local atkNum = caster.context:getAtk()
        target:onHurt(atkNum)
        print("caster", caster.id, "attack ", target.id, ", hp -", atkNum)
    end
end

return AtkEvent

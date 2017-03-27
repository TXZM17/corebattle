local RoleContext = {}

function RoleContext.create(params)
    local ret = {}
    setmetatable(ret, {__index=RoleContext})
    ret:init(params)
    return ret
end

function RoleContext:init(params)
    self.hpMax = params.hp;
    self.atk = params.atk or {1,1}
    self.hp = self.hpMax
    self.modelId = params.id
    self.name = params.name
end

function RoleContext:getAtk()
    return math.random(self.atk[1], self.atk[2])
end

function RoleContext:setHp(hp)
    hp = math.max(0, math.min(self.hpMax, hp))
    self.hp = hp
end

function RoleContext:getHp()
    return self.hp
end

function RoleContext:onHurt(hurtNum)
    self:setHp(self:getHp()-hurtNum)
end

function RoleContext:onHeal(healNum)
    self:setHp(self:getHp()+healNum)
end

-- function RoleContext:onBuff()
--
-- end
--
-- function RoleContext:onDebuff()
--
-- end

return RoleContext

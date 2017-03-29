local BattleViewContext = {}

function BattleViewContext.create()
    local ret = {}
    setmetatable(ret, {__index=BattleViewContext})
    ret:init()
    return ret
end

function BattleViewContext:init()
    self.scene = nil
    self.roles = {}
end

function BattleViewContext:setSceneView(sceneView)
    self.scene = sceneView
end

function BattleViewContext:addRoleView(roleView)
    table.insert(self.roles, roleView)
end

function BattleViewContext:getRoleById(id)
    for _,role in ipairs(self.roles) do
        if role.id == id then
            return role
        end
    end
    return nil
end

return BattleViewContext

local PermanentStateManager = {}

PermanentStateManager.type = "PermanentStateManager"

PermanentStateManager.INVOKE_POINT = {
    BEFORE = 1,
    AFTER = 2,
}

function PermanentStateManager.create(owner)
    local ret = {}
    setmetatable(ret, {__index=PermanentStateManager})
    ret:init(owner)
    return ret
end

function PermanentStateManager:init(owner)
    self.owner = owner
    self._stateContainer = {}
end

function PermanentStateManager:invoke(invokePoint, eventName, params)
    local continue = true
    for _,state in ipairs(self._stateContainer) do
        if not continue then
            break
        end
        continue,params = state:onNotify(invokePoint, eventName, params)
    end
    return continue,params
end

function PermanentStateManager:addState(state)
    if self:getState(state.id) then
        return false
    end
    table.insert(self._stateContainer, state)
    return true
end

function PermanentStateManager:getState(stateId)
    for _,state in ipairs(self._stateContainer) do
        if state.id==stateId then
            return state
        end
    end
end

function PermanentStateManager:removeState(stateId)
    for k,state in ipairs(self._stateContainer) do
        if state.id==stateId then
            table.remove(self._stateContainer, k)
            return state
        end
    end
    return false
end

return PermanentStateManager

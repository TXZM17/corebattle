local PermanentState = {}

PermanentState.type = "PermanentState"
PermanentState._toAllocateId = 1

function PermanentState.create(owner)
    local ret = {}
    setmetatable(ret, {__index=PermanentState})
    ret:init(owner)
    return ret
end

function PermanentState:init(owner)
    self.owner = owner
end

function PermanentState.allocateId(state)
    state.id = PermanentState._toAllocateId
    PermanentState._toAllocateId = PermanentState._toAllocateId + 1
end

return PermanentState

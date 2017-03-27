local ViewCommand = {}

ViewCommand.type = "ViewCommand"
ViewCommand._toAllocateId = 1

function ViewCommand.create()
    local ret = {}
    setmetatable(ret, {__index=ViewCommand})
    ret:init()
    return
end

function ViewCommand:init()
    ViewCommand.allocateId(self)
end

function ViewCommand.allocateId(command)
    command.id = ViewCommand._toAllocateId
    ViewCommand._toAllocateId = ViewCommand._toAllocateId + 1
end

return ViewCommand

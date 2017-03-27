local ViewCommand = require("view.command.ViewCommand")

local RoleCommand = ViewCommand.create()

RoleCommand.type = "RoleCommand"

function RoleCommand.create(msg, params)
    local ret = {}
    setmetatable(ret, {__index=RoleCommand})
    ret:init(msg, params)
    return ret
end

function RoleCommand:init(msg, params)
    ViewCommand.init(self)
    self.msg = msg
    self.params = params
    self.executorId = params.executorId
end

return RoleCommand

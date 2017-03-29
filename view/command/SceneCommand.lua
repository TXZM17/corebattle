local ViewCommand = require("view.command.ViewCommand")

local SceneCommand = ViewCommand.create()

SceneCommand.type = "SceneCommand"

function SceneCommand.create(msg, params)
    local ret = {}
    setmetatable(ret, {__index=SceneCommand})
    ret:init(msg, params)
    return ret
end

function SceneCommand:init(msg, params)
    ViewCommand.init(self)
    self.msg = msg
    self.params = params
end

return SceneCommand

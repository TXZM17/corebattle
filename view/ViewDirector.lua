local ViewDirector = {}

function ViewDirector.create(viewContext, viewCommands)
    local ret = {}
    setmetatable(ret, {__index=ViewDirector})
    ret:init(viewContext, viewCommands)
    return ret
end

function ViewDirector:init(viewContext, viewCommands)
    self._context = viewContext
    self._commands = viewCommands or {}
    self._frameIndex = 0
end

function ViewDirector:update()
    self._frameIndex = self._frameIndex + 1
    local commands = self._commands[self._frameIndex]
    for _,command in ipairs(commands) do
        self:executeCommand(command)
    end
end

function ViewDirector:executeCommand(command)
    if command.type=="SceneCommand" then
        self._context.scene:executeCommand(command)
    elseif command.type=="RoleCommand" then
        local executor = self._context:getRoleById(command.executorId)
        if executor then
            executor:executeCommand(command)
        else
            print(string.format("command %s-%s has no executor~~~", command.type, command.id))
        end
    end
end


return ViewDirector

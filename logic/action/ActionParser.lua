local ActionParser = {}

ActionParser.type = "ActionParset"
ActionParser._toAllocateId = 1

function ActionParser.create(director, action)
    local ret = {}
    setmetatable(ret, {__index=ActionParser})
    ret:init(director, action)
    return ret
end

function ActionParser:init(director, action)
    self._director = director
    self._action = action
    ActionParser.allocateId(self)
end

function ActionParser.allocateId(parser)
    parser.id = ActionParser._toAllocateId
    ActionParser._toAllocateId = ActionParser._toAllocateId + 1
end

return ActionParser

local ActionParserMap = require("logic.action.ActionParserMap")

local ActionManager = {}

function ActionManager.create(director)
    local ret = {}
    setmetatable(ret, {__index=ActionManager})
    ret:init(director)
    return ret
end

function ActionManager:init(director)
    self._director = director
    self._actionContainer = {}
    local map = {}
    setmetatable(map, {__index=ActionParserMap})
    self._parserMap = map
end

function ActionManager:update(frameIndex)
    local frameActions = self._actionContainer[frameIndex] or {}
    for _,action in ipairs(frameActions) do
        self:parse(action)
    end
end

function ActionManager:addAction(frameIndex, action)
    print(string.format("add %s:%s to ActionManager, execute in frame:%s ", action.type, action.id, frameIndex))
    self._actionContainer[frameIndex] = self._actionContainer[frameIndex] or {}
    table.insert(self._actionContainer[frameIndex], action)
end

function ActionManager:parse(action)
    local actionType = action.type
    local ParserType = self._parserMap[actionType]
    if ParserType then
        print("parse action:", action.id)
        local parser = ParserType.create(self._director, action)
        parser:doAction()
    else
        print(string.format("warning: %s %s action don't have any corresponding parser~~~~", actionType, action.id))
    end
end

return ActionManager

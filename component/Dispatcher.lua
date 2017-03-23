local Dispatcher = {}

function Dispatcher.create()
    local ret = {}
    setmetatable(ret, {__index=Dispatcher})
    ret:init()
    return ret
end

function Dispatcher:init()
    self._subscribers = {}
    self._messageQueue = {}
end

function Dispatcher:addSubscriber(subscriber)
    table.insert(self._subscribers, subscriber)
end

function Dispatcher:removeSubscriber(subscriberId)
    for i,v in ipairs(subscriberId) do
        if v.id==subscriberId then
            table.remove(self._subscribers, i)
            break
        end
    end
end

function Dispatcher:dispatch(msg)
    table.insert(self._messageQueue, msg)
    for _,subscriber in ipairs(self._subscribers) do
        subscriber:receive(msg)
    end
end

return Dispatcher

local BuffManager = {}

function BuffManager.create(owner)
    local ret = {}
    setmetatable(ret, {__index=BuffManager})
    ret:init(owner)
    return ret
end

function BuffManager:init(owner)
    self.owner = owner
    self._buffContainer = {}
end

function BuffManager:addBuff(buff)
    -- TODO 如果buff失效，添加失败；如果buff存在且可以叠加，那么叠加buff；如果buff存在且不可以叠加，那么重置buff
    if not buff:checkValid(self.owner) or self:getBuff(buff.id) then
        return false
    end
    print(self.owner.name, " add buff", buff.type, buff.id)
    table.insert(self._buffContainer, buff)
    buff:doBuff(self.owner)
    return true
end

function BuffManager:removeBuff(buffId)
    for k,buff in ipairs(self._buffContainer) do
        if buffId==buff.id then
            buff:undoBuff(self.owner)
            table.remove(self._buffContainer, k)
            return true
        end
    end
    return false
end

function BuffManager:getBuff(buffId)
    for _,buff in ipairs(self._buffContainer) do
        if buffId==buff.id then
            return buff
        end
    end
end

function BuffManager:update(globalFrameIndex)
    for i=#self._buffContainer,1,-1 do
        local buff = self._buffContainer[i]
        if buff:checkValid(self.owner) then
            buff:update(self.owner, globalFrameIndex)
        else
            self:removeBuff(buff.id)
        end
    end
end

return BuffManager

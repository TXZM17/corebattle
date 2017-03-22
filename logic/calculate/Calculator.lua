-- design for complex calculate, easy calculate should handle youself
-- you should inherit this for detail purpose
-- typical scene：calculate role state, calculate hurt effect
local PrioritySorter = require("logic.calculate.PrioritySorter")
local Calculator = {}

function Calculator.create(owner)
    local ret = {}
    setmetatable(ret, {__index=Calculator})
    ret:init(owner)
    return ret
end

function Calculator:init(owner)
    self._owner = owner
    self._components = {}
    self._context = self:createCalculateContext()
    -- default sort by priority
    self._sfFunc = PrioritySorter
end

function Calculator:calculate()
    local context = self:getOnceContext()
    local components = self._sfFunc(self._components)
    local lastResult = nil
    for _,comp in ipairs(components) do
        local continue, value = comp:calculate(context, lastResult)
        lastResult = value
        if not continue then
            break
        end
    end
    return lastResult
end

--notice: don't allow same id component,but same type component, be careful
function Calculator:addComponent(component)
    self:removeComponent(component.comp_id)
    table.insert(self._components, component)
end

function Calculator:getComponent(comp_id)
    for _,comp in ipairs(self._components) do
        if comp.comp_id == comp_id then
            return comp
        end
    end
end

function Calculator:removeComponent(comp_id)
    for i,comp in ipairs(self._components) do
        if comp.comp_id==comp_id then
            table.remove(self._components, i);
            return true
        end
    end
    return false
end

function Calculator:clearComponent()
    self._components = {}
end

function Calculator:setSorter(sfFunc)
    -- return a sorted component array
    self._sfFunc = sfFunc
end

function Calculator:initCalculateContext()
    -- return a context for calculate
    local ret = {}
    ret.hp = self._owner.context.hp
    ret.atk = self._owner.context.atk
    return ret
end

--if you won't create a sub calculator, you should set calculate context
function Calculator:setCalculateContext(context)
    self._context = context
end

function Calculator:getOnceContext()
    local ret = {}
    setmetatable(ret, {__index=self._context})
    return ret
end

return Calculator

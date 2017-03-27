-- design for complex calculate, easy calculate should handle youself
-- you should inherit this for detail purpose
-- typical scene：calculate role state, calculate hurt effect
local PrioritySorter = require("logic.calculate.PrioritySorter")
local CalculatorChain = {}

function CalculatorChain.create(owner)
    local ret = {}
    setmetatable(ret, {__index=CalculatorChain})
    ret:init(owner)
    return ret
end

function CalculatorChain:init(owner)
    self._owner = owner
    self._calculators = {}
    self._context = self._owner.context
    -- default sort by priority
    self._sfFunc = PrioritySorter
end

function CalculatorChain:calculate(proName)
    local context = self:getOnceContext()
    local involvedCalculators = filterArray(self._calculators, function(e)
        return e:involved()
    end)
    local components = self._sfFunc(involvedCalculators)
    local lastResult = nil
    for _,comp in ipairs(components) do
        local continue, value = comp:calculate(context, lastResult, proName)
        lastResult = value
        if not continue then
            break
        end
    end
    return lastResult
end

--notice: don't allow same id component,but same type component, be careful
function CalculatorChain:addComponent(component)
    self:removeComponent(component.id)
    table.insert(self._calculators, component)
end

function CalculatorChain:getComponent(comp_id)
    for _,comp in ipairs(self._calculators) do
        if comp.id == comp_id then
            return comp
        end
    end
end

function CalculatorChain:removeComponent(comp_id)
    for i,comp in ipairs(self._calculators) do
        if comp.id==comp_id then
            table.remove(self._calculators, i);
            return true
        end
    end
    return false
end

function CalculatorChain:clearComponent()
    self._calculators = {}
end

function CalculatorChain:setSorter(sfFunc)
    -- return a sorted component array
    self._sfFunc = sfFunc
end

function CalculatorChain:initCalculateContext()
    -- return a context for calculate
    local ret = {}
    ret.hp = self._owner.context.hp
    ret.atk = self._owner.context.atk
    return ret
end

--if you won't create a sub CalculatorChain, you should set calculate context
function CalculatorChain:setCalculateContext(context)
    self._context = context
end

function CalculatorChain:getOnceContext()
    -- return a writable context, will not change origin context
    local ret = {}
    setmetatable(ret, {__index=self._context})
    return ret
end

return CalculatorChain

local Calculator = require("logic.calculate.Calculator")
local IncrementCalculator = Calculator.create()

IncrementCalculator.type = "IncrementCalculator"

-- 如果加成是仅针对玩家基础值的时候，使用base*scale作为increment
function IncrementCalculator.create(increment)
    local ret = {}
    setmetatable(ret, {__index=IncrementCalculator})
    ret:init(increment)
    return ret
end

function IncrementCalculator:init(increment)
    Calculator.init(self)
    self.increment = increment
end

function IncrementCalculator:calculate(lastResult, proName, _, context)
    print("calculator:", self.type, self.id)
    if lastResult then
        lastResult = lastResult + self.increment
    else
        lastResult = context[proName] + self.increment
    end
    return true, lastResult
end

return IncrementCalculator

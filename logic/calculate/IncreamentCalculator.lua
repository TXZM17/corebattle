local Calculator = require("logic.calculate.Calculator")
local IncrementCalculator = Calculator.create()

IncrementCalculator.type = "IncrementCalculator"

function IncrementCalculator.create(increment)
    local ret = {}
    setmetatable(ret, {__index=IncrementCalculator})
    ret:init(increment)
    return
end

function IncrementCalculator:init(increment)
    Calculator.init(self)
    self.increment = increment
end

function IncrementCalculator:calculate(context, lastResult, proName)
    print("calculator:", self.type, self.id)
    if lastResult then
        lastResult = lastResult + self.increment
    else
        lastResult = context[proName] + self.increment
    end
    return true, lastResult
end

return IncrementCalculator

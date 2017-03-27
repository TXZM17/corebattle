local function PrioritySorter(calculators)
    mergeSort(calculators, function(x,y)
        return y.priority-x.priority
    end)
    return calculators
end

return PrioritySorter

local function PrioritySorter(components)
    mergeSort(components, function(x,y)
        return y.priority-x.priority
    end)
    return components
end

return PrioritySorter

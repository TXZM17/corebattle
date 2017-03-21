module("ArrayUtil", package.seeall)

function shuffle(array)
    local n = #array
    for i = 1,n do
        local j = math.random(i, n)
        array[i],array[j] = array[j],array[i]
    end
end

function filterArray(array, fn)
    local ret = {}
    for _,v in ipairs(array or {}) do
        if fn(v) then
            table.insert(ret, v)
        end
    end
    return ret
end

function mergeSort(collect, compare, i, j)
    i = i or 1
    j = j or #collect
    if i>=j then
        return
    end
    local mid = math.floor((i+j)/2)
    mergeSort(collect, compare, i, mid)
    mergeSort(collect, compare, mid+1, j)
    local p = i
    for q = mid+1, j do
        while p<=q and compare(collect[p], collect[q])<=0 do
            p = p + 1
        end
        if p>q then
            break
        end
        table.insert(collect, p, table.remove(collect, q))
        p = p+1
    end
end

function copyArray(array, startIndex, length)
    local ret = {}
    startIndex = startIndex or 1
    length = length or #array
    for i=startIndex, startIndex+length-1 do
        local item = array[i]
        if item then
            table.insert(ret, item)
        else
            break;
        end
    end
    return ret
end

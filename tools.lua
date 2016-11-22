function insertMatrix2 ( pMatrix2, pIndex1, pIndex2 , pValue )
    local matrix2 = pMatrix2

    --if not matrix2 then
        --matrix2 = {{},{}}
        --matrix2 = {{}, {}, {}}
    --end

    if not matrix2[pIndex1] then
        matrix2[pIndex1] = {}
    end
    
    if not matrix2[pIndex1][pIndex2] then
        matrix2[pIndex1][pIndex2] = {}
    end
                
    table.insert(matrix2[pIndex1][pIndex2], pValue)
end

function insertTable ( pTable, pValue )
    local resTable = pTable

    local alreadyInTable = false
    for key,value in pairs(pTable) do
        if value == pValue then
            alreadyInTable = true
        end
    end

    if alreadyInTable == false then
        table.insert(resTable, pValue)
    end
    
    return resTable
end

function loadPlateformIcon ( pPath, pPlateform )
    local bgImage = nil

    local bgFile = nil
    if pPlateform then
        bgFile = pPath..pPlateform..".png"
    end
    
    if not filesExists(bgFile) then
        bgFile = pPath.."iconError.png"
    end
    
    if filesExists(bgFile) then
        bgImage = imageLoad(bgFile)
    end

    return bgImage
end

function testTable2 ( pTable, pIndex1, pIndex2 )
    res = true
    
    if pTable then
        if pTable[pIndex1] then
            if pTable[pIndex1][pIndex2] then
                res = true
            else
                res = false
            end
        else
            res = false
        end
    else
        res = false
    end

    return res
end

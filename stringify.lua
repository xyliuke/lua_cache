function stringify(t)
    local entries = {}
    for k, v in pairs(t) do
        -- if we find a nested table, convert that recursively
        if type(v) == 'table' then
            v = stringify(v)
        else
            v = tostring(v)
        end
        k = tostring(k)
 
        -- add another entry to our stringified table
        entries[#entries + 1] = ("%s = %s"):format(k, v)
    end
 
    -- the memory location of the table
    local id = tostring(t):sub(8)
 
    return ("{%s}@%s"):format(table.concat(entries, ', '), id)
end
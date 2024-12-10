function string:split(sSeparator, nMax, bRegexp)
    if sSeparator == "" then
        sSeparator = ","
    end

    if nMax and nMax < 1 then
        nMax = nil
    end

    local aRecord = {}

    if self:len() > 0 then
        local bPlain = not bRegexp
        nMax = nMax or -1

        local nField, nStart = 1, 1
        local nFirst, nLast = self:find(sSeparator, nStart, bPlain)
        while nFirst and nMax ~= 0 do
            aRecord[nField] = self:sub(nStart, nFirst - 1)
            nField = nField + 1
            nStart = nLast + 1
            nFirst, nLast = self:find(sSeparator, nStart, bPlain)
            nMax = nMax - 1
        end
        aRecord[nField] = self:sub(nStart)
    end

    return aRecord
end

local M = {}

M.exists = function(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            return true
        end
    end
    return ok, err
end

-- https://nocurve.com/2014/03/05/simple-csv-read-and-write-using-lua/
-- specifically adapted to read only two fields and return it as a dict.
M.read = function(path, sep, tonum, null)
    tonum = tonum or true
    sep = sep or ","
    null = null or ""
    local csvFile = {}
    local file = assert(io.open(path, "r"))
    for line in file:lines() do
        local fields = line:split(sep)
        if tonum then -- convert numeric fields to numbers
            for i = 1, #fields do
                local field = fields[i]
                if field == "" then
                    field = null
                end
                fields[i] = tonumber(field) or field
            end
        end
        csvFile[fields[1]] = fields[2]
        --print(csvFile[fields[1]])
        --table.insert(csvFile, fields)
    end
    file:close()
    return csvFile
end

M.write = function(path, data, sep)
    sep = sep or ","
    local file = assert(io.open(path, "w"))
    for key, val in pairs(data) do
        file:write(key .. sep .. tostring(val) .. "\n")
    end
    file:close()
end

return M

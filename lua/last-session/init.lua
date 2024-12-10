local M = {}
M.var = {}

M.path_csv = debug.getinfo(1, "S").source:sub(2):match("^(.*[/\\])") .. "savefile.csv"

local csv = require("simplecsv")

if not csv.exists(M.path_csv) then
    os.execute("touch " .. M.path_csv)
end

M.save = function()
    csv.write(M.path_csv, M.var)
end

M.load = function()
    M.var = csv.read(M.path_csv)
end

M.setup = function()
    M.load()
end

return M

local M = {}

M.var = {}
M.default_savefile = debug.getinfo(1, "S").source:sub(2):match("^(.*[/\\])") .. "savefile.csv"

local csv = require("last-session.simplecsv")

M.save = function(path)
    csv.write(path, M.var)
end

M.load = function(path)
    M.var = csv.read(path)
end

M.setup = function(path)
    path = path or M.default_savefile
    if not csv.exists(path) then
        os.execute("touch " .. path)
    end
    M.load(path)
end

return M

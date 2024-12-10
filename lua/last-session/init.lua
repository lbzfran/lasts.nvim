local M = {}

M.var = {}
M.default_savefile = debug.getinfo(1, "S").source:sub(2):match("^(.*[/\\])") .. "savefile.csv"

local csv = require("last-session.simplecsv")

M.save = function()
    csv.write(M.savefile, M.var)
end

M.load = function()
    M.var = csv.read(M.savefile)
end

M.setup = function()
    M.savefile = M.savefile or M.default_savefile
    if not csv.exists(M.savefile) then
        os.execute("touch " .. M.savefile)
    end
    M.load()
end

return M

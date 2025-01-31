local M = {}

M.var = {}

local data_path = vim.fn.stdpath("data")
M.default_savefile = string.format("%s/%s.csv", data_path, "lasts_savefile")

local csv = require("lasts.simplecsv")

M.save = function()
    csv.write(M.savefile, M.var)
end

M.load = function()
    M.var = csv.read(M.savefile)
end

M.read = function(key)
    return M.var[key]
end

M.readall = function()
    print("Key-Value Pairs currently stored:")
    for key, val in pairs(M.var) do
        print(key .. ": " .. val)
    end
end

M.setup = function()
    M.savefile = M.savefile or M.default_savefile
    if not csv.exists(M.savefile) then
        os.execute("touch " .. M.savefile)
    end
    M.load()

    vim.api.nvim_create_user_command("Lasts", function(opts)
        if next(opts.fargs) ~= nil then
            local res = M.read(opts.args)
            if res ~= nil then
                print(opts.args .. ": " .. res)
            else
                print(opts.args .. ": nil")
            end
        else
            M.readall()
        end
    end, { nargs = "*" })
end

return M

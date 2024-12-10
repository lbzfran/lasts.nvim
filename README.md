
# Introduction

This is a helper plugin that saves lua variables across sessions.

Currently, I am just using this to save my last theme,
remember the last file I editted, and so on.

Limitations:
- I limited data storing to key and value only.
- This is not a secure solution to saving any sensitive information.

Example:
key1,value1
key2,value2

# Setup

Using lazy.nvim:
```lua
return {
  "lbzfran/last-session.nvim",
  config = function()
    local lasts = require('last-session')

    -- change path of saved variables.
    -- defaults to directory of plugin.
    lasts.savefile = '...'

    lasts.setup()
  end,
}
```

After calling the setup function, all the variables can be accessed as such:
```lua
-- store a value.
lasts.var.theme = 'rose-pine'

-- make sure to save the changes afterwards
-- this will replace the contents of the savefile with all of the key-value pairs
-- of the lasts.var dictionary.
lasts.save()

-- access the value.
vim.set.colorscheme(lasts.var.theme)
```

-- local awful     = require("awful")
-- local wibox     = require("wibox")
-- local beautiful = require("beautiful")
-- local radical   = require("radical")
-- local common    = require("otto.common")
local items     = require("items")

local module = {}

-- local function run(data)
--     local tags = awful.tag.gettags(1)
--     awful.util.spawn(data.command)
--     if tags[data.tag] then 
--         awful.tag.viewonly(tags[data.tag]) 
--     end
--     common.hide_menu(module.menu_qmapp)
-- end

for _,v in pairs(items) do
    local function submenu(t)
        if t.isSubMenu then
            for _,w in pairs(t.subMenu) do
                submenu(w)
            end
            print()
        else
            print(t.name, t.cmd)
        end
    end
    submenu(v)

end

local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("widgets.common")
local items     = require("widgets.launcher.items")

local module = {}

module.config = {
    icons = awful.util.getdir("config").."/widgets/launcher/icons/",
}

-- Action
local function run(data)
    local tags = awful.tag.gettags(1)
    awful.util.spawn(data.command)
    if tags[data.tag] then awful.tag.viewonly(tags[data.tag]) end
    common.hide_menu(module.menu_qapp)
end

-- Main menu builder
module.menu_mapp = false
function module.main_mapp()
    if not module.menu_mapp then
        module.menu_mapp = radical.context({screen = s, arrow_type=radical.base.arrow_type.NONE})
        local function submenu(t)
            local items = radical.context()
            for _,v in ipairs(t) do
                items:add_item({
                    text = v.name,
                    button1 = function()
                        awful.util.spawn(v.command)
                        common.hide_menu(module.menu_mapp)
                    end,
                    icon = module.config.icons.."/app/"..v.icon 
                })
            end
            return items
        end
        for k,v in pairs(items.mapp) do
            module.menu_mapp:add_item({
                sub_menu = submenu(v.items),
                text = k,
                icon = module.config.icons..v.icon
            })
        end
        common.reg_menu(module.menu_mapp,60)
    elseif module.menu_mapp.visible then
        common.hide_menu(module.menu_mapp)
    else
        common.show_menu(module.menu_mapp)
    end
end

-- Quick menu builder
module.menu_qapp = false
function module.main_qapp()
    if not module.menu_qapp then
        module.menu_qapp = radical.context({
            filer = false, enable_keyboard = true, direction = "bottom", x = 105,
            y = screen[mouse.screen].geometry.height - 0 - ((#awful.util.table.keys(items.qapp))*beautiful.menu_height) - 22
        })
        for k,v in pairs(items.qapp) do
            module.menu_qapp:add_key_hook({}, string.lower(v.key), "press", function() run(v) end)
            module.menu_qapp:add_item({
                button1 = function() run(v) end,
                text = k or "N/A", 
                underlay = string.upper(v.key),
                icon = module.config.icons.."/quick/"..v.icon
            })
        end
        common.reg_menu(module.menu_qapp)
    elseif module.menu_qapp.visible then
        common.hide_menu(module.menu_qapp)
    else
        common.show_menu(module.menu_qapp)
    end
end

-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()
--    layout:add(common.imagebox({icon=beautiful.dist_icon}))
    layout:add(common.textbox({text="MENU", width=50, b1=module.main_qapp, b3=module.main_mapp }))
--    layout:add(common.arrow(1))
    return layout
end

module.mainMenu = radical.context{arrow_type = radical.base.arrow_type.NONE,
                            border_width = 0}

module.mainMenu:add_item {text = "System"}


return setmetatable(module, { __call = function(_, ...) return new(...) end })

local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local radical   = require("radical")
local common    = require("widgets.common")
local layouts   = require("widgets.layout.layouts")

local module = {}

local config = {
    icons = awful.util.getdir("config").."/widgets/layout/icons/"
}

-- Layouts table
module.layouts = {
    awful.layout.suit.floating,          -- 1
    awful.layout.suit.tile,              -- 2
    awful.layout.suit.tile.left,         -- 3
    awful.layout.suit.tile.bottom,       -- 4
    awful.layout.suit.tile.top,          -- 5
    awful.layout.suit.fair,              -- 6
    awful.layout.suit.fair.horizontal,   -- 7
    awful.layout.suit.max,               -- 8
    awful.layout.suit.max.fullscreen,    -- 9
    --layouts.centerwork,                  -- 10
    --layouts.cascadebrowse,               -- 11
    --layouts.gaps,                        -- 12
}

-- Layout switcher (centered menu)
function module.switch(s)
    local s = s or 1
    module.mswitch = radical.box({ 
        screen = s, enable_keyboard = true,
        layout = radical.layout.grid,
        item_style = radical.item.style.rounded,
        column = 6, row = 2, item_height = 64, item_width = 64,
    })
    module.mswitch:add_key_hook({}, "Tab", "press", function()
        local item = module.mswitch.next_item
        item.selected = true
        item.button1()
        return true
    end)
    for _,v in pairs(module.layouts) do
        module.mswitch:add_item({
            button1 = function() awful.layout.set(v, awful.tag.selected()) end,
            icon = config.icons..(v.name..".png")
        })
    end
    module.mswitch.visible = true
end

-- Layout switcher
module.menu = false
function module.main()
    if not module.menu then
        module.menu = radical.context({
            enable_keyboard = true, direction = "bottom", x = 15,
            y = screen[1].geometry.height - beautiful.wibox.height - (#module.layouts*beautiful.menu_height) - 22
        })
        -- Add items
        for i,l in ipairs(module.layouts) do
            local name = awful.layout.getname(l)
            module.menu:add_item({
                icon = config.icons..(name..".png"),
                text = name:gsub("^%l", string.upper),
                button1 = function()
                    awful.layout.set(l, awful.tag.selected())
                    common.hide_menu(module.menu)
                end,
                selected = (l == awful.layout.get(1)),
                underlay = i,
            })
        end
        common.reg_menu(module.menu)
    elseif module.menu.visible then
        common.hide_menu(module.menu)
    else
        common.show_menu(module.menu)
    end
end

-- Return widgets layout
local function new(s)
    local layout = wibox.layout.fixed.horizontal()
    local widget,img = common.imagebox({icon=config.icons..awful.layout.getname(awful.layout.get(s))..".png"})

    -- Update layout icon
    local function update_layout_icon()
        img:set_image(config.icons..awful.layout.getname(awful.layout.get(s))..".png")
    end

    -- Signals to update layout icon
    awful.tag.attached_connect_signal(s, "property::selected", update_layout_icon)
    awful.tag.attached_connect_signal(s, "property::layout",   update_layout_icon)

    -- Add widgets to layout
    layout:add(widget)
    layout:add(common.textbox({ text="LAYOUT", width=60, b1=module.main }))
    layout:add(common.arrow(2))
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
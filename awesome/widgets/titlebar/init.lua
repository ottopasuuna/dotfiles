local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local radical   = require("radical")
local client = client

local module = {}
local item = {}

-- Reload <float> <ontop> <sticky> and <tile> labels
local function reload_underlay(c)
    if item[c] then
        local udl = {}
        if c.ontop then
            udl[#udl+1] = "ontop"
        end
        if awful.client.floating.get(c) then
            udl[#udl+1] = "float"
        else
            udl[#udl+1] = "tile"
        end
        if c.sticky then
            udl[#udl+1] = "sticky"
        end
        
        item[c].underlay = udl
        item[c]:emit_signal("widget::updated")
    end
end

local function title(c)
    
end

local function new(c)
    local buttons_layout = wibox.layout.fixed.horizontal()
    module.title = radical.flexbar({
        --select_on = radical.base.event.NEVER,
        disable_markup = true,
        underlay_style = radical.widgets.underlay.draw_arrow,
        bg = beautiful.tasklist_bg,
        fg = beautiful.tasklist_fg,
        underlay_bg = tasklist_underlay_bg
    })

    -- Add title and icon.
    item[c] = module.title:add_item({ icon = c.icon, text = c.name })
    reload_underlay(c)

    --module.title:set_underlay({"sss"})
    module.title._internal.layout:set_underlay("sss")

    -- Buttons for the titlebar
    module.title._internal.layout:buttons(awful.util.table.join(
        awful.button({ }, 1, function() awful.mouse.client.move(c)   end),
        awful.button({ }, 3, function() awful.mouse.client.resize(c) end)
    ))

    -- Buttons
    buttons_layout:add(awful.titlebar.widget.maximizedbutton(c))
    buttons_layout:add(awful.titlebar.widget.stickybutton(c))
    buttons_layout:add(awful.titlebar.widget.ontopbutton(c))
    buttons_layout:add(awful.titlebar.widget.closebutton(c))

    -- Now bring it all together
    local layout = wibox.layout.align.horizontal()
    layout:set_left(awful.titlebar.widget.floatingbutton(c))
    layout:set_middle(module.title._internal.layout)
    layout:set_right(buttons_layout)

    -- Add titlebar to the client
    awful.titlebar(c, { size = 14 }):set_widget(layout)

    -- Update underlay
    c:connect_signal("unmanage",           function(c) item[c], module.title = nil,nil end)
    c:connect_signal("property::sticky",   function(c) reload_underlay(c) end)
    c:connect_signal("property::ontop",    function(c) reload_underlay(c) end)
    c:connect_signal("property::floating", function(c) reload_underlay(c) end)
    c:connect_signal("property::name",     function(c)
        item[c].text = c.name
        item[c]:emit_signal("widget::updated")
    end)
    
    c:connect_signal("property::urgent",     function(c) 
        --item[c].underlay_bg = beautiful.tasklist_underlay_bg_urgent
        --item[c].text = "test"
        item[c].bg = "#CFE700"
        item[c]:emit_signal("widget::updated")
    end)
    c:connect_signal("focus",       function(c)
        item[c].bg = "#00FF4A"
        item[c]:emit_signal("widget::updated")
    end)
    c:connect_signal("unfocus",     function(c)
        item[c].bg = "#FF544A"
        item[c]:emit_signal("widget::updated")
    end)
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
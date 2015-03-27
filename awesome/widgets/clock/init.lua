local awful     = require("awful")
local wibox     = require("wibox")
local common    = require("widgets.common")
local beautiful = require("beautiful")

local module = {}

local function new(args)
    local clock = awful.widget.textclock(string.format("<span font='%s' color='%s'>%s</span>", "Crashed Scoreboard 17", beautiful.widget.fg, "%H %M"), 60)
    local layout = wibox.layout.fixed.horizontal()
    clock:set_align("center")
    clock:set_valign("center")
    clock.fit = function() return 62,10 end
    layout:add(common.arrow(3))
    layout:add(wibox.widget.background(clock, beautiful.widget.bg))

    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
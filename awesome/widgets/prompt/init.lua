local awful     = require("awful")
local beautiful = require("beautiful")
local naughty   = require("naughty")
--local fd_async  = require("awful.fd_async")
local duck      = require("widgets.prompt.duckduckgo")

local module = {}
module.theme = {
    fg_cursor = beautiful.prompt.fg_cursor,
    bg_cursor = beautiful.prompt.bg_cursor, 
    ul_cursor = beautiful.prompt.ul_cursor, 
    font      = beautiful.prompt.font, 
}

module.prompt = awful.widget.prompt()

-- Search DuckDuckGo
function module.duck()
    module.theme.prompt = "<span foreground='#1692D0' font='Sci Fied 8'>duck:</span> "
    awful.prompt.run(
        module.theme, module.prompt.widget,
        function(str) duck(str) end,
        awful.util.getdir("cache").. "/history_duck", 50
    )
end

-- Command prompt
function module.run()
    module.theme.prompt = beautiful.prompt.run
    awful.prompt.run(
        module.theme, module.prompt.widget,
        function(...) awful.util.spawn(...) end,
        awful.completion.shell,
        awful.util.getdir("cache").. "/history_run", 50
    )
end

-- TODO: Run in terminal and output as notification
function module.cmd()
    module.theme.prompt = beautiful.prompt.cmd
    awful.prompt.run(
        module.theme, module.prompt.widget,
        --function(cmd) duck(cmd) end,
        awful.completion.shell,
        awful.util.getdir("cache").. "/history_cmd", 50
    )
end

-- TODO: Lua prompt
function module.lua()
    module.theme.prompt = beautiful.prompt.lua
    awful.prompt.run(
        module.theme, module.prompt.widget,
        awful.util.eval, 
        nil,
        awful.util.getdir("cache").. "/history_eval", 50
    )
end

local function new()
    return module.prompt
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
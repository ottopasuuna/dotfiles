-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
-- awful.indicator = require("awful.indicator")
local fd_async = require("awful.fd_async")

require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local lain = require("lain")
local radical = require("radical")
require("eminent")
-- local menutest = require("menu")


local widgets = require("widgets")

-- {{{ Error handling ******************************************************
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}} ____________________________________________________________________

--{{{Autostart applications

do 
    local commands = {
        "owncloud",
        "mpd",
        "xscreensaver"
    }

    for _,i in pairs(commands) do
        awful.util.spawn(i)
    end
end

--}}}

-- {{{ Variable definitions **************************************************
-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .. "/themes/ottopasuuna/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
terminal_cmd = terminal .. " -e zsh -c '~/bin/zsh_tmux.sh'"
editor = "vim" 
editor_cmd = terminal .. " -e " .. editor
inetbrowser = "firefox-nightly"
emailclient = "thunderbird"
filemanager = terminal .. " -e ranger"

modkey = "Mod4"
altkey = "Mod1"

--User defined:

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    awful.layout.suit.floating,
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}} _____________________________________________________________________

-- {{{ Tags **************************************************************
-- Define a tag table which hold all screen tags.
tags = {
    names={"1","2","3","4","5","6","7","8","9"}
}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, layouts[1])
end
-- }}} ____________________________________________________________________

-- {{{ Menu
mainMenu = radical.context{arrow_type = radical.base.arrow_type.NONE,
                           border_width = 0}

officeMenu = radical.context{}
gameMenu = radical.context{}
awesomeMenu = radical.context{}
systemMenu = radical.context{}

-- Office Programs
officeMenu:add_item {text = "Writer", button1 = function() awful.util.spawn('libreoffice --writer') end}
officeMenu:add_item {text = "Calc", button1 = function() awful.util.spawn('libreoffice --calc') end}
officeMenu:add_item {text = "Gimp", button1 = function() awful.util.spawn('gimp') end}

-- Games Launcher
gameMenu:add_item {text = "oolite", button1 = function() awful.util.spawn('oolite') end}
gameMenu:add_item {text = "Steam", button1 = function() awful.util.spawn('steam') end}
gameMenu:add_item {text = "SuperTuxKart", button1 = function() awful.util.spawn('supertuxkart') end}
gameMenu:add_item {text = "Xonotic", button1 = function() awful.util.spawn('xonotic-glx') end}

-- Control Awesome WM
awesomeMenu:add_item {text = "Edit Config", button1 = function() 
                      awful.util.spawn(terminal..' -e vim ~/.config/awesome/rc.lua') end }
awesomeMenu:add_item {text = "Restart", button1 = awesome.restart }
awesomeMenu:add_item {text = "Quit", button1 = awesome.quit }

--System Menu (power off, sleep, reboot)
systemMenu:add_item {text = "Sleep", button1 = function() mainMenu.visible=false; os.execute("systemctl suspend")  end }

mainMenu:add_item {text = "Office", sub_menu = officeMenu}
mainMenu:add_item {text = "Games", sub_menu = gameMenu}
mainMenu:add_item {text = "Awesome", sub_menu = awesomeMenu}
mainMenu:add_item {text = "System", sub_menu = systemMenu}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox

-- menu 
mylauncher = wibox.widget.imagebox(beautiful.awesome_icon)
mylauncher:set_menu(mainMenu)


-- Textclock 
mytextclock = awful.widget.textclock()


-- Calendar
calendar = lain.widgets.calendar:attach(mytextclock, {font_size=10})

--CPU
cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
cpuwidget = wibox.widget.background(lain.widgets.cpu({
  settings = function()
   widget:set_text(" " .. cpu_now.usage .. "%")
  end
}), "#313131")


--Coretemp
tempicon = wibox.widget.imagebox(beautiful.widget_temp)
tempwidget = lain.widgets.temp({
  settings = function()
   widget:set_text(" " .. coretemp_now .. "°C")
  end,
  tempfile = "/sys/class/thermal/thermal_zone2/temp"
})

--ALSA bar
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volume = lain.widgets.alsabar({
  settings = function()
    if volume_now.status == "off" then
     volicon:set_image(beautiful.widget_vol_mute)
    elseif tonumber(volume_now.level) == 0 then
     volicon:set_image(beautiful.widget_vol_no)
    elseif tonumber(volume_now.level) <= 50 then
     volicon:set_image(beautiful.widget_vol_low)
    else
     volicon:set_image(beautiful.widget_vol)
    end
  end,
  width      = 10,
  ticks      = true,
  ticks_size = 2,
  vertical   = true,
  colors     = {unmute="#00ccff"},
})

-- IMAP
mailicon   = wibox.widget.imagebox(beautiful.widget_mail)
mailwidget = lain.widgets.imap({
  timeout  = 120,
  port     = 993,
  server   = "imap.gmail.com",
  mail     = "jawaofsktoon@gmail.com",
  password = "keyring get Email jawaofsktoon",
  settings = function()
    widget:set_text(mailcount)
  end
})

-- Taskwarrior
taskicon   = wibox.widget.imagebox(beautiful.widget_task)
taskwidget = lain.widgets.contrib.task:attach(taskicon)

-- Memory
memicon = wibox.widget.imagebox(beautiful.widget_mem)
memwidget = lain.widgets.mem({
  settings = function()
    widget:set_text(mem_now.used/1000)
  end
})

-- Net
neticon    = wibox.widget.imagebox(beautiful.widget_net)
netwidget  = lain.widgets.net({
  settings = function()
     widget:set_text(net_now.sent .. "^ " .. net_now.received .. "v")
  end
})

-- Do some push-ups!! 'widget' THIS AUTOMATICALLY RUNS WHEN AWM STARTS.
pushupNag = lain.widgets.contrib.nag({
    timeout = 3600,
    message = "Do some push-ups!"
})

-- Create a wibox for each screen and add it
mywiboxtop = {}
mywiboxbottom = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywiboxtop[s] = awful.wibox({ position = "top", screen = s })
    mywiboxbottom[s] = awful.wibox({position = "bottom", screen = s})

    -- prevents compositor from putting shadow over wibox. interferes with fullscreen.
    -- mywiboxbottom[s].ontop = true

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
        
    local Bleft_layout = wibox.layout.fixed.horizontal()
    Bleft_layout:add(cpuicon)
    Bleft_layout:add(cpuwidget)
    Bleft_layout:add(tempicon)
    Bleft_layout:add(tempwidget)
    Bleft_layout:add(memicon)
    Bleft_layout:add(memwidget)
    
    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(taskicon)
    right_layout:add(mailicon)
    right_layout:add(mailwidget)
    right_layout:add(volicon)
    right_layout:add(volume.bar)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])


    local Bright_layout = wibox.layout.fixed.horizontal()
    Bright_layout:add(widgets.notifications({max_items = 10, direction = bottom_right}))

    local Bmiddle_layout = wibox.layout.fixed.horizontal()
    Bmiddle_layout:add(mypromptbox[s])

    local Blayout = wibox.layout.align.horizontal()
    Blayout:set_left(Bleft_layout)
    Blayout:set_middle(Bmiddle_layout)
    Blayout:set_right(Bright_layout)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywiboxtop[s]:set_widget(layout)

	 mywiboxbottom[s]:set_widget(Blayout)
end

-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey, "Shift"   }, "Left",
      function (c)
        local curidx = awful.tag.getidx()
        if curidx == 1 then
            awful.client.movetotag(tags[client.focus.screen][#tags[client.focus.screen]])
        else
            awful.client.movetotag(tags[client.focus.screen][curidx - 1])
        end
        awful.tag.viewidx(-1)
      end),
    awful.key({ modkey, "Shift"   }, "Right",
      function (c)
        local curidx = awful.tag.getidx()
        if curidx == #tags[client.focus.screen] then
          awful.client.movetotag(tags[client.focus.screen][1])
        else
          awful.client.movetotag(tags[client.focus.screen][curidx + 1])
        end
        awful.tag.viewidx(1)
      end),

    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Volume Control
    awful.key({}, "XF86AudioRaiseVolume", 
     function()
       awful.util.spawn("amixer -q set " .. volume.channel .. " " .. volume.step .. "+") 
       volume.notify()
       end),
    awful.key({}, "XF86AudioLowerVolume", 
     function()
       awful.util.spawn("amixer -q set " .. volume.channel ..  " " .. volume.step .. "-")
       volume.notify()
       end),
    awful.key({}, "XF86AudioMute", 
      function()
        awful.util.spawn("amixer -q set " .. volume.channel .. " playback toggle")
        volume.notify()
        end),

    -- Widget hotkeys
    awful.key({modkey,            }, "t", lain.widgets.contrib.task.show),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.key({ altkey,           }, "Tab", widgets.altTab(1) ),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal_cmd) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Shift" }, "n", awful.client.restore),

	 -- Spawn User Apps
	 awful.key({modkey,            }, "i",   function () awful.util.spawn(inetbrowser) end),
	 awful.key({modkey,            }, "e",   function () awful.util.spawn(emailclient) end),
     awful.key({modkey,            }, "f",   function () awful.util.spawn(filemanager) end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey, "Shift" }, "r",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey, "Shift"   }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "w",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey, "Shift"   }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false }, callback = awful.client.setslave },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
            c:raise()
        end
    end)


    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

local awful = require("awful")
local wibox = require("wibox")
local radical = require("radical")
local beautiful = require("beautiful")

local module = {}

module.mainMenu = radical.context{}

module.officeMenu = radical.context{}
module.gameMenu = radical.context{}
module.awesomeMenu = radical.context{}
module.systemMenu = radical.context{}

-- Office Programs
module.officeMenu:add_item {text = "Writer", button1 = function() awful.util.spawn('libreoffice --writer') end}
module.officeMenu:add_item {text = "Calc", button1 = function() awful.util.spawn('libreoffice --calc') end}

-- Games Launcher
module.gameMenu:add_item {text = "oolite", button1 = function() awful.util.spawn('oolite') end}
module.gameMenu:add_item {text = "Steam", button1 = function() awful.util.spawn('steam') end}

-- Control Awesome WM
module.awesomeMenu:add_item {text = "nottest", button1 = function() 
                        naughty.notify({preset = naughty.config.presets.critical,
                                        title = "Title",
                                        text = "Here some text" }) end }
module.awesomeMenu:add_item {text = "Edit Config", button1 = function() 
                      awful.util.spawn(terminal..' -e vim ~/.config/awesome/rc.lua') end }
module.awesomeMenu:add_item {text = "Restart", button1 = awesome.restart }
module.awesomeMenu:add_item {text = "Quit", button1 = awesome.quit }

--System Menu (power off, sleep, reboot)
module.systemMenu:add_item {text = "Sleep", button1 = function() module.mainMenu.visible=false; os.execute("systemctl suspend")  end }

module.mainMenu:add_item {text = "Office", sub_menu = module.officeMenu}
module.mainMenu:add_item {text = "Games", sub_menu = module.gameMenu}
module.mainMenu:add_item {text = "Awesome", sub_menu = module.awesomeMenu}
module.mainMenu:add_item {text = "System", sub_menu = module.systemMenu}


return module

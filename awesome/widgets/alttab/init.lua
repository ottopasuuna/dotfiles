local tag  = require("awful.tag").viewonly
local menu = require("radical.box")

local module = {}

module.menu = {}
local function new(s,w)
    local s = s or 1
    local w = w or 400
    local cls = client.get(s)
    if #cls > 1 then -- run alt-tab behavior when there is more than one client running.
        module.menu = menu({ disable_markup = true, width = w })
        -- Keybindings
        module.menu:add_key_hook({}, "Tab", "press", function()
            local item = module.menu.next_item
            item.selected = true
            item.button1()
            return true
        end)
        module.menu:add_key_hook({}, "Alt_L", "release", function()
            local item = module.menu._current_item
            item.button1()
            module.menu.visible = false
            return true
        end)
        for _,v in pairs(cls) do
            local t = v:tags()[s]
            module.menu:add_item({
                button1 = function()
                    if not t.selected then tag(t) end
                    client.focus = v
                    v:raise()
                end,
                text = (v.name or "N/A"), icon = v.icon,
                selected = client.focus == v, underlay = t.name
            })
        end
        module.menu.visible = true
    end
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
-- Grab environment.
local math     = math
local awful     = require("awful")

local layout = {}

-- Set layout name
layout.name = "centerwork"

local top_left = 0
local top_right = 1
local bottom_left = 2
local bottom_right = 3

function layout.arrange(p)
    -- Screen.
    local wa = p.workarea
    local cls = p.clients

    -- Width of main column?
    local t = awful.tag.selected(p.screen)
    local mwfact = awful.tag.getmwfact(t)

    if #cls > 0 then
        -- Main column, fixed width and height.
        local c = cls[#cls]
        local g = {}
        local mainwid   = math.floor(wa.width * mwfact)
        local slavewid  = wa.width - mainwid
        local slaveLwid = math.floor(slavewid / 2)
        local slaveRwid = slavewid - slaveLwid
        local slaveThei = math.floor(wa.height / 2)
        local slaveBhei = wa.height - slaveThei

        g.height = wa.height
        g.width  = mainwid
        g.x = wa.x + slaveLwid
        g.y = wa.y

        c:geometry(g)

        -- Auxiliary windows.
        if #cls > 1 then
            local at = 0
            for i = (#cls - 1),1,-1 do
                -- It's all fixed. If there are more than 5 clients,
                -- those additional clients will float. This is intentional.
                if at == 4 then
                    break
                end

                local c = cls[i]
                local g = {}
                local bw = cls[i].border_width
                if at == top_left then -- top left
                    g.x = wa.x
                    g.y = wa.y
                    g.width = slaveLwid - bw
                    g.height = slaveThei - bw
                elseif at == top_right then
                    g.x = wa.x + slaveLwid + mainwid
                    g.y = wa.y
                    g.width = slaveRwid - bw
                    g.height = slaveThei - bw
                elseif at == bottom_left then
                    g.x = wa.x
                    g.y = wa.y + slaveThei
                    g.width = slaveLwid - bw
                    g.height = slaveBhei - bw
                elseif at == bottom_right then
                    g.x = wa.x + slaveLwid + mainwid
                    g.y = wa.y + slaveThei
                    g.width = slaveRwid - bw
                    g.height = slaveBhei - bw
                end

                c:geometry(g)

                at = at + 1
            end

            -- Set remaining clients to floating.
            for i = (#cls - 1 - 4),1,-1 do
                c = cls[i]
                awful.client.floating.set(c, true)
            end
        end
    end
end

return layout

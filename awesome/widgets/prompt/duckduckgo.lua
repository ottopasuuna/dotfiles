-- loads the HTTP module and any libraries it requires
local http    = require("socket.http")
local json    = require("widgets.prompt.dkjson")
local awful   = require("awful")
local naughty = require("naughty")

--[[

http://api.duckduckgo.com/?q=DuckDuckGo&format=json&pretty=1
http://w3.impa.br/~diego/software/luasocket/http.html

]]

local module = {}
module.conf = {
    timeout = 30,
    browser = "firefox"
}
-- Wrap a string at a given margin
function wrap(str, limit, indent, indent1)
    indent = indent or ""
    indent1 = indent1 or indent
    limit = limit or 72
    local here = 1-#indent1
    return indent1..str:gsub("(%s+)()(%S+)()",
                             function(sp, st, word, fi)
                                 if fi-here > limit then
                                     here = st - #indent
                                     return "\n"..indent..word
                                 end
    end)
end

local function new(str)
    local search, text, title, url = str or "DuckDuckGo"
    local source = http.request("http://api.duckduckgo.com/?q="..search.."&format=json")
    local obj = json.decode(source)
    if obj then
        if obj.AbstractSource and obj.AbstractText ~= "" then
            text = wrap(obj.AbstractText)
            title = obj.AbstractSource
            url = obj.AbstractURL
        elseif obj.DefinitionSource and obj.Definition ~= "" then
            text = wrap(obj.Definition)
            title = obj.DefinitionSource
            url = obj.DefinitionURL
        else
            naughty.notify({ title = "DuckDuckGo", text = "No results.", timeout = 2 })
            return
        end
        naughty.notify({ 
            title = title, text = text, timeout = 30, 
            run = function() awful.util.spawn(module.conf.browser.." "..url) end
        })
    else
        naughty.notify({ title = "DuckDuckGo", text = "Search failed", timeout = 2 })
    end
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })

-- capture.lua
-- Lua Script Capture Logger

print("Capture logger enabled")

local oldLoadstring = loadstring
local oldHttpGet = game.HttpGet
local count = 0

local function save(prefix, content)
    count = count + 1
    local name = prefix .. "_" .. count .. ".lua"
    writefile(name, content)
    print("Saved:", name)
end

-- Hook loadstring
getgenv().loadstring = function(code)
    save("loadstring", code)
    return oldLoadstring(code)
end

-- Hook HttpGet
game.HttpGet = function(self, url)
    print("Fetching:", url)

    local result = oldHttpGet(self, url)

    save("httpget", result)

    return result
end

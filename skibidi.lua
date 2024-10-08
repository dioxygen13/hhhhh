local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
    Name = "free items lol - made by @peculiarpeculiar",
    LoadingTitle = "ez",
    LoadingSubtitle = "hino production",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "hawk twah",
        FileName = "item Hub"
    },
    KeySystem = false,
    KeySettings = {
        Title = "Sirius Hub",
        Subtitle = "Key System",
        Note = "Join the discord (discord.gg/sirius)",
        SaveKey = true,
        Key = "ABCDEF"
    }
})

Rayfield:Notify({
    Title = "Welcome",
    Content = "ya",
    Duration = 6.5,
    Image = 4483362458,
})

local Tab = Window:CreateTab("Main", 4483362458)

-- Store toggle states for item toggles (moved above the functions)
local itemToggles = {
    ["SUKUNA'S FINGER"] = false,
    ["TRUE WAR REMNANT"] = false,
    ["FORGOTTEN ORB"] = false,
    ["VOID KEY"] = false,
    ["PROSTHETIC ARM"] = false,
    ["SLEEPING MEDICINE"] = false,
    ["INVERTED SPEAR OF HEAVEN"] = false,
    ["JET BLACK BLADE"] = false,
    ["DRAGONBONE"] = false
}

-- Section for Enable Teleport Steal (moved above Item Toggles)
local SectionTeleport = Tab:CreateSection("Steal")

local teleporting = false
local originalCFrame

local function teleportIfBagMatches()
    local player = game.Players.LocalPlayer
    local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    local effects = game.Workspace:FindFirstChild("Effects")
    if effects then
        local bag = effects:FindFirstChild("Bag")
        if bag and bag:FindFirstChild("Info") and bag.Info:FindFirstChild("TextLabel") then
            local bagText = string.upper(bag.Info.TextLabel.Text)
            for itemName, isEnabled in pairs(itemToggles) do
                if isEnabled and bagText == itemName then
                    -- Continuously teleport until item is no longer detected
                    local startTime = tick()
                    while tick() - startTime < 2 do -- Loop for 2 seconds
                        if not effects:FindFirstChild("Bag") then
                            break -- Stop when the item is picked up (no longer detected)
                        end
                        humanoidRootPart.CFrame = bag.CFrame
                        wait(0.1) -- Teleport repeatedly with a small delay
                    end
                    humanoidRootPart.CFrame = originalCFrame -- Teleport back to the original position
                    break -- Exit loop after teleporting
                end
            end
        end
    end
end

-- Create the "Enable Teleport Steal" toggle
local ToggleTeleport = Tab:CreateToggle({
    Name = "Steal",
    CurrentValue = false,
    Flag = "Steal",
    Callback = function(Value)
        teleporting = Value
        local player = game.Players.LocalPlayer
        local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if teleporting and humanoidRootPart then
            originalCFrame = humanoidRootPart.CFrame

            spawn(function()
                while teleporting do
                    teleportIfBagMatches()
                    wait(0.01)
                end
            end)
        end
    end
})

-- Section for Item Toggles
local SectionItems = Tab:CreateSection("Item Toggles")

-- Create toggles for each item
for itemName, _ in pairs(itemToggles) do
    Tab:CreateToggle({
        Name = itemName,
        CurrentValue = false,
        Flag = itemName,
        Callback = function(Value)
            itemToggles[itemName] = Value
        end
    })
end

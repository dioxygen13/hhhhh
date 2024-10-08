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

-- Section for Item Toggles
local SectionItems = Tab:CreateSection("Item Toggles")

-- Store toggle states for item toggles
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
                    humanoidRootPart.CFrame = bag.CFrame
                    wait(2)
                    humanoidRootPart.CFrame = originalCFrame
                end
            end
        end
    end
end

local Toggle = Tab:CreateToggle({
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
                    wait(0.2)
                end
            end)
        end
    end
})

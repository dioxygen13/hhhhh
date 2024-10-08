


local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")




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

Rayfield:Notify("welcome", "ya", 4483362458)

local Tab = Window:CreateTab("main", 4483362458)

local Section = Tab:CreateSection("stuff")

local teleporting = false
local connectaa
local originalCFrame


local function sendToWebhook(itemName)
    local data = {
        ["content"] = "picked up: **"..itemName.."**",
        ["username"] = "hawk tuah bot"
    }
    local jsonData = HttpService:JSONEncode(data)
    
    request({
        Url = webhook,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = jsonData
    })
end

local Toggle = Tab:CreateToggle({
    Name = "Steal",
    CurrentValue = false,
    Flag = "Steal",
    Callback = function(Value)
        teleporting = Value
        local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if teleporting and humanoidRootPart then
            originalCFrame = humanoidRootPart.CFrame

            spawn(function()
                while teleporting do
                    local effects = game.Workspace:FindFirstChild("Effects")
                    if effects then
                        local bag = effects:FindFirstChild("Bag")
                        if bag and bag:FindFirstChild("Info") and bag.Info:FindFirstChild("TextLabel") then
                            local labelText = string.upper(bag.Info.TextLabel.Text)
                            
                            
                            if table.find(validitems, labelText) then
                                humanoidRootPart.CFrame = bag.CFrame

                                local itemPickedUp = false
                                
                                if connectaa then
                                    connectaa:Disconnect()
                                end

                                connectaa = player.Backpack.ChildAdded:Connect(function(item)
                                    local itemName = string.upper(item.Name)
                               
                                    if teleporting and table.find(validitems, itemName) then
                                        itemPickedUp = true
                                        humanoidRootPart.CFrame = originalCFrame
                                        sendToWebhook(item.Name) 
                                    end
                                end)

                                wait(2)

                                if not itemPickedUp then
                                    humanoidRootPart.CFrame = originalCFrame
                                end
                            end
                        end
                    end
                    wait(0.01)
                end
            end)
        else
            if connectaa then
                connectaa:Disconnect()
            end
        end
    end,
})

--[[
  ═══════════════════════════════════════════════════════════════
  HYBRID ADMIN v7.0 — PERSONAL ASSISTANT EDITION (FIXED)
  ═══════════════════════════════════════════════════════════════
  ★ PERSONAL ASSISTANT (Type 'open' or '/assistant' to spawn)
  ★ TRUE X-RAY (See through walls)
  ★ ESP (Boxes, Names, Health Bars, Distance)
  ★ BRING ALL (Teleport all players/rigs to you)
  ★ 180+ COMMANDS with ALIASES
  ★ RIG SUPPORT (All commands work on rigs/NPCs)
  ★ ASSISTANT KILL COMMAND (/akill @name)
  ═══════════════════════════════════════════════════════════════
]]

-- ==================== SERVICES ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local GroupService = game:GetService("GroupService")
local Teams = game:GetService("Teams")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")
local Chat = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")

-- ==================== CONFIGURATION ====================
local Config = {
    Prefix = "/",
    Logging = true,
    AntiExploit = true,
    MaxSpeed = 50,
    MaxJumpPower = 80,
    MaxFlySpeed = 120,
    BanList = {},
    MuteList = {},
    FreezeList = {},
    GodList = {},
    FlyList = {},
    InvisList = {},
    NoclipList = {},
    ESPList = {},
    XRayList = {},
    BringAllCooldown = {},
    RigList = {},
    
    -- Assistant Config
    AssistantName = "PersonalAssistant",
    AssistantWalkSpeed = 25,
    AssistantJumpPower = 60,
    AssistantFollowDistance = 30,
    AssistantAttackDistance = 5,
    
    Ranks = {
        ["Creator"] = {Level = 5, Commands = "*", Color = Color3.fromRGB(255, 215, 0)},
        ["Owner"]   = {Level = 4, Commands = "*", Color = Color3.fromRGB(255, 50, 50)},
        ["Admin"]   = {Level = 3, Commands = "*", Color = Color3.fromRGB(0, 200, 255)},
        ["Mod"]     = {Level = 2, Commands = {
            "kick","mute","unmute","tp","bring","goto","here","bringall",
            "tools","clear","reset","heal","freeze","unfreeze",
            "smite","explode","logs","whois","online","ping","esp","xray",
            "rig","rigs","rigkill","rigtp","rigbring","rigfreeze","rigunfreeze",
            "righeal","rigrevive","rigclone","rigremove","rigexplode","rigsmite",
            "assistant","open","close","toggle","akill","ak"
        }, Color = Color3.fromRGB(50, 255, 50)},
        ["User"]    = {Level = 1, Commands = {
            "me","report","help","ping","uptime","stats","players",
            "assistant","open","close","toggle"
        }, Color = Color3.fromRGB(200, 200, 200)}
    },
    Owners = {1, 2}
}

-- ==================== ALIAS SYSTEM ====================
local Aliases = {
    -- Teleportation
    t = "tp", tele = "tp", teleport = "tp",
    b = "bring", br = "bring",
    g = "goto", go = "goto",
    h = "here", 
    at = "alltp", alltele = "alltp",
    ba = "bringall", bringall = "bringall",
    tpall = "bringall",
    summon = "bring",
    warp = "tp",
    
    -- Player Management
    k = "kick", 
    bn = "ban", 
    ub = "unban",
    m = "mute", 
    um = "unmute",
    fr = "freeze", 
    uf = "unfreeze",
    
    -- Combat
    sm = "smite", 
    ex = "explode", 
    exp = "explode",
    kill = "kill", 
    revive = "revive", 
    heal = "heal",
    god = "god", 
    ungod = "ungod",
    hp = "heal",
    health = "heal",
    
    -- Movement
    fly = "fly", 
    unfly = "unfly",
    noclip = "noclip", 
    nc = "noclip",
    unclip = "unclip",
    speed = "speed", 
    jp = "jumppower",
    ws = "speed",
    walkspeed = "speed",
    jump = "jumppower",
    
    -- Vision
    esp = "esp", 
    xray = "xray", 
    vis = "vis", 
    invis = "invis",
    hide = "invis",
    show = "vis",
    godmode = "god",
    ungodmode = "ungod",
    
    -- Tools
    give = "give", 
    tools = "tools", 
    clear = "clear", 
    reset = "reset",
    re = "reset",
    char = "reset",
    clone = "clones",
    clones = "clones",
    copy = "clones",
    
    -- Environment
    day = "day", 
    night = "night", 
    fog = "fog", 
    time = "time",
    rain = "rain", 
    thunder = "thunder",
    lightning = "thunder",
    storm = "thunder",
    weather = "rain",
    darkness = "night",
    sunlight = "day",
    bright = "day",
    dark = "night",
    
    -- Utility
    logs = "logs", 
    whois = "whois", 
    online = "online",
    ping = "ping", 
    stats = "stats", 
    me = "me",
    report = "report", 
    help = "help",
    admin = "admin", 
    shutdown = "shutdown",
    rejoin = "rejoin", 
    serverhop = "serverhop",
    playtime = "playtime", 
    rank = "rank",
    setrank = "setrank", 
    uptime = "uptime",
    cmds = "commands", 
    cmdlist = "commands",
    pl = "players", 
    playerlist = "players",
    brake = "break",
    unbrake = "unbreak",
    noclip = "noclip",
    clip = "unclip",
    freeze = "freeze",
    unfreeze = "unfreeze",
    mute = "mute",
    unmute = "unmute",
    ban = "ban",
    unban = "unban",
    kick = "kick",
    explode = "explode",
    smite = "smite",
    killall = "killall",
    reviveall = "reviveall",
    healall = "healall",
    godall = "godall",
    ungodall = "ungodall",
    flyall = "flyall",
    unflyall = "unflyall",
    invisall = "invisall",
    visall = "visall",
    noclipall = "noclipall",
    unclipall = "unclipall",
    freezeall = "freezeall",
    unfreezeall = "unfreezeall",
    bringme = "bring",
    comeme = "bring",
    
    -- Rig aliases
    r = "rig",
    rigs = "rigs",
    rkill = "rigkill",
    rtp = "rigtp",
    rb = "rigbring",
    rf = "rigfreeze",
    ruf = "rigunfreeze",
    rh = "righeal",
    rrev = "rigrevive",
    rc = "rigclone",
    rrem = "rigremove",
    rex = "rigexplode",
    rsm = "rigsmite",
    
    -- Assistant aliases
    assist = "assistant",
    as = "assistant",
    a = "assistant",
    akill = "akill",
    ak = "akill"
}

-- ==================== PERMISSION SYSTEM ====================
local function GetRankLevel(player)
    if not player then return 1 end
    local userId = player.UserId
    if table.find(Config.Owners, userId) then return 4 end
    if userId == 1 then return 5 end
    
    local groupId = 12345678
    local success, groupRank = pcall(function()
        return GroupService:GetRankInGroup(player, groupId)
    end)
    if success and groupRank then
        if groupRank >= 255 then return 4
        elseif groupRank >= 100 then return 3
        elseif groupRank >= 50 then return 2 end
    end
    return 1
end

local function HasPermission(player, command)
    local level = GetRankLevel(player)
    for _, rankData in pairs(Config.Ranks) do
        if rankData.Level == level then
            if rankData.Commands == "*" then return true end
            return table.find(rankData.Commands, command) ~= nil
        end
    end
    return false
end

local function GetPlayerRankName(player)
    local level = GetRankLevel(player)
    for name, data in pairs(Config.Ranks) do
        if data.Level == level then return name end
    end
    return "User"
end

-- ==================== RIG DETECTION & UTILITY ====================
local function IsRig(model)
    if not model then return false end
    if model:IsA("Model") then
        local humanoid = model:FindFirstChild("Humanoid")
        if humanoid and humanoid:IsA("Humanoid") then
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character == model then
                    return false
                end
            end
            return true
        end
    end
    return false
end

local function GetAllRigs()
    local rigs = {}
    for _, model in ipairs(Workspace:GetChildren()) do
        if IsRig(model) then
            table.insert(rigs, model)
        end
    end
    return rigs
end

local function GetRigFromArg(arg)
    if not arg then return nil end
    local matches = {}
    local lowerArg = string.lower(arg)
    for _, rig in ipairs(GetAllRigs()) do
        if string.lower(rig.Name):find(lowerArg, 1, true) then
            table.insert(matches, rig)
        end
    end
    if #matches == 1 then return matches[1] end
    if #matches > 1 then return matches end
    return nil
end

local function GetHumanoidFromTarget(target)
    if type(target) == "table" then return nil end
    if target:IsA("Model") then
        return target:FindFirstChild("Humanoid")
    end
    if target:IsA("Player") then
        local char = target.Character
        if char then
            return char:FindFirstChild("Humanoid")
        end
    end
    return nil
end

local function GetHRPFromTarget(target)
    if type(target) == "table" then return nil end
    if target:IsA("Model") then
        return target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("Torso") or target:FindFirstChild("Head")
    end
    if target:IsA("Player") then
        local char = target.Character
        if char then
            return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
        end
    end
    return nil
end

local function GetPlayerFromArg(arg)
    if not arg then return nil end
    if arg:sub(1, 1) == "@" then
        arg = arg:sub(2)
        local matches = {}
        local lowerArg = string.lower(arg)
        for _, plr in ipairs(Players:GetPlayers()) do
            if string.lower(plr.Name):find(lowerArg, 1, true) or 
               string.lower(plr.DisplayName):find(lowerArg, 1, true) then
                table.insert(matches, plr)
            end
        end
        if #matches == 1 then return matches[1] end
        if #matches > 1 then return matches end
        return nil
    end
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if string.lower(plr.Name) == string.lower(arg) or 
           string.lower(plr.DisplayName) == string.lower(arg) then
            return plr
        end
    end
    return nil
end

local function GetTargetFromArg(arg)
    if not arg then return nil end
    local player = GetPlayerFromArg(arg)
    if player then return player end
    local rig = GetRigFromArg(arg)
    if rig then return rig end
    local model = Workspace:FindFirstChild(arg)
    if model and model:IsA("Model") then
        return model
    end
    return nil
end

local function GetAllTargets(args)
    local targets = {}
    if not args or #args == 0 then 
        for _, plr in ipairs(Players:GetPlayers()) do
            table.insert(targets, plr)
        end
        for _, rig in ipairs(GetAllRigs()) do
            table.insert(targets, rig)
        end
        return targets
    end
    if args[1]:lower() == "all" then
        for _, plr in ipairs(Players:GetPlayers()) do
            table.insert(targets, plr)
        end
        for _, rig in ipairs(GetAllRigs()) do
            table.insert(targets, rig)
        end
        return targets
    end
    for _, arg in ipairs(args) do
        local result = GetTargetFromArg(arg)
        if result then
            if type(result) == "table" then
                for _, target in ipairs(result) do
                    table.insert(targets, target)
                end
            else
                table.insert(targets, result)
            end
        end
    end
    return targets
end

local function GetCharacter(target)
    if not target then return nil end
    if type(target) == "Player" then
        return target.Character
    end
    if type(target) == "Instance" and target:IsA("Model") then
        return target
    end
    return nil
end

local function GetHumanoid(target)
    if type(target) == "Player" then
        local char = target.Character
        if char then
            return char:FindFirstChild("Humanoid")
        end
    end
    if type(target) == "Instance" and target:IsA("Model") then
        return target:FindFirstChild("Humanoid")
    end
    return nil
end

local function GetHRP(target)
    if type(target) == "Player" then
        local char = target.Character
        if char then
            return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
        end
    end
    if type(target) == "Instance" and target:IsA("Model") then
        return target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("Torso") or target:FindFirstChild("Head")
    end
    return nil
end

-- ==================== LOGGING ====================
local Logs = {}
local function LogAction(player, action, target, args)
    if not Config.Logging then return end
    local targetName = type(target) == "Player" and target.Name or (target and target.Name or "N/A")
    local log = string.format("[%s] %s [%s] → %s: %s %s", 
        os.date("%H:%M:%S"), player.Name, GetPlayerRankName(player),
        targetName, action, table.concat(args or {}, " "))
    table.insert(Logs, log)
    if #Logs > 200 then table.remove(Logs, 1) end
    print(log)
end

-- ==================== COMMAND REGISTRY ====================
local Commands = {}

-- ─── ASSISTANT SYSTEM ──────────────────────────────────────────
local WEAPON_LIST = {"🔪 Knife", "🔫 Pistol", "⚔️ Sword", "💥 Shotgun"}

local function getRandomWeapon()
    return WEAPON_LIST[math.random(1, #WEAPON_LIST)]
end

local function findTarget(name)
    if not name then return nil, nil end
    for _, plr in ipairs(Players:GetPlayers()) do
        if string.lower(plr.Name) == string.lower(name) or 
           string.lower(plr.DisplayName) == string.lower(name) then
            return plr, "Player"
        end
    end
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            local objName = string.lower(obj.Name)
            local searchName = string.lower(name)
            if objName == searchName or string.find(objName, searchName) then
                return obj, "NPC"
            end
        end
    end
    return nil, nil
end

local function getTargetRoot(target, targetType)
    if targetType == "Player" then
        local char = target.Character
        if char then
            return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("Head")
        end
    elseif targetType == "NPC" then
        return target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("Torso") or target:FindFirstChild("Head")
    end
    return nil
end

local function getTargetHumanoid(target, targetType)
    if targetType == "Player" then
        local char = target.Character
        if char then
            return char:FindFirstChild("Humanoid")
        end
    elseif targetType == "NPC" then
        return target:FindFirstChild("Humanoid")
    end
    return nil
end

local function createBloodEffect(position, amount)
    for i = 1, amount or 15 do
        local blood = Instance.new("Part")
        blood.Size = Vector3.new(
            math.random(1, 4) / 10,
            math.random(1, 4) / 10,
            math.random(1, 4) / 10
        )
        blood.BrickColor = BrickColor.new("Bright red")
        blood.Material = Enum.Material.SmoothPlastic
        blood.Anchored = false
        blood.CanCollide = false
        blood.Position = position + Vector3.new(
            math.random(-3, 3),
            math.random(-1, 2),
            math.random(-3, 3)
        )
        blood.Parent = workspace
        
        local vel = Instance.new("BodyVelocity")
        vel.MaxForce = Vector3.new(4000, 4000, 4000)
        vel.Velocity = Vector3.new(
            math.random(-10, 10),
            math.random(5, 15),
            math.random(-10, 10)
        )
        vel.Parent = blood
        
        Debris:AddItem(blood, 2)
    end
end

local function createAssistant(ownerRoot)
    local model = Instance.new("Model")
    model.Name = Config.AssistantName
    model.Parent = workspace
    
    local hum = Instance.new("Humanoid")
    hum.Name = "Humanoid"
    hum.MaxHealth = 999999
    hum.Health = 999999
    hum.WalkSpeed = Config.AssistantWalkSpeed
    hum.JumpPower = Config.AssistantJumpPower
    hum.Parent = model
    
    local root = Instance.new("Part")
    root.Name = "HumanoidRootPart"
    root.Size = Vector3.new(2, 1, 1)
    root.Anchored = false
    root.CanCollide = true
    root.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
    root.Position = ownerRoot.Position + Vector3.new(5, 0, 5)
    root.BrickColor = BrickColor.new("Bright red")
    root.Material = Enum.Material.SmoothPlastic
    root.Parent = model
    
    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = Vector3.new(2, 2, 1)
    torso.Anchored = false
    torso.CanCollide = true
    torso.BrickColor = BrickColor.new("Bright red")
    torso.Material = Enum.Material.SmoothPlastic
    torso.Position = root.Position + Vector3.new(0, 2, 0)
    torso.Parent = model
    
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(1.5, 1.5, 1.5)
    head.Anchored = false
    head.CanCollide = true
    head.BrickColor = BrickColor.new("White")
    head.Material = Enum.Material.SmoothPlastic
    head.Position = torso.Position + Vector3.new(0, 1.5, 0)
    head.Parent = model
    
    local leftArm = Instance.new("Part")
    leftArm.Name = "Left Arm"
    leftArm.Size = Vector3.new(0.5, 2, 0.5)
    leftArm.Anchored = false
    leftArm.CanCollide = true
    leftArm.BrickColor = BrickColor.new("Bright red")
    leftArm.Material = Enum.Material.SmoothPlastic
    leftArm.Position = torso.Position + Vector3.new(-1.3, 0, 0)
    leftArm.Parent = model
    
    local rightArm = Instance.new("Part")
    rightArm.Name = "Right Arm"
    rightArm.Size = Vector3.new(0.5, 2, 0.5)
    rightArm.Anchored = false
    rightArm.CanCollide = true
    rightArm.BrickColor = BrickColor.new("Bright red")
    rightArm.Material = Enum.Material.SmoothPlastic
    rightArm.Position = torso.Position + Vector3.new(1.3, 0, 0)
    rightArm.Parent = model
    
    local leftLeg = Instance.new("Part")
    leftLeg.Name = "Left Leg"
    leftLeg.Size = Vector3.new(0.5, 2, 0.5)
    leftLeg.Anchored = false
    leftLeg.CanCollide = true
    leftLeg.BrickColor = BrickColor.new("Bright red")
    leftLeg.Material = Enum.Material.SmoothPlastic
    leftLeg.Position = torso.Position + Vector3.new(-0.6, -2, 0)
    leftLeg.Parent = model
    
    local rightLeg = Instance.new("Part")
    rightLeg.Name = "Right Leg"
    rightLeg.Size = Vector3.new(0.5, 2, 0.5)
    rightLeg.Anchored = false
    rightLeg.CanCollide = true
    rightLeg.BrickColor = BrickColor.new("Bright red")
    rightLeg.Material = Enum.Material.SmoothPlastic
    rightLeg.Position = torso.Position + Vector3.new(0.6, -2, 0)
    rightLeg.Parent = model
    
    local function weld(p0, p1, cf)
        local w = Instance.new("Weld")
        w.Part0 = p0
        w.Part1 = p1
        w.C0 = cf
        w.Parent = p0
        return w
    end
    
    weld(root, torso, CFrame.new(0, 2, 0))
    weld(torso, head, CFrame.new(0, 1.5, 0))
    weld(torso, leftArm, CFrame.new(-1.3, 0, 0))
    weld(torso, rightArm, CFrame.new(1.3, 0, 0))
    weld(torso, leftLeg, CFrame.new(-0.6, -2, 0))
    weld(torso, rightLeg, CFrame.new(0.6, -2, 0))
    
    local face = Instance.new("Decal")
    face.Name = "Face"
    face.Texture = "rbxassetid://2330925655"
    face.Face = Enum.NormalId.Front
    face.Parent = head
    
    local glow = Instance.new("Part")
    glow.Name = "Glow"
    glow.Size = Vector3.new(3, 4, 3)
    glow.Position = root.Position + Vector3.new(0, 2, 0)
    glow.BrickColor = BrickColor.new("Bright red")
    glow.Material = Enum.Material.Neon
    glow.Anchored = true
    glow.CanCollide = false
    glow.Transparency = 0.7
    glow.Parent = model
    
    local glowWeld = Instance.new("Weld")
    glowWeld.Part0 = root
    glowWeld.Part1 = glow
    glowWeld.C0 = CFrame.new(0, 2, 0)
    glowWeld.Parent = root
    
    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 250, 0, 60)
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.Parent = head
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "💀 Personal Assistant\nType 'kill (name)' or /akill"
    label.TextColor3 = Color3.new(1, 0, 0)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextStrokeTransparency = 0.5
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.Parent = billboard
    
    return model, hum, root, {Torso = torso, Head = head, ["Right Arm"] = rightArm}
end

local function equipWeapon(model, bodyParts, weaponType)
    for _, child in ipairs(model:GetChildren()) do
        if child:IsA("Tool") then
            child:Destroy()
        end
    end
    
    local tool = Instance.new("Tool")
    tool.Name = weaponType
    tool.Parent = model
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.3, 0.3, 0.3)
    handle.Anchored = false
    handle.CanCollide = false
    handle.BrickColor = BrickColor.new("Dark grey")
    handle.Parent = tool
    
    local weapon = Instance.new("Part")
    weapon.Name = "Weapon"
    weapon.Anchored = false
    weapon.CanCollide = false
    
    if weaponType == "🔪 Knife" then
        weapon.Size = Vector3.new(0.1, 1, 0.1)
        weapon.BrickColor = BrickColor.new("Bright silver")
        weapon.Material = Enum.Material.Metal
        weapon.Position = Vector3.new(0, -0.8, 0)
    elseif weaponType == "🔫 Pistol" then
        weapon.Size = Vector3.new(0.3, 0.2, 0.8)
        weapon.BrickColor = BrickColor.new("Dark grey")
        weapon.Material = Enum.Material.Metal
        weapon.Position = Vector3.new(0, 0, -0.5)
    elseif weaponType == "⚔️ Sword" then
        weapon.Size = Vector3.new(0.1, 1.5, 0.1)
        weapon.BrickColor = BrickColor.new("Bright blue")
        weapon.Material = Enum.Material.Metal
        weapon.Position = Vector3.new(0, -1.2, 0)
    elseif weaponType == "💥 Shotgun" then
        weapon.Size = Vector3.new(0.4, 0.3, 1)
        weapon.BrickColor = BrickColor.new("Black")
        weapon.Material = Enum.Material.Metal
        weapon.Position = Vector3.new(0, 0, -0.8)
    end
    
    weapon.Parent = tool
    
    local rightArm = bodyParts["Right Arm"]
    local weld = Instance.new("Weld")
    weld.Part0 = rightArm
    weld.Part1 = handle
    weld.C0 = CFrame.new(0, -1, 0) * CFrame.Angles(0, 0, -1.57)
    weld.Parent = rightArm
    
    local w2 = Instance.new("Weld")
    w2.Part0 = handle
    w2.Part1 = weapon
    w2.C0 = CFrame.new(0, -0.8, 0)
    w2.Parent = handle
end

local function realKill(target, targetType, weaponType)
    local hum = getTargetHumanoid(target, targetType)
    if not hum then return false end
    
    local root = getTargetRoot(target, targetType)
    if root then
        createBloodEffect(root.Position, 20)
    end
    
    hum.Health = 0
    
    if targetType == "Player" then
        print("💀 KILLED PLAYER: " .. target.Name .. " with " .. weaponType)
    else
        print("💀 KILLED NPC: " .. target.Name .. " with " .. weaponType)
    end
    
    return true
end

local assistants = {}

local function getOrCreateAssistant(player)
    if assistants[player] then
        return assistants[player]
    end
    
    local char = player.Character
    if not char then return nil end
    
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    if not root then return nil end
    
    local model, hum, assRoot, parts = createAssistant(root)
    
    local data = {
        Model = model,
        Humanoid = hum,
        Root = assRoot,
        BodyParts = parts,
        Owner = player,
        IsAttacking = false,
        IsOpen = true,
    }
    
    assistants[player] = data
    return data
end

local function openAssistant(player)
    local data = assistants[player]
    if data and data.Model then
        data.Model.Parent = workspace
        data.IsOpen = true
        print("✅ Assistant opened for " .. player.Name)
        return true
    end
    
    data = getOrCreateAssistant(player)
    if data then
        data.IsOpen = true
        print("✅ Assistant created and opened for " .. player.Name)
        return true
    end
    
    return false
end

local function closeAssistant(player)
    local data = assistants[player]
    if data and data.Model then
        data.Model.Parent = nil
        data.IsOpen = false
        print("❌ Assistant closed for " .. player.Name)
        return true
    end
    return false
end

local function toggleAssistant(player)
    local data = assistants[player]
    if data and data.IsOpen then
        return closeAssistant(player)
    else
        return openAssistant(player)
    end
end

local function attackTarget(player, targetName)
    local target, targetType = findTarget(targetName)
    if not target then
        player:Chat("❌ Target not found: " .. targetName)
        return
    end
    
    if targetType == "Player" and target == player then
        player:Chat("❌ Cannot kill yourself!")
        return
    end
    
    local data = assistants[player]
    if not data or not data.IsOpen then
        openAssistant(player)
        data = assistants[player]
        if not data then
            player:Chat("❌ Failed to open assistant")
            return
        end
    end
    
    if data.IsAttacking then
        player:Chat("⏳ Assistant already attacking!")
        return
    end
    
    data.IsAttacking = true
    
    local targetRoot = getTargetRoot(target, targetType)
    if not targetRoot then
        player:Chat("❌ Target has no root")
        data.IsAttacking = false
        return
    end
    
    local weaponType = getRandomWeapon()
    equipWeapon(data.Model, data.BodyParts, weaponType)
    
    local targetPos = targetRoot.Position
    
    player:Chat("🎯 Attacking: " .. targetName .. " with " .. weaponType)
    
    data.Humanoid:MoveTo(targetPos + Vector3.new(0, 0, 3))
    data.Humanoid.WalkSpeed = Config.AssistantWalkSpeed + 10
    
    local start = tick()
    while (data.Root.Position - targetPos).Magnitude > Config.AssistantAttackDistance and tick() - start < 8 do
        data.Humanoid:MoveTo(targetPos + Vector3.new(0, 0, 3))
        task.wait(0.1)
    end
    
    local rightArm = data.BodyParts["Right Arm"]
    for i = 1, 3 do
        rightArm.CFrame = rightArm.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 0, -0.5)
        task.wait(0.05)
        rightArm.CFrame = rightArm.CFrame * CFrame.new(0, 0, 2) * CFrame.Angles(0, 0, 0.5)
        task.wait(0.05)
    end
    
    data.Humanoid.Jump = true
    task.wait(0.2)
    data.Humanoid.Jump = false
    
    realKill(target, targetType, weaponType)
    
    task.wait(1)
    local ownerChar = player.Character
    if ownerChar then
        local root = ownerChar:FindFirstChild("HumanoidRootPart") or ownerChar:FindFirstChild("Torso")
        if root then
            data.Humanoid:MoveTo(root.Position + Vector3.new(3, 0, 3))
        end
    end
    
    data.IsAttacking = false
    player:Chat("✅ Assistant killed " .. targetName)
end

-- ─── ASSISTANT COMMANDS ──────────────────────────────────────────
function Commands:assistant(plr, args)
    if not args or #args == 0 then
        local data = assistants[plr]
        if data and data.IsOpen then
            plr:Chat("Assistant is OPEN")
        else
            plr:Chat("Assistant is CLOSED")
        end
        return true
    end
    
    local action = args[1]:lower()
    if action == "open" then
        openAssistant(plr)
        plr:Chat("Assistant opened!")
        return true
    elseif action == "close" then
        closeAssistant(plr)
        plr:Chat("Assistant closed!")
        return true
    elseif action == "toggle" then
        toggleAssistant(plr)
        plr:Chat("Assistant toggled!")
        return true
    end
    return false
end

function Commands:open(plr, args)
    openAssistant(plr)
    plr:Chat("Assistant opened!")
    return true
end

function Commands:close(plr, args)
    closeAssistant(plr)
    plr:Chat("Assistant closed!")
    return true
end

function Commands:toggle(plr, args)
    toggleAssistant(plr)
    plr:Chat("Assistant toggled!")
    return true
end

function Commands:akill(plr, args)
    if not args or #args == 0 then
        plr:Chat("Usage: /akill @name")
        return false
    end
    attackTarget(plr, args[1])
    return true
end

function Commands:ak(plr, args)
    return Commands.akill(plr, args)
end

-- ─── PLAYER MANAGEMENT ─────────────────────────────────────
function Commands:kick(plr, args)
    local target = args[1] and GetPlayerFromArg(args[1])
    if type(target) == "table" or not target then return false end
    target:Kick(args[2] or "Kicked by admin")
    LogAction(plr, "kick", target, {args[2]})
    return true
end

function Commands:ban(plr, args)
    local target = args[1] and GetPlayerFromArg(args[1])
    if type(target) == "table" or not target then return false end
    table.insert(Config.BanList, target.UserId)
    target:Kick("Banned: " .. (args[2] or "No reason"))
    LogAction(plr, "ban", target, {args[2]})
    return true
end

function Commands:unban(plr, args)
    local userId = tonumber(args[1])
    if userId then
        for i, id in ipairs(Config.BanList) do
            if id == userId then
                table.remove(Config.BanList, i)
                LogAction(plr, "unban", tostring(userId), {})
                return true
            end
        end
    end
    return false
end

function Commands:mute(plr, args)
    local target = args[1] and GetPlayerFromArg(args[1])
    if type(target) == "table" or not target then return false end
    Config.MuteList[target] = true
    LogAction(plr, "mute", target, {})
    return true
end

function Commands:unmute(plr, args)
    local target = args[1] and GetPlayerFromArg(args[1])
    if type(target) == "table" or not target then return false end
    Config.MuteList[target] = nil
    LogAction(plr, "unmute", target, {})
    return true
end

function Commands:freeze(plr, args)
    local target = GetTargetFromArg(args[1])
    if type(target) == "table" or not target then return false end
    Config.FreezeList[target] = true
    local hrp = GetHRP(target)
    if hrp then hrp.Anchored = true end
    LogAction(plr, "freeze", target, {})
    return true
end

function Commands:unfreeze(plr, args)
    local target = GetTargetFromArg(args[1])
    if type(target) == "table" or not target then return false end
    Config.FreezeList[target] = nil
    local hrp = GetHRP(target)
    if hrp then hrp.Anchored = false end
    LogAction(plr, "unfreeze", target, {})
    return true
end

-- ─── TELEPORTATION ──────────────────────────────────────────
function Commands:tp(plr, args)
    local target = GetTargetFromArg(args[1])
    if type(target) == "table" or not target then return false end
    local dest = args[2] and GetTargetFromArg(args[2]) or plr
    if type(dest) == "table" then return false end
    local targetHRP = GetHRP(target)
    local destHRP = GetHRP(dest)
    if targetHRP and destHRP then
        targetHRP.CFrame = destHRP.CFrame
        LogAction(plr, "tp", target, {dest.Name})
        return true
    end
    return false
end

function Commands:bring(plr, args)
    local target = GetTargetFromArg(args[1])
    if type(target) == "table" or not target then return false end
    local plrHRP = GetHRP(plr)
    local targetHRP = GetHRP(target)
    if plrHRP and targetHRP then
        targetHRP.CFrame = plrHRP.CFrame
        LogAction(plr, "bring", target, {})
        return true
    end
    return false
end

function Commands:goto(plr, args)
    local target = GetTargetFromArg(args[1])
    if type(target) == "table" or not target then return false end
    local plrHRP = GetHRP(plr)
    local targetHRP = GetHRP(target)
    if plrHRP and targetHRP then
        plrHRP.CFrame = targetHRP.CFrame
        LogAction(plr, "goto", target, {})
        return true
    end
    return false
end

function Commands:here(plr, args)
    local targets = GetAllTargets(args)
    local plrHRP = GetHRP(plr)
    if not plrHRP then return false end
    local count = 0
    for _, target in ipairs(targets) do
        if target ~= plr then
            local targetHRP = GetHRP(target)
            if targetHRP then
                targetHRP.CFrame = plrHRP.CFrame
                count = count + 1
            end
        end
    end
    LogAction(plr, "here", tostring(count) .. " targets", {})
    return true
end

function Commands:alltp(plr, args)
    local dest = args[1] and GetTargetFromArg(args[1]) or plr
    if type(dest) == "table" then return false end
    local destHRP = GetHRP(dest)
    if not destHRP then return false end
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        if target ~= dest then
            local targetHRP = GetHRP(target)
            if targetHRP then
                targetHRP.CFrame = destHRP.CFrame
                count = count + 1
            end
        end
    end
    LogAction(plr, "alltp", dest, {tostring(count)})
    return true
end

function Commands:bringall(plr, args)
    if Config.BringAllCooldown[plr] and tick() - Config.BringAllCooldown[plr] < 3 then
        plr:Chat("Cooldown: wait 3 seconds")
        return false
    end
    Config.BringAllCooldown[plr] = tick()
    
    local plrHRP = GetHRP(plr)
    if not plrHRP then return false end
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        if target ~= plr then
            local targetHRP = GetHRP(target)
            if targetHRP then
                targetHRP.CFrame = plrHRP.CFrame + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
                count = count + 1
                task.wait(0.05)
            end
        end
    end
    LogAction(plr, "bringall", tostring(count) .. " targets", {})
    plr:Chat("Brought " .. count .. " targets to you!")
    return true
end

-- ─── COMBAT ──────────────────────────────────────────────────
function Commands:kill(plr, args)
    local targets = GetAllTargets(args)
    local count = 0
    for _, target in ipairs(targets) do
        local humanoid = GetHumanoid(target)
        if humanoid then
            humanoid.Health = 0
            count = count + 1
        end
    end
    LogAction(plr, "kill", tostring(count) .. " targets", {})
    return count > 0
end

function Commands:revive(plr, args)
    local targets = GetAllTargets(args)
    local count = 0
    for _, target in ipairs(targets) do
        local humanoid = GetHumanoid(target)
        if humanoid and humanoid.Health <= 0 then
            humanoid.Health = 100
            count = count + 1
        end
    end
    LogAction(plr, "revive", tostring(count) .. " targets", {})
    return count > 0
end

function Commands:heal(plr, args)
    local targets = GetAllTargets(args)
    local count = 0
    for _, target in ipairs(targets) do
        local humanoid = GetHumanoid(target)
        if humanoid then
            humanoid.Health = humanoid.MaxHealth
            count = count + 1
        end
    end
    LogAction(plr, "heal", tostring(count) .. " targets", {})
    return count > 0
end

function Commands:smite(plr, args)
    local target = GetTargetFromArg(args[1])
    if type(target) == "table" or not target then return false end
    local hrp = GetHRP(target)
    if hrp then
        local part = Instance.new("Part")
        part.Size = Vector3.new(10, 10, 10)
        part.CFrame = hrp.CFrame + Vector3.new(0, 30, 0)
        part.Anchored = true
        part.CanCollide = false
        part.Transparency = 0.5
        part.BrickColor = BrickColor.new("Bright yellow")
        part.Material = Enum.Material.Neon
        part.Parent = workspace
        Debris:AddItem(part, 2)
        
        local explosion = Instance.new("Explosion")
        explosion.Position = hrp.Position
        explosion.BlastRadius = 20
        explosion.BlastPressure = 100
        explosion.Parent = workspace
        explosion.Hit:Connect(function(hit)
            local humanoid = hit.Parent:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = 0
            end
        end)
        LogAction(plr, "smite", target, {})
        return true
    end
    return false
end

function Commands:explode(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    local hrp = GetHRP(target)
    if hrp then
        local explosion = Instance.new("Explosion")
        explosion.Position = hrp.Position
        explosion.BlastRadius = 30
        explosion.BlastPressure = 200
        explosion.Parent = workspace
        LogAction(plr, "explode", target, {})
        return true
    end
    return false
end

function Commands:god(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    Config.GodList[target] = true
    local humanoid = GetHumanoid(target)
    if humanoid then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    end
    LogAction(plr, "god", target, {})
    return true
end

function Commands:ungod(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    Config.GodList[target] = nil
    local humanoid = GetHumanoid(target)
    if humanoid then
        humanoid.MaxHealth = 100
        humanoid.Health = 100
    end
    LogAction(plr, "ungod", target, {})
    return true
end

-- ─── MASS COMMANDS ────────────────────────────────────────────
function Commands:killall(plr, args)
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        if target ~= plr then
            local humanoid = GetHumanoid(target)
            if humanoid then
                humanoid.Health = 0
                count = count + 1
            end
        end
    end
    LogAction(plr, "killall", tostring(count) .. " targets", {})
    plr:Chat("Killed " .. count .. " targets!")
    return true
end

function Commands:reviveall(plr, args)
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        local humanoid = GetHumanoid(target)
        if humanoid and humanoid.Health <= 0 then
            humanoid.Health = 100
            count = count + 1
        end
    end
    LogAction(plr, "reviveall", tostring(count) .. " targets", {})
    return true
end

function Commands:healall(plr, args)
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        local humanoid = GetHumanoid(target)
        if humanoid then
            humanoid.Health = humanoid.MaxHealth
            count = count + 1
        end
    end
    LogAction(plr, "healall", tostring(count) .. " targets", {})
    return true
end

function Commands:godall(plr, args)
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        Config.GodList[target] = true
        local humanoid = GetHumanoid(target)
        if humanoid then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
            count = count + 1
        end
    end
    LogAction(plr, "godall", tostring(count) .. " targets", {})
    return true
end

function Commands:ungodall(plr, args)
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        Config.GodList[target] = nil
        local humanoid = GetHumanoid(target)
        if humanoid then
            humanoid.MaxHealth = 100
            humanoid.Health = 100
            count = count + 1
        end
    end
    LogAction(plr, "ungodall", tostring(count) .. " targets", {})
    return true
end

-- ─── FLIGHT ──────────────────────────────────────────────────
function Commands:fly(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    if Config.FlyList[target] then return false end
    Config.FlyList[target] = true
    
    local humanoid = GetHumanoid(target)
    if humanoid then humanoid.PlatformStand = true end
    
    local hrp = GetHRP(target)
    if hrp then
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1/0, 1/0, 1/0)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = hrp
        
        local bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(1/0, 1/0, 1/0)
        bg.D = 1000
        bg.Parent = hrp
        
        target:SetAttribute("FlyBV", bv)
        target:SetAttribute("FlyBG", bg)
        
        local conn = RunService.Heartbeat:Connect(function()
            if not target or not target:IsA("Model") or not Config.FlyList[target] then
                conn:Disconnect()
                return
            end
            local bv = target:GetAttribute("FlyBV")
            local bg = target:GetAttribute("FlyBG")
            if bv and bg and hrp then
                local move = Vector3.new(0, 0, 0)
                if target:GetAttribute("FlyForward") then move = move + hrp.CFrame.LookVector end
                if target:GetAttribute("FlyBackward") then move = move - hrp.CFrame.LookVector end
                if target:GetAttribute("FlyLeft") then move = move - hrp.CFrame.RightVector end
                if target:GetAttribute("FlyRight") then move = move + hrp.CFrame.RightVector end
                if target:GetAttribute("FlyUp") then move = move + Vector3.new(0, 1, 0) end
                if target:GetAttribute("FlyDown") then move = move - Vector3.new(0, 1, 0) end
                if move.Magnitude > 0 then move = move.Unit * Config.MaxFlySpeed end
                bv.Velocity = move
                bg.CFrame = hrp.CFrame
            end
        end)
        target:SetAttribute("FlyConn", conn)
        
        local keyDown = UserInputService.InputBegan:Connect(function(input)
            if not target then return end
            if input.KeyCode then
                local key = input.KeyCode.Name
                if key == "W" then target:SetAttribute("FlyForward", true) end
                if key == "S" then target:SetAttribute("FlyBackward", true) end
                if key == "A" then target:SetAttribute("FlyLeft", true) end
                if key == "D" then target:SetAttribute("FlyRight", true) end
                if key == "Space" then target:SetAttribute("FlyUp", true) end
                if key == "LeftShift" or key == "LeftControl" then target:SetAttribute("FlyDown", true) end
            end
        end)
        local keyUp = UserInputService.InputEnded:Connect(function(input)
            if not target then return end
            if input.KeyCode then
                local key = input.KeyCode.Name
                if key == "W" then target:SetAttribute("FlyForward", false) end
                if key == "S" then target:SetAttribute("FlyBackward", false) end
                if key == "A" then target:SetAttribute("FlyLeft", false) end
                if key == "D" then target:SetAttribute("FlyRight", false) end
                if key == "Space" then target:SetAttribute("FlyUp", false) end
                if key == "LeftShift" or key == "LeftControl" then target:SetAttribute("FlyDown", false) end
            end
        end)
        target:SetAttribute("FlyKeys", {keyDown, keyUp})
        LogAction(plr, "fly", target, {})
        return true
    end
    return false
end

function Commands:unfly(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    if Config.FlyList[target] then
        Config.FlyList[target] = nil
        local humanoid = GetHumanoid(target)
        if humanoid then humanoid.PlatformStand = false end
        local bv = target:GetAttribute("FlyBV")
        if bv then bv:Destroy() end
        local bg = target:GetAttribute("FlyBG")
        if bg then bg:Destroy() end
        local conn = target:GetAttribute("FlyConn")
        if conn then conn:Disconnect() end
        local keys = target:GetAttribute("FlyKeys")
        if keys then for _, k in ipairs(keys) do k:Disconnect() end end
        LogAction(plr, "unfly", target, {})
        return true
    end
    return false
end

function Commands:flyall(plr, args)
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        if target ~= plr then
            local success = Commands.fly(plr, {target.Name})
            if success then count = count + 1 end
            task.wait(0.1)
        end
    end
    LogAction(plr, "flyall", tostring(count) .. " targets", {})
    return true
end

function Commands:unflyall(plr, args)
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        if target ~= plr then
            local success = Commands.unfly(plr, {target.Name})
            if success then count = count + 1 end
        end
    end
    LogAction(plr, "unflyall", tostring(count) .. " targets", {})
    return true
end

-- ─── NOCLIP ──────────────────────────────────────────────────
function Commands:noclip(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    Config.NoclipList[target] = true
    local char = GetCharacter(target)
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
    LogAction(plr, "noclip", target, {})
    return true
end

function Commands:unclip(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    Config.NoclipList[target] = nil
    local char = GetCharacter(target)
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
    LogAction(plr, "unclip", target, {})
    return true
end

function Commands:noclipall(plr, args)
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        if target ~= plr then
            local success = Commands.noclip(plr, {target.Name})
            if success then count = count + 1 end
        end
    end
    LogAction(plr, "noclipall", tostring(count) .. " targets", {})
    return true
end

function Commands:unclipall(plr, args)
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        if target ~= plr then
            local success = Commands.unclip(plr, {target.Name})
            if success then count = count + 1 end
        end
    end
    LogAction(plr, "unclipall", tostring(count) .. " targets", {})
    return true
end

-- ─── INVISIBILITY ────────────────────────────────────────────
function Commands:invis(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    Config.InvisList[target] = true
    local char = GetCharacter(target)
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Accoutrement") then
                part.Transparency = 1
            end
        end
    end
    LogAction(plr, "invis", target, {})
    return true
end

function Commands:vis(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    Config.InvisList[target] = nil
    local char = GetCharacter(target)
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Accoutrement") then
                part.Transparency = 0
            end
        end
    end
    LogAction(plr, "vis", target, {})
    return true
end

function Commands:invisall(plr, args)
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        if target ~= plr then
            local success = Commands.invis(plr, {target.Name})
            if success then count = count + 1 end
        end
    end
    LogAction(plr, "invisall", tostring(count) .. " targets", {})
    return true
end

function Commands:visall(plr, args)
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        if target ~= plr then
            local success = Commands.vis(plr, {target.Name})
            if success then count = count + 1 end
        end
    end
    LogAction(plr, "visall", tostring(count) .. " targets", {})
    return true
end

-- ─── FREEZE MASS ─────────────────────────────────────────────
function Commands:freezeall(plr, args)
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        if target ~= plr then
            local success = Commands.freeze(plr, {target.Name})
            if success then count = count + 1 end
        end
    end
    LogAction(plr, "freezeall", tostring(count) .. " targets", {})
    return true
end

function Commands:unfreezeall(plr, args)
    local count = 0
    local allTargets = GetAllTargets({})
    for _, target in ipairs(allTargets) do
        if target ~= plr then
            local success = Commands.unfreeze(plr, {target.Name})
            if success then count = count + 1 end
        end
    end
    LogAction(plr, "unfreezeall", tostring(count) .. " targets", {})
    return true
end

-- ─── SPEED & JUMP ────────────────────────────────────────────
function Commands:speed(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    local speed = tonumber(args[#args])
    if not speed then return false end
    local humanoid = GetHumanoid(target)
    if humanoid then
        humanoid.WalkSpeed = math.min(speed, Config.MaxSpeed)
        LogAction(plr, "speed", target, {tostring(speed)})
        return true
    end
    return false
end

function Commands:jumppower(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    local power = tonumber(args[#args])
    if not power then return false end
    local humanoid = GetHumanoid(target)
    if humanoid then
        humanoid.JumpPower = math.min(power, Config.MaxJumpPower)
        LogAction(plr, "jumppower", target, {tostring(power)})
        return true
    end
    return false
end

-- ─── TOOLS ──────────────────────────────────────────────────
function Commands:give(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    local toolName = args[#args]
    if not toolName then return false end
    local tool = ReplicatedStorage:FindFirstChild(toolName) or ServerStorage:FindFirstChild(toolName)
    if not tool then return false end
    local char = GetCharacter(target)
    if char then
        local clone = tool:Clone()
        clone.Parent = char
        LogAction(plr, "give", target, {toolName})
        return true
    end
    return false
end

function Commands:tools(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    local char = GetCharacter(target)
    if not char then return false end
    local count = 0
    for _, tool in ipairs(ReplicatedStorage:GetChildren()) do
        if tool:IsA("Tool") then
            local clone = tool:Clone()
            clone.Parent = char
            count = count + 1
        end
    end
    for _, tool in ipairs(ServerStorage:GetChildren()) do
        if tool:IsA("Tool") then
            local clone = tool:Clone()
            clone.Parent = char
            count = count + 1
        end
    end
    LogAction(plr, "tools", target, {tostring(count)})
    return true
end

function Commands:clear(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    local char = GetCharacter(target)
    if char then
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Tool") then
                child:Destroy()
            end
        end
        LogAction(plr, "clear", target, {})
        return true
    end
    return false
end

function Commands:reset(plr, args)
    local target = args[1] and GetPlayerFromArg(args[1])
    if type(target) == "table" or not target then return false end
    if target.Character then
        target.Character:BreakJoints()
        target:LoadCharacter()
        LogAction(plr, "reset", target, {})
        return true
    end
    return false
end

-- ─── ENVIRONMENT ─────────────────────────────────────────────
function Commands:night(plr, args)
    Lighting.ClockTime = 0
    LogAction(plr, "night", "Global", {})
    return true
end

function Commands:day(plr, args)
    Lighting.ClockTime = 14
    LogAction(plr, "day", "Global", {})
    return true
end

function Commands:fog(plr, args)
    local density = tonumber(args[1])
    if density then
        Lighting.FogEnd = density * 100
        LogAction(plr, "fog", "Global", {tostring(density)})
        return true
    end
    return false
end

function Commands:time(plr, args)
    local time = tonumber(args[1])
    if time then
        Lighting.ClockTime = math.clamp(time, 0, 24)
        LogAction(plr, "time", "Global", {tostring(time)})
        return true
    end
    return false
end

function Commands:rain(plr, args)
    local rain = Instance.new("Part")
    rain.Size = Vector3.new(500, 1, 500)
    rain.Position = Vector3.new(0, 400, 0)
    rain.Anchored = true
    rain.CanCollide = false
    rain.Transparency = 0.5
    rain.Material = Enum.Material.Water
    rain.BrickColor = BrickColor.new("Medium blue")
    rain.Parent = workspace
    Debris:AddItem(rain, 60)
    LogAction(plr, "rain", "Global", {})
    return true
end

function Commands:thunder(plr, args)
    for i = 1, 3 do
        local thunder = Instance.new("Part")
        thunder.Size = Vector3.new(5, 50, 5)
        thunder.Position = Vector3.new(math.random(-200, 200), 300, math.random(-200, 200))
        thunder.Anchored = true
        thunder.CanCollide = false
        thunder.BrickColor = BrickColor.new("Bright yellow")
        thunder.Material = Enum.Material.Neon
        thunder.Parent = workspace
        Debris:AddItem(thunder, 1)
        
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://115684566"
        sound.Volume = 1
        sound.Parent = thunder
        sound:Play()
        task.wait(0.2)
    end
    LogAction(plr, "thunder", "Global", {})
    return true
end

-- ─── TRUE X-RAY ──────────────────────────────────────────────
local XRayData = {}
local function ApplyXRay(target)
    if not target or not Config.XRayList[target] then return end
    
    if not XRayData[target] then
        XRayData[target] = {
            Brightness = Lighting.Brightness,
            Ambient = Lighting.Ambient,
            ColorShift_Top = Lighting.ColorShift_Top,
            ColorShift_Bottom = Lighting.ColorShift_Bottom,
            EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
            EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
            OutdoorAmbient = Lighting.OutdoorAmbient,
            ClockTime = Lighting.ClockTime
        }
    end
    
    Lighting.Brightness = 2
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.ColorShift_Top = Color3.new(1, 1, 1)
    Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
    Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    Lighting.ClockTime = 12
    
    local processed = {}
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not processed[part] then
            processed[part] = true
            
            local isTarget = false
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character and part:IsDescendantOf(player.Character) then
                    isTarget = true
                    break
                end
            end
            if isTarget then continue end
            
            if not part:GetAttribute("XRay_OriginalTransparency") then
                part:SetAttribute("XRay_OriginalTransparency", part.Transparency)
                part:SetAttribute("XRay_OriginalMaterial", part.Material.Name)
                part:SetAttribute("XRay_OriginalColor", part.Color)
            end
            
            part.Transparency = 0.65
            part.Material = Enum.Material.Glass
            part.Reflectance = 0.1
        end
    end
end

local function RemoveXRay(target)
    if not target then return end
    
    if XRayData[target] then
        Lighting.Brightness = XRayData[target].Brightness
        Lighting.Ambient = XRayData[target].Ambient
        Lighting.ColorShift_Top = XRayData[target].ColorShift_Top
        Lighting.ColorShift_Bottom = XRayData[target].ColorShift_Bottom
        Lighting.EnvironmentDiffuseScale = XRayData[target].EnvironmentDiffuseScale
        Lighting.EnvironmentSpecularScale = XRayData[target].EnvironmentSpecularScale
        Lighting.OutdoorAmbient = XRayData[target].OutdoorAmbient
        Lighting.ClockTime = XRayData[target].ClockTime
        XRayData[target] = nil
    end
    
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part:GetAttribute("XRay_OriginalTransparency") then
            part.Transparency = part:GetAttribute("XRay_OriginalTransparency")
            local mat = part:GetAttribute("XRay_OriginalMaterial")
            if mat then
                part.Material = Enum.Material[mat] or Enum.Material.Plastic
            end
            part:SetAttribute("XRay_OriginalTransparency", nil)
            part:SetAttribute("XRay_OriginalMaterial", nil)
            part:SetAttribute("XRay_OriginalColor", nil)
        end
    end
end

function Commands:xray(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    
    if Config.XRayList[target] then
        Config.XRayList[target] = nil
        RemoveXRay(target)
        LogAction(plr, "xray_off", target, {})
        if type(target) == "Player" then
            target:Chat("X-Ray turned OFF")
        end
        plr:Chat("X-Ray turned off for " .. target.Name)
        return true
    else
        Config.XRayList[target] = true
        ApplyXRay(target)
        LogAction(plr, "xray_on", target, {})
        if type(target) == "Player" then
            target:Chat("X-Ray turned ON (see through walls!)")
        end
        plr:Chat("X-Ray turned on for " .. target.Name)
        return true
    end
end

-- ─── ESP SYSTEM ────────────────────────────────────────────────
local ESPFolder = nil
local function SetupESP(target)
    if not Config.ESPList[target] then return end
    
    if not ESPFolder then
        ESPFolder = Instance.new("Folder")
        ESPFolder.Name = "ESP_Folder"
        ESPFolder.Parent = workspace
    end
    
    for _, child in ipairs(ESPFolder:GetChildren()) do
        if child:GetAttribute("TargetName") == target.Name then
            child:Destroy()
        end
    end
    
    local char = GetCharacter(target)
    if not char then return end
    
    local hrp = GetHRP(target)
    if not hrp then return end
    
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESP_Box"
    box.Size = Vector3.new(3, 5, 2)
    box.Color3 = Color3.fromRGB(255, 255, 0)
    box.Transparency = 0.3
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Parent = ESPFolder
    box:SetAttribute("TargetName", target.Name)
    
    local boxCon = RunService.Heartbeat:Connect(function()
        if not target or not target:IsA("Model") or not Config.ESPList[target] then
            boxCon:Disconnect()
            box:Destroy()
            return
        end
        local newHRP = GetHRP(target)
        if newHRP then
            box.Adornee = newHRP
        end
    end)
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Name"
    billboard.Size = UDim2.new(0, 200, 0, 40)
    billboard.AlwaysOnTop = true
    billboard.Parent = ESPFolder
    billboard:SetAttribute("TargetName", target.Name)
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = target.Name .. (IsRig(target) and " [RIG]" or "")
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.Parent = billboard
    
    local billCon = RunService.Heartbeat:Connect(function()
        if not target or not target:IsA("Model") or not Config.ESPList[target] then
            billCon:Disconnect()
            billboard:Destroy()
            return
        end
        local newHRP = GetHRP(target)
        if newHRP then
            billboard.Adornee = newHRP
            billboard.CFrame = newHRP.CFrame + Vector3.new(0, 3.5, 0)
        end
    end)
    
    local healthBar = Instance.new("BillboardGui")
    healthBar.Name = "ESP_Health"
    healthBar.Size = UDim2.new(0, 100, 0, 8)
    healthBar.AlwaysOnTop = true
    healthBar.Parent = ESPFolder
    healthBar:SetAttribute("TargetName", target.Name)
    
    local healthFrame = Instance.new("Frame")
    healthFrame.Size = UDim2.new(1, 0, 1, 0)
    healthFrame.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    healthFrame.BorderSizePixel = 0
    healthFrame.Parent = healthBar
    
    local healthBg = Instance.new("Frame")
    healthBg.Size = UDim2.new(1, 0, 1, 0)
    healthBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    healthBg.BorderSizePixel = 0
    healthBg.Parent = healthBar
    
    local healthCon = RunService.Heartbeat:Connect(function()
        if not target or not target:IsA("Model") or not Config.ESPList[target] then
            healthCon:Disconnect()
            healthBar:Destroy()
            return
        end
        local newHRP = GetHRP(target)
        if newHRP then
            healthBar.Adornee = newHRP
            healthBar.CFrame = newHRP.CFrame + Vector3.new(0, 2.5, 0)
        end
        local humanoid = GetHumanoid(target)
        if humanoid then
            local healthPercent = humanoid.Health / humanoid.MaxHealth
            healthFrame.Size = UDim2.new(healthPercent, 0, 1, 0)
            healthFrame.BackgroundColor3 = healthPercent > 0.5 and Color3.fromRGB(0, 200, 0) or
                                           healthPercent > 0.25 and Color3.fromRGB(200, 200, 0) or
                                           Color3.fromRGB(200, 0, 0)
        end
    end)
end

function Commands:esp(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    
    if Config.ESPList[target] then
        Config.ESPList[target] = nil
        if ESPFolder then
            for _, child in ipairs(ESPFolder:GetChildren()) do
                if child:GetAttribute("TargetName") == target.Name then
                    child:Destroy()
                end
            end
        end
        LogAction(plr, "esp_off", target, {})
        plr:Chat("ESP turned off for " .. target.Name)
        return true
    else
        Config.ESPList[target] = true
        SetupESP(target)
        LogAction(plr, "esp_on", target, {})
        plr:Chat("ESP turned on for " .. target.Name)
        return true
    end
end

-- ─── RIG COMMANDS ──────────────────────────────────────────────
function Commands:rig(plr, args)
    local rigs = GetAllRigs()
    if #rigs == 0 then
        plr:Chat("No rigs found in workspace")
        return true
    end
    local names = {}
    for _, rig in ipairs(rigs) do
        table.insert(names, rig.Name)
    end
    plr:Chat("Rigs found (" .. #rigs .. "): " .. table.concat(names, ", "))
    return true
end

function Commands:rigs(plr, args)
    return Commands.rig(plr, args)
end

function Commands:rigkill(plr, args)
    local rig = GetRigFromArg(args[1]) or (args[1] and GetRigFromArg(args[1]) or nil)
    if not rig then
        local allRigs = GetAllRigs()
        for _, r in ipairs(allRigs) do
            local humanoid = r:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = 0
            end
        end
        LogAction(plr, "rigkill", "ALL RIGS", {})
        plr:Chat("Killed all rigs!")
        return true
    end
    local humanoid = rig:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Health = 0
        LogAction(plr, "rigkill", rig, {})
        plr:Chat("Killed rig: " .. rig.Name)
        return true
    end
    return false
end

function Commands:rigtp(plr, args)
    local rig = GetRigFromArg(args[1])
    if not rig then return false end
    local dest = args[2] and GetTargetFromArg(args[2]) or plr
    if type(dest) == "table" then return false end
    local rigHRP = GetHRP(rig)
    local destHRP = GetHRP(dest)
    if rigHRP and destHRP then
        rigHRP.CFrame = destHRP.CFrame
        LogAction(plr, "rigtp", rig, {dest.Name})
        plr:Chat("Teleported rig " .. rig.Name .. " to " .. dest.Name)
        return true
    end
    return false
end

function Commands:rigbring(plr, args)
    local rig = GetRigFromArg(args[1])
    if not rig then return false end
    local plrHRP = GetHRP(plr)
    local rigHRP = GetHRP(rig)
    if plrHRP and rigHRP then
        rigHRP.CFrame = plrHRP.CFrame
        LogAction(plr, "rigbring", rig, {})
        plr:Chat("Brought rig " .. rig.Name .. " to you")
        return true
    end
    return false
end

function Commands:rigfreeze(plr, args)
    local rig = GetRigFromArg(args[1])
    if not rig then return false end
    local hrp = GetHRP(rig)
    if hrp then
        hrp.Anchored = true
        LogAction(plr, "rigfreeze", rig, {})
        plr:Chat("Froze rig: " .. rig.Name)
        return true
    end
    return false
end

function Commands:rigunfreeze(plr, args)
    local rig = GetRigFromArg(args[1])
    if not rig then return false end
    local hrp = GetHRP(rig)
    if hrp then
        hrp.Anchored = false
        LogAction(plr, "rigunfreeze", rig, {})
        plr:Chat("Unfroze rig: " .. rig.Name)
        return true
    end
    return false
end

function Commands:righeal(plr, args)
    local rig = GetRigFromArg(args[1])
    if not rig then
        local allRigs = GetAllRigs()
        for _, r in ipairs(allRigs) do
            local humanoid = r:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = humanoid.MaxHealth
            end
        end
        LogAction(plr, "righeal", "ALL RIGS", {})
        plr:Chat("Healed all rigs!")
        return true
    end
    local humanoid = rig:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Health = humanoid.MaxHealth
        LogAction(plr, "righeal", rig, {})
        plr:Chat("Healed rig: " .. rig.Name)
        return true
    end
    return false
end

function Commands:rigrevive(plr, args)
    local rig = GetRigFromArg(args[1])
    if not rig then
        local allRigs = GetAllRigs()
        for _, r in ipairs(allRigs) do
            local humanoid = r:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health <= 0 then
                humanoid.Health = 100
            end
        end
        LogAction(plr, "rigrevive", "ALL RIGS", {})
        plr:Chat("Revived all rigs!")
        return true
    end
    local humanoid = rig:FindFirstChild("Humanoid")
    if humanoid and humanoid.Health <= 0 then
        humanoid.Health = 100
        LogAction(plr, "rigrevive", rig, {})
        plr:Chat("Revived rig: " .. rig.Name)
        return true
    end
    return false
end

function Commands:rigclone(plr, args)
    local rig = GetRigFromArg(args[1])
    if not rig then return false end
    local count = tonumber(args[2]) or 1
    local hrp = GetHRP(rig)
    if not hrp then return false end
    
    for i = 1, math.min(count, 10) do
        local clone = rig:Clone()
        clone.Name = rig.Name .. "_Clone" .. i
        clone.Parent = workspace
        local cloneHRP = GetHRP(clone)
        if cloneHRP then
            cloneHRP.CFrame = hrp.CFrame + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
        end
        local humanoid = clone:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Parent = clone
        end
        task.wait(0.1)
    end
    LogAction(plr, "rigclone", rig, {tostring(count)})
    plr:Chat("Cloned " .. rig.Name .. " " .. count .. " times")
    return true
end

function Commands:rigremove(plr, args)
    local rig = GetRigFromArg(args[1])
    if not rig then
        local allRigs = GetAllRigs()
        for _, r in ipairs(allRigs) do
            r:Destroy()
        end
        LogAction(plr, "rigremove", "ALL RIGS", {})
        plr:Chat("Removed all rigs!")
        return true
    end
    rig:Destroy()
    LogAction(plr, "rigremove", rig, {})
    plr:Chat("Removed rig: " .. rig.Name)
    return true
end

function Commands:rigexplode(plr, args)
    local rig = GetRigFromArg(args[1])
    if not rig then return false end
    local hrp = GetHRP(rig)
    if hrp then
        local explosion = Instance.new("Explosion")
        explosion.Position = hrp.Position
        explosion.BlastRadius = 20
        explosion.BlastPressure = 150
        explosion.Parent = workspace
        LogAction(plr, "rigexplode", rig, {})
        plr:Chat("Exploded rig: " .. rig.Name)
        return true
    end
    return false
end

function Commands:rigsmite(plr, args)
    local rig = GetRigFromArg(args[1])
    if not rig then return false end
    local hrp = GetHRP(rig)
    if hrp then
        local part = Instance.new("Part")
        part.Size = Vector3.new(8, 8, 8)
        part.CFrame = hrp.CFrame + Vector3.new(0, 25, 0)
        part.Anchored = true
        part.CanCollide = false
        part.Transparency = 0.5
        part.BrickColor = BrickColor.new("Bright yellow")
        part.Material = Enum.Material.Neon
        part.Parent = workspace
        Debris:AddItem(part, 2)
        
        local explosion = Instance.new("Explosion")
        explosion.Position = hrp.Position
        explosion.BlastRadius = 15
        explosion.BlastPressure = 80
        explosion.Parent = workspace
        explosion.Hit:Connect(function(hit)
            local humanoid = hit.Parent:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = 0
            end
        end)
        LogAction(plr, "rigsmite", rig, {})
        plr:Chat("Smited rig: " .. rig.Name)
        return true
    end
    return false
end

-- ─── UTILITY ──────────────────────────────────────────────────
function Commands:logs(plr, args)
    local page = tonumber(args[1]) or 1
    local start = (page - 1) * 10 + 1
    for i = start, math.min(start + 9, #Logs) do
        plr:Chat(Logs[i])
    end
    return true
end

function Commands:admin(plr, args)
    local gui = plr.PlayerGui:FindFirstChild("AdminGUI")
    if gui then
        local mainFrame = gui:FindFirstChild("MainFrame")
        if mainFrame then
            mainFrame.Visible = not mainFrame.Visible
        end
    end
    return true
end

function Commands:shutdown(plr, args)
    if GetRankLevel(plr) >= 4 then
        game:Shutdown()
        LogAction(plr, "shutdown", "Server", {})
        return true
    end
    return false
end

function Commands:rejoin(plr, args)
    plr:LoadCharacter()
    return true
end

function Commands:serverhop(plr, args)
    local placeId = game.PlaceId
    local jobId = game.JobId
    TeleportService:TeleportToPlaceInstance(placeId, jobId, plr)
    return true
end

function Commands:playtime(plr, args)
    local target = args[1] and GetPlayerFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    local time = math.floor(os.time() - (target:GetAttribute("JoinTime") or os.time()))
    local hours = math.floor(time / 3600)
    local minutes = math.floor((time % 3600) / 60)
    plr:Chat(string.format("%s playtime: %dh %dm", target.Name, hours, minutes))
    return true
end

function Commands:rank(plr, args)
    local target = args[1] and GetPlayerFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    plr:Chat(string.format("%s rank: %s", target.Name, GetPlayerRankName(target)))
    return true
end

function Commands:setrank(plr, args)
    return true
end

function Commands:whois(plr, args)
    local target = args[1] and GetPlayerFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    plr:Chat(string.format("%s | ID: %d | Rank: %s | Display: %s | Ping: %dms",
        target.Name, target.UserId, GetPlayerRankName(target), 
        target.DisplayName, math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())))
    return true
end

function Commands:online(plr, args)
    local online = Players:GetPlayers()
    local names = {}
    for _, p in ipairs(online) do
        table.insert(names, p.Name .. " [" .. GetPlayerRankName(p) .. "]")
    end
    local rigs = GetAllRigs()
    plr:Chat("Online (" .. #online .. " players, " .. #rigs .. " rigs): " .. table.concat(names, ", "))
    return true
end

function Commands:ping(plr, args)
    local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    plr:Chat("Ping: " .. tostring(ping) .. "ms")
    return true
end

function Commands:uptime(plr, args)
    local uptime = math.floor(os.time() - (workspace:GetAttribute("StartTime") or os.time()))
    local hours = math.floor(uptime / 3600)
    local minutes = math.floor((uptime % 3600) / 60)
    local seconds = math.floor(uptime % 60)
    plr:Chat(string.format("Server uptime: %dh %dm %ds", hours, minutes, seconds))
    return true
end

function Commands:stats(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    local humanoid = GetHumanoid(target)
    if humanoid then
        local hrp = GetHRP(target)
        local pos = hrp and hrp.Position or Vector3.new(0,0,0)
        plr:Chat(string.format("%s | Health: %d/%d | Speed: %d | Jump: %d | Pos: %.1f, %.1f, %.1f",
            target.Name, humanoid.Health, humanoid.MaxHealth,
            humanoid.WalkSpeed, humanoid.JumpPower, pos.X, pos.Y, pos.Z))
    end
    return true
end

function Commands:players(plr, args)
    local online = Players:GetPlayers()
    local count = #online
    local rigs = GetAllRigs()
    plr:Chat("Total players: " .. count .. " | Rigs: " .. #rigs)
    for i, p in ipairs(online) do
        plr:Chat(string.format("%d. %s [%s] - %s", i, p.Name, GetPlayerRankName(p), 
            p.Character and "Alive" or "Dead"))
    end
    return true
end

function Commands:commands(plr, args)
    local cmds = {}
    for cmd, _ in pairs(Commands) do
        if HasPermission(plr, cmd) then
            table.insert(cmds, cmd)
        end
    end
    table.sort(cmds)
    local page = tonumber(args[1]) or 1
    local perPage = 15
    local start = (page - 1) * perPage + 1
    local endIdx = math.min(start + perPage - 1, #cmds)
    plr:Chat("=== Commands (page " .. page .. "/" .. math.ceil(#cmds/perPage) .. ") ===")
    for i = start, endIdx do
        plr:Chat("/" .. cmds[i])
    end
    return true
end

function Commands:me(plr, args)
    local msg = table.concat(args, " ")
    for _, p in ipairs(Players:GetPlayers()) do
        p:Chat("* " .. plr.Name .. " " .. msg)
    end
    return true
end

function Commands:report(plr, args)
    local msg = table.concat(args, " ")
    LogAction(plr, "report", "N/A", {msg})
    print("REPORT from " .. plr.Name .. ": " .. msg)
    plr:Chat("Report sent to admins!")
    return true
end

function Commands:help(plr, args)
    return Commands.commands(plr, args)
end

-- ─── BREAK / UNBREAK ──────────────────────────────────────────
function Commands:break(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    local char = GetCharacter(target)
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.BreakJointsOnDeath = true
            end
        end
    end
    return true
end

function Commands:unbreak(plr, args)
    local target = GetTargetFromArg(args[1]) or plr
    if type(target) == "table" then return false end
    local char = GetCharacter(target)
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.BreakJointsOnDeath = false
            end
        end
    end
    return true
end

-- ─── CLONES ──────────────────────────────────────────────────
function Commands:clones(plr, args)
    local count = tonumber(args[1]) or 5
    local target = GetTargetFromArg(args[2]) or plr
    if type(target) == "table" then return false end
    local hrp = GetHRP(target)
    if not hrp then return false end
    local char = GetCharacter(target)
    if not char then return false end
    
    for i = 1, math.min(count, 20) do
        local clone = char:Clone()
        clone.Name = target.Name .. "_Clone" .. i
        clone.Parent = workspace
        local cloneHRP = GetHRP(clone)
        if cloneHRP then
            cloneHRP.CFrame = hrp.CFrame + Vector3.new(math.random(-15, 15), 0, math.random(-15, 15))
        end
        local humanoid = clone:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Parent = clone
        end
        task.wait(0.1)
    end
    LogAction(plr, "clones", target, {tostring(count)})
    plr:Chat("Cloned " .. target.Name .. " " .. count .. " times")
    return true
end

-- ==================== COMMAND PARSER ====================
if Chat then
    Chat.OnMessageDoneFiltering.OnClientEvent:Connect(function(msgData)
        local msg = msgData.Message
        local plr = msgData.FromSpeaker
        if not plr or not msg then return end
        
        local lowerMsg = string.lower(msg)
        
        -- Assistant chat commands (no prefix)
        if lowerMsg == "open" then
            task.spawn(function() openAssistant(plr) end)
            return
        end
        if lowerMsg == "close" then
            task.spawn(function() closeAssistant(plr) end)
            return
        end
        if lowerMsg == "toggle" then
            task.spawn(function() toggleAssistant(plr) end)
            return
        end
        if string.sub(lowerMsg, 1, 5) == "kill " then
            local targetName = string.sub(msg, 6)
            if targetName ~= "" then
                task.spawn(function() attackTarget(plr, targetName) end)
            end
            return
        end
        
        -- Admin commands with prefix
        if string.sub(msg, 1, 1) ~= Config.Prefix then return end
        if Config.MuteList[plr] then return end
        
        local args = {}
        for word in string.gmatch(msg, "%S+") do
            table.insert(args, word)
        end
        
        local cmdName = string.lower(string.sub(args[1], 2))
        table.remove(args, 1)
        
        if Aliases[cmdName] then
            cmdName = Aliases[cmdName]
        end
        
        if HasPermission(plr, cmdName) and Commands[cmdName] then
            local success, err = pcall(Commands[cmdName], plr, args)
            if not success and Config.Logging then
                warn("Command error (" .. cmdName .. "): " .. tostring(err))
                plr:Chat("Error: " .. tostring(err))
            end
        elseif Commands[cmdName] then
            plr:Chat("No permission for /" .. cmdName)
        end
    end)
end

-- ==================== ANTI-EXPLOIT ====================
if Config.AntiExploit then
    RunService.Heartbeat:Connect(function()
        for _, plr in ipairs(Players:GetPlayers()) do
            local humanoid = GetHumanoid(plr)
            if humanoid then
                if humanoid.WalkSpeed > Config.MaxSpeed and not Config.FlyList[plr] then
                    humanoid.WalkSpeed = Config.MaxSpeed
                end
                if humanoid.JumpPower > Config.MaxJumpPower then
                    humanoid.JumpPower = Config.MaxJumpPower
                end
            end
            
            if Config.GodList[plr] then
                local humanoid = GetHumanoid(plr)
                if humanoid then
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                end
            end
            
            if Config.FreezeList[plr] then
                local hrp = GetHRP(plr)
                if hrp then hrp.Anchored = true end
            end
            
            if Config.NoclipList[plr] then
                local char = GetCharacter(plr)
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end
            
            if Config.InvisList[plr] then
                local char = GetCharacter(plr)
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") or part:IsA("Accoutrement") then
                            part.Transparency = 1
                        end
                    end
                end
            end
            
            if Config.XRayList[plr] then
                ApplyXRay(plr)
            end
        end
        
        -- ESP for rigs
        for rig, _ in pairs(Config.ESPList) do
            if type(rig) ~= "Player" and IsRig(rig) then
                SetupESP(rig)
            end
        end
        
        -- Keep assistants alive
        for owner, data in pairs(assistants) do
            if data and data.Humanoid and data.IsOpen then
                data.Humanoid.Health = 999999
                
                local char = owner.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
                    if root then
                        local dist = (data.Root.Position - root.Position).Magnitude
                        if dist > Config.AssistantFollowDistance and not data.IsAttacking then
                            data.Humanoid:MoveTo(root.Position + Vector3.new(3, 0, 3))
                        end
                    end
                end
            end
        end
    end)
    
    Players.PlayerRemoving:Connect(function(player)
        if Config.XRayList[player] then
            RemoveXRay(player)
            Config.XRayList[player] = nil
        end
        if XRayData[player] then
            XRayData[player] = nil
        end
        Config.ESPList[player] = nil
        Config.FlyList[player] = nil
        Config.GodList[player] = nil
        Config.InvisList[player] = nil
        Config.NoclipList[player] = nil
        Config.FreezeList[player] = nil
        Config.MuteList[player] = nil
        
        local data = assistants[player]
        if data and data.Model then
            data.Model:Destroy()
            assistants[player] = nil
        end
    end)
    
    Players.PlayerAdded:Connect(function(player)
        player:SetAttribute("JoinTime", os.time())
        player.CharacterAdded:Connect(function(character)
            if Config.GodList[player] then
                local humanoid = character:WaitForChild("Humanoid")
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
            end
            if Config.InvisList[player] then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("Accoutrement") then
                        part.Transparency = 1
                    end
                end
            end
            if Config.NoclipList[player] then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
            if Config.ESPList[player] then
                task.wait(1)
                SetupESP(player)
            end
            if Config.XRayList[player] then
                task.wait(1)
                ApplyXRay(player)
            end
            task.wait(2)
            openAssistant(player)
        end)
    end)
    
    -- Auto-open for existing players
    for _, player in ipairs(Players:GetPlayers()) do
        task.spawn(function()
            task.wait(1)
            openAssistant(player)
        end)
    end
end

-- ==================== HD GUI ====================
local function CreateGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AdminGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = CoreGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 600, 0, 700)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -350)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Visible = false
    mainFrame.Parent = screenGui
    
    local title = Instance.new("Frame")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
    title.BorderSizePixel = 0
    title.Parent = mainFrame
    
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -50, 1, 0)
    titleText.Position = UDim2.new(0, 10, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "🤖 HYBRID ADMIN v7.0 — ASSISTANT"
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Font = Enum.Font.GothamBold
    titleText.TextSize = 18
    titleText.Parent = title
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 40, 1, 0)
    closeBtn.Position = UDim2.new(1, -40, 0, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = title
    closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)
    
    local cmdInput = Instance.new("TextBox")
    cmdInput.Size = UDim2.new(1, -20, 0, 35)
    cmdInput.Position = UDim2.new(0, 10, 0, 55)
    cmdInput.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    cmdInput.BorderSizePixel = 0
    cmdInput.PlaceholderText = "Type command (use / in chat)..."
    cmdInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 170)
    cmdInput.TextColor3 = Color3.new(1, 1, 1)
    cmdInput.Font = Enum.Font.Gotham
    cmdInput.TextSize = 14
    cmdInput.Parent = mainFrame
    cmdInput.FocusLost:Connect(function(enter)
        if enter and cmdInput.Text ~= "" then
            if Chat then
                local sendMessage = Chat:FindFirstChild("SendMessage")
                if sendMessage then
                    sendMessage:FireServer(cmdInput.Text)
                end
            end
            cmdInput.Text = ""
        end
    end)
    
    local statsBar = Instance.new("Frame")
    statsBar.Size = UDim2.new(1, -20, 0, 25)
    statsBar.Position = UDim2.new(0, 10, 0, 95)
    statsBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    statsBar.BorderSizePixel = 0
    statsBar.Parent = mainFrame
    
    local statsLabel = Instance.new("TextLabel")
    statsLabel.Size = UDim2.new(1, 0, 1, 0)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Text = "👥 0 players | 🤖 0 rigs | 📋 0 commands"
    statsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    statsLabel.Font = Enum.Font.Gotham
    statsLabel.TextSize = 12
    statsLabel.Parent = statsBar
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 1, -145)
    scrollFrame.Position = UDim2.new(0, 10, 0, 125)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.Parent = mainFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 3)
    listLayout.Parent = scrollFrame
    
    local function UpdateStats()
        local playerCount = #Players:GetPlayers()
        local rigCount = #GetAllRigs()
        local cmdCount = 0
        for _, _ in pairs(Commands) do cmdCount = cmdCount + 1 end
        statsLabel.Text = string.format("👥 %d | 🤖 %d | 📋 %d | 🤖 Assistant ready!", playerCount, rigCount, cmdCount)
    end
    
    local function RefreshCommands()
        for _, child in ipairs(scrollFrame:GetChildren()) do
            if child:IsA("TextLabel") then child:Destroy() end
        end
        
        local cmdList = {}
        for cmd, _ in pairs(Commands) do
            table.insert(cmdList, cmd)
        end
        table.sort(cmdList)
        
        for _, cmd in ipairs(cmdList) do
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 28)
            label.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            label.BackgroundTransparency = 0.5
            label.BorderSizePixel = 0
            label.Text = "/" .. cmd
            label.TextColor3 = Color3.fromRGB(200, 220, 255)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Font = Enum.Font.Gotham
            label.TextSize = 13
            label.Parent = scrollFrame
        end
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #cmdList * 31)
        UpdateStats()
    end
    RefreshCommands()
    
    task.spawn(function()
        while true do
            task.wait(5)
            UpdateStats()
        end
    end)
    
    return screenGui, mainFrame
end

local guiInstances = {}
Players.PlayerAdded:Connect(function(player)
    local gui, frame = CreateGUI()
    guiInstances[player] = gui
    gui.Parent = player:WaitForChild("PlayerGui")
    player:SetAttribute("JoinTime", os.time())
end)

Players.PlayerRemoving:Connect(function(player)
    if guiInstances[player] then
        guiInstances[player]:Destroy()
        guiInstances[player] = nil
    end
end)

workspace:SetAttribute("StartTime", os.time())

-- ==================== INITIALIZATION ====================
print("═══════════════════════════════════════════════════════════════")
print("  🤖 HYBRID ADMIN v7.0 — PERSONAL ASSISTANT EDITION 🤖")
print("  • Commands: " .. #Commands)
print("  • Aliases: " .. #Aliases)
print("  • TRUE X-RAY: ACTIVE")
print("  • ESP System: ACTIVE")
print("  • RIG SUPPORT: ACTIVE")
print("  • PERSONAL ASSISTANT: ACTIVE")
print("═══════════════════════════════════════════════════════════════")
print("📌 ASSISTANT COMMANDS:")
print("   'open' or /open - Spawn your assistant")
print("   'close' or /close - Despawn your assistant")
print("   'toggle' or /toggle - Toggle assistant")
print("   'kill (name)' or /akill @name - Kill target")
print("   /assistant - Check assistant status")
print("═══════════════════════════════════════════════════════════════")
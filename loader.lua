local GameID = game.GameId
local Player = game:GetService("Players").LocalPlayer

if GameID ~= 8204899140 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/senzoadmin/featherlite/refs/heads/main/ff2script.lua"))() -- FF2
else
if GameID ~= 2338325648 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/senzoadmin/featherlite/refs/heads/main/nfluniverse.lua"))() -- NFL
else
if GameID ~= 18668065416 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/senzoadmin/featherlite/refs/heads/main/bluelockr.lua"))() -- NFL
else
    Player:Kick("Feather | Game currently unsupported. Check the Status Channel for supported games.")
end

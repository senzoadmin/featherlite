local GameID = game.GameId
local Player = game:GetService("Players").LocalPlayer

if GameID ~= 4483381587 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/senzoadmin/featherlite/refs/heads/main/featherlite.lua"))() -- FF2
else
    Player:Kick("Feather | Game currently unsupported. Check the Status Channel for supported games.")
end

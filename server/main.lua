local players = {}

AddEventHandler("playerConnecting", function()
    table.insert(players, {id=source,team="",squad=0,kills=0,deaths=0})
end)
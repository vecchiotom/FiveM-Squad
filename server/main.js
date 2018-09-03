var America = new Team("America");
var Russia = new Team("Russia");
var players = {};


on("playerConnecting", (name,SetKickReason,TempSource)=>{
    // create a new player
    var temp = new Player(TempSource)
    players[temp.serverid.toString()]=temp
})

onNet("Squad:TeamChosen", (team)=>{
    var source = source
    switch (team) {
        case "America":
            America.AddPlayer(players[source.toString()]);
            break;
        case "Russia":
            Russia.AddPlayer(players[source.toString()]);
    }
})
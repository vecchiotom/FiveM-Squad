class Team {
    constructor(name) {
        this.name = name;
        this.id = name;
        this.Players = [];
    }

    set AddPlayer(squad) {
        this.Players.push(squad);
        return;
    }

    get GetPlayers() {
        return this.Players;
    }
}


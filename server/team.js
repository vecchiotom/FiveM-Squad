class Team {
    constructor(name) {
        this.name = name;
        this.id = name;
        this.squads = [];
    }

    set AddSquad(squad) {
        this.squads.push(squad);
        return;
    }

    get GetSquads() {
        return this.squads;
    }
}


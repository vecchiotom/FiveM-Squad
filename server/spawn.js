class SpawnPoint {
    constructor(x,y,z,team) {
        this.coords = {x:x,y:y,z:z};
        this.team = team
    }
    get Team() {
        return this.team
    }
    get Coords() {
        return this.coords
    }
}
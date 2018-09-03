class Player {
    constructor(serverid) {
        this.serverid = serverid
        this.identifiers = GetPlayerIdentifiers(serverid)
    }
}
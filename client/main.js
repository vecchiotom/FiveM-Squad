let FirstSpawn = true
on("playerSpawned", ()=>{
    setImmediate(()=>{
        FirstSpawn = false;
        SetEntityCoords(PlayerPedId(), 0.0, 0.0, 500.0)
        emit("chatMessage","Fivem-Squad",[0,0,255],"Welcome to the FiveM-Squad server, please choose a team by using the following command: /chooseteam [America/Russia]")
        FreezeEntityPosition(PlayerPedId(), true)
        setTick(ForceFirstPerson)
    })
})

RegisterCommand("chooseteam", (args,raw,source)=>{
    if (args[0] != "America" || args[0] != "Russia") {
        emit("chatMessage","ERROR:",[255,0,0],"That team doesn't exist, please choose either America or Russia.")   
    } else {
        emitNet("Squad:TeamChosen", args[1]);
    }
}, false);

function ForceFirstPerson() {
    RenderFirstPersonCam(true, 0.0, 3);
    HideHudComponentThisFrame(14);
    HideHudAndRadarThisFrame();
}
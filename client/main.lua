local firstspawn=true
function ForceFirstPerson()
    RenderFirstPersonCam(true)
    HideHudAndRadarThisFrame()
end

AddEventHandler("playerSpawned", function()
    if firstspawn then
        CreateThread(function()
            while true do
                ForceFirstPerson()
            end
        end)
    end
end)

exports.spawnmanager:setAutoSpawnCallback(function()
    for i,spawnpoint in ipairs(spawnpoints) do
        if spawnpoint.squad == squad and spawnpoint.team == team then
            Citizen.CreateThread(function()
                DoScreenFadeOut(500)
        
                while IsScreenFadingOut() do
                    Citizen.Wait(0)
                end
        
                -- freeze the local player
                freezePlayer(PlayerId(), true)
        
                -- if the spawn has a model set
                if spawnpoint.model then
                    RequestModel(spawnpoint.model)
        
                    -- load the model for this spawn
                    while not HasModelLoaded(spawnpoint.model) do
                        RequestModel(spawnpoint.model)
        
                        Wait(0)
                    end
        
                    -- change the player model
                    SetPlayerModel(PlayerId(), spawnpoint.model)
        
                    -- release the player model
                    SetModelAsNoLongerNeeded(spawnpoint.model)
                end
        
                -- preload collisions for the spawnpoint
                RequestCollisionAtCoord(spawnpoint.x, spawnpoint.y, spawnpoint.z)
        
                -- spawn the player
                --ResurrectNetworkPlayer(GetPlayerId(), spawn.x, spawn.y, spawn.z, spawn.heading)
                local ped = GetPlayerPed(-1)
        
                -- V requires setting coords as well
                SetEntityCoordsNoOffset(ped, spawnpoint.x, spawnpoint.y, spawnpoint.z, false, false, false, true)
        
                NetworkResurrectLocalPlayer(spawnpoint.x, spawnpoint.y, spawnpoint.z, spawnpoint.heading, true, true, false)
        
                -- gamelogic-style cleanup stuff
                ClearPedTasksImmediately(ped)
                --SetEntityHealth(ped, 300) -- TODO: allow configuration of this?
                RemoveAllPedWeapons(ped) -- TODO: make configurable (V behavior?)
                ClearPlayerWantedLevel(PlayerId())
        
                -- why is this even a flag?
                --SetCharWillFlyThroughWindscreen(ped, false)
        
                -- set primary camera heading
                --SetGameCamHeading(spawn.heading)
                --CamRestoreJumpcut(GetGameCam())
        
                -- load the scene; streaming expects us to do it
                --ForceLoadingScreen(true)
                --loadScene(spawn.x, spawn.y, spawn.z)
                --ForceLoadingScreen(false)
        
                while not HasCollisionLoadedAroundEntity(ped) do
                    Citizen.Wait(0)
                end
        
                ShutdownLoadingScreen()
        
                DoScreenFadeIn(500)
        
                while IsScreenFadingIn() do
                    Citizen.Wait(0)
                end
        
                -- and unfreeze the player
                freezePlayer(PlayerId(), false)
        
                TriggerEvent('playerSpawned', spawnpoint)
            end)
        end
    end
end)
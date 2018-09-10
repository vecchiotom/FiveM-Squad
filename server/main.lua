local players = {}

AddEventHandler("playerConnecting", function()
    table.insert(players, {id=source,team="",squad=0,kills=0,deaths=0})
end)

local verFile = LoadResourceFile(GetCurrentResourceName(), "version.json")
local curVersion = json.decode(verFile).version
Citizen.CreateThread( function()
	local updatePath = "/vecchiotom/FiveM-Squad"
	local resourceName = "FiveM-Squad ("..GetCurrentResourceName()..")"
	PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/master/version.json", function(err, response, headers)
		local data = json.decode(response)


		if curVersion ~= data.version and tonumber(curVersion) < tonumber(data.version) then
			print("\n--------------------------------------------------------------------------")
			print("\n"..resourceName.." is outdated.\nCurrent Version: "..data.version.."\nYour Version: "..curVersion.."\nPlease update it from https://github.com"..updatePath.."")
			print("\nUpdate Changelog:\n"..data.changelog)
			print("\n--------------------------------------------------------------------------")
		elseif tonumber(curVersion) > tonumber(data.version) then
			print("Your version of "..resourceName.." seems to be higher than the current version.")
		else
			print(resourceName.." is up to date!")
		end
	end, "GET", "", {version = 'this'})
end)

--[[

  ESX RP Chat

--]]

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "^4" .. name .. "", {0, 153, 204}, "^7 " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "^4" .. name .. "", {0, 153, 204}, "^7 " .. message)
  end
end)

--[[
RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
  end
end)
--]]
--[[
RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."  ".."^0  " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."  ".."^0  " .. message)
  end
end)
--]]
--[[
AddEventHandler('esx-qalle-chat:me', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(86, 125, 188, 0.6); border-radius: 3px;"><i class="fas fa-user-circle"></i> {0}:<br> {1}</div>',
            args = { name, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 15.4 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(86, 125, 188, 0.6); border-radius: 3px;"><i class="fas fa-user-circle"></i> {0}:<br> {1}</div>',
            args = { name, message }
        })
    end
end)--]]

-- Settings
local color = { r = 220, g = 220, b = 220, alpha = 255 } -- Color of the text
local font = 0 -- Font of the text
local time = 7000 -- Duration of the display of the text : 1000ms = 1sec
local background = {
    enable = true,
    color = { r = 35, g = 35, b = 35, alpha = 150 },
}
local chatMessage = true
local dropShadow = false

-- Don't touch
local nbrDisplaying = 1

RegisterCommand('me', function(source, args)

    local text = '*' -- edit here if you want to change the language : EN: the person / FR: la personne
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ' *'
    TriggerServerEvent('3dme:shareDisplay', text)
end)

RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source)
    local offset = (nbrDisplaying*0.14)
    Display(GetPlayerFromServerId(source), text, offset)
end)

function Display(mePlayer, text, offset)
    local displaying = true

    --[[ Chat message
    if chatMessage then
        local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
        local coords = GetEntityCoords(PlayerPedId(), false)
        local dist = Vdist2(coordsMe, coords)
        if dist < 2500 then
            TriggerEvent('chat:addMessage', {
                color = { color.r, color.g, color.b },
                multiline = true,
                args = { text}
            })
        end
    end
	--]]
    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 2500 then
                DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100

    if onScreen then

        -- Formalize the text
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextCentre(true)
        if dropShadow then
            SetTextDropshadow(10, 100, 100, 100, 255)
        end

        -- Calculate width and height
        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.55*scale, font)
        local width = EndTextCommandGetWidth(font)

        -- Diplay the text
        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)

        if background.enable then
            DrawRect(_x, _y+scale/45, width+0.003, height + 0.005, background.color.r, background.color.g, background.color.b , background.color.alpha)
        end
    end
end

RegisterCommand('rolld6', function(source, args)
    local text = 'Rolled: ' .. math.random(1,6) .. '/6' -- edit here if you want to change the language : EN: the person / FR: la personne
    rolldice()
    TriggerServerEvent('3dme:shareDisplay', text)
end)

RegisterCommand('rolld20', function(source, args)
    local text = 'Rolled: ' .. math.random(1,20) .. '/20' -- edit here if you want to change the language : EN: the person / FR: la personne
    rolldice()
    TriggerServerEvent('3dme:shareDisplay', text)
end)

TriggerEvent('chat:addSuggestion', '/roll', 'Roll some 6 sided dice!', {
{ name="#", help="Number of dice to roll! Default is 3!" }
})

RegisterCommand('roll', function(source, args)
  local text
  if args[1] == nil then
    print('DEFUALT')
    local num1 = math.random(1,6)
    local num2 = math.random(1,6)
    local num3 = math.random(1,6)
     text = 'Rolled: ' .. num1 .. ', ' .. num2 .. ', ' .. num3 .. ' (' .. num1+num2+num3 ..')' -- edit here if you want to change the language : EN: the person / FR: la personne
  else

    local numDice = tonumber(args[1])

    if numDice == nil then
      TriggerEvent('esx:showNotification', '~r~/Roll requires a "number" of dice!')
      return -1
    end

    if numDice > 25 then
      TriggerEvent('esx:showNotification', '~r~Cannot roll more then 25 dice!')
      return -1
    end

    print(numDice .. ' dice')
    local diceRolls = {}
    local totalDice = 0
    text = 'Rolled ' .. numDice .. ' dice: '
    for i = 0, numDice - 1 do
        diceRolls[i] = math.random(1,6)
        totalDice = totalDice + diceRolls[i]
        if not(i == numDice - 1) then
          text = text .. diceRolls[i] .. ', '
        else
          text = text .. diceRolls[i] .. ' (' .. totalDice .. ')'
        end
        print(i .. ', '..numDice)
    end
  end
  rolldice()
  TriggerServerEvent('3dme:shareDisplay', text)
end)

function rolldice()
  loadAnimDict("anim@mp_player_intcelebrationmale@wank")
  TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
  Citizen.Wait(1400)
  ClearPedTasks(GetPlayerPed(-1))
end

function loadAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
   RequestAnimDict( dict )
   Citizen.Wait(5)
  end
end

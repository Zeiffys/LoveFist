ESX = nil
PlayerData = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

--[[
	Usage: 
		All optional
		menu = {
			type = 'default'
			title = 'title',
			name = 'name',
			align = 'bottom-right'
			options = {
				{
					label = 'label',
					action = function(action)
				}
			},
			close = function()
		}
		TriggerEvent('disc-base:openMenu', menu)
]]

RegisterNetEvent('disc-base:openMenu')
AddEventHandler('disc-base:openMenu', function(menu)

    local type = getOrElse(menu.type, 'default')

    if type == 'default' then
        OpenDefaultMenu(menu)
    elseif type == 'dialog' then
        OpenDialogMenu(menu)
    elseif type == 'list' then
        OpenListMenu(menu)
    end
end)

function OpenDefaultMenu(menu)

    local emptyMenu = { { label = 'Empty Menu', action = nil } }

    local elements = {}
    local actions = {}

    for k, v in pairs(getOrElse(menu.options, emptyMenu)) do
        local key = getOrElse(v.value, k)
        table.insert(elements, { label = v.label, value = key })
        actions[key] = v.action
    end

    ESX.UI.Menu.Open(getOrElse(menu.type, 'default'), GetCurrentResourceName(), getOrElse(menu.name, getOrElse(menu.title, 'default-menu-name')), {
        title = getOrElse(menu.title, 'default-menu-title'),
        align = getOrElse(menu.align, 'bottom-right'),
        elements = getOrElse(elements, emptyMenu)
    },
            function(data, m)
                if getOrElse(actions[data.current.value], nil) then
                    actions[data.current.value](data.current, m)
                else
                    exports['mythic_notify']:DoHudText('error', 'This menu has no action!')
                end
            end,
            function(data, m)
                if getOrElse(menu.close, nil) then
                    menu.close()
                end
                m.close()
            end)
end

function OpenDialogMenu(menu)
    ESX.UI.Menu.Open(getOrElse(menu.type, 'dialog'), GetCurrentResourceName(), getOrElse(menu.name, getOrElse(menu.title, 'default-menu-name')), {
        title = getOrElse(menu.title, 'default-menu-title'),
        align = getOrElse(menu.align, 'middle')
    },
            function(data, m)
                if getOrElse(menu.action, nil) then
                    menu.action(data.value)
                    m.close()
                else
                    exports['mythic_notify']:DoHudText('error', 'This menu has no action!')
                end
            end,
            function(data, m)
                if getOrElse(menu.close, nil) then
                    menu.close()
                end
                m.close()
            end)
end



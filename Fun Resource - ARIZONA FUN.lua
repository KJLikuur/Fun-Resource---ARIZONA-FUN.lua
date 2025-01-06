local fa = require("fAwesome6")
local sampev = require("samp.events")
local imgui = require 'mimgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
local u8 = encoding.UTF8
local ffi = require 'ffi'
local http = require("socket.http")
local ltn12 = require("ltn12")
local lfs = require("lfs")
local sf = require 'sampfuncs'
local gta = ffi.load("GTASA")
local request = require("requests")
local inicfg = require 'inicfg'
local monet = require("MoonMonet")
local new, str = imgui.new, ffi.string
local MDS = MONET_DPI_SCALE
local new = imgui.new
local AI_TOGGLE = {}
local ToU32 = imgui.ColorConvertFloat4ToU32
local AdminMemugl = new.bool()
local window = new.bool()
local tab = 1
local widgets = require('widgets') -- for WIDGET_(...)
local memory = require('memory')

       if doesFileExist("tmute.json") then
        sampAddChatMessage("Файл загружен!",-1)
    else
    	local file = io.open("tmute.json", "a")        
        file:write('{"Мут" : ["МУят"]}')
        file:close()
    end
    if doesFileExist("tban.json") then
        sampAddChatMessage("Файл загружен !",-1)
    else
    local file = io.open("tban.json", "a")        
        file:write('{"Бан" : ["БАН"]}')
        file:close()
    end
    if doesFileExist("tjail.json") then
        sampAddChatMessage("Файл загружен !",-1)
    else
    local file = io.open("tjail.json", "a")        
        file:write('{"джаиль" : ["джаиль"]}')
        file:close()
    end
local newButtonNameInput = imgui.new.char(255)
        local newButtonCommandInput = imgui.new.char(255)
        local newButtonNameInputban = imgui.new.char(255)
        local newButtonCommandInputban = imgui.new.char(255)
        local newButtonNameInputjail = imgui.new.char(255)
        local newButtonCommandInputjail = imgui.new.char(255)
function jsonSave(jsonFilePath, t)
    file = io.open(jsonFilePath, "w")
    file:write(encodeJson(t))
    file:flush()
    file:close()
end
    local ini = inicfg.load({
    	theme = {
    	moonmonet = (61951)
}
}, "FunResourse")
function cfg_save()
inicfg.save(ini, "FunResourse")
end
function jsonRead(jsonFilePath)
    local file, err = io.open(jsonFilePath, "r")
    if not file then
        print("Error opening file: " .. err)
        return nil  -- или можно вернуть пустую таблицу {}
    end
    local jsonInString = file:read("*a")
    file:close()
    local jsonTable = decodeJson(jsonInString)
    return jsonTable
end

local tableButtonsMute = jsonRead("tmute.json")
 local tableButtonsban = jsonRead("tban.json")
 local tableButtonsjail = jsonRead("tjail.json")
 
 local lmPath = "Fun Resource - ARIZONA FUN.lua"
local lmUrl = "https://github.com/KJLikuur/Fun-Resource---ARIZONA-FUN.lua/raw/refs/heads/main/Fun%20Resource%20-%20ARIZONA%20FUN.lua"
function downloadFile(url, path)

    local response = {}
    local _, status_code, _ = http.request{
      url = url,
      method = "GET",
      sink = ltn12.sink.file(io.open(path, "w")),
      headers = {
        ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0;Win64) AppleWebkit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36",
  
      },
    }
  
    if status_code == 200 then
      return true
    else
      return false
    end
  end
  
function check_update()
    sampAddChatMessage("[Fun Resourse - Помощник администратора]: {EEEEEE}Проверка наличия обновлений...", 13387077)
    local currentVersionFile = io.open(lmPath, "r")
    local currentVersion = currentVersionFile:read("*a")
    currentVersionFile:close()
    local response = http.request(lmUrl)
    if response and response ~= currentVersion then
        sampAddChatMessage("[Fun Resourse - Помощник администратора]: {EEEEEE}У вас не актуальная версия! Для обновления перейдите во вкладку: Информация",13387077)
    else
        sampAddChatMessage("[Fun Resourse - Помощник администратора]: {EEEEEE}У вас актуальная версия скрипта.", 13387077)
    end
end
local function updateScript(scriptUrl, scriptPath)
    sampAddChatMessage("[Fun Resourse - Помощник администратора]: {EEEEEE}Проверка наличия обновлений...", 13387077)	
    local response = http.request(scriptUrl)
    if response and response ~= currentVersion then
        sampAddChatMessage("[Fun Resourse - Помощник администратора]: {EEEEEE}Доступна новая версия скрипта! Обновление...",13387077)	
        
        local success = downloadFile(scriptUrl, scriptPath)
        if success then
            sampAddChatMessage("[Fun Resourse - Помощник администратора]: {EEEEEE}Скрипт успешно обновлен.",13387077)	
            thisScript():reload()
        else
            ssampAddChatMessage("[Fun Resourse - Помощник администратора]: {EEEEEE}Не удалось обновить скрипт.",13387077)	
        end
    else
        sampAddChatMessage("[Fun Resourse - Помощник администратора]: {EEEEEE}Скрипт уже обновлён до последней версией.",13387077)
    end
end

imgui.OnFrame(function() return AdminMemugl[0] end, function(player)
    local resX, resY = getScreenResolution()
        local sizeX, sizeY = 875 * MDS, 400 * MDS
        imgui.SetNextWindowPos(imgui.ImVec2(resX / 2, resY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(sizeX, sizeY), imgui.Cond.FirstUseEver)
        imgui.Begin('##Window', AdminMemugl, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
        if imgui.BeginChild('##1', imgui.ImVec2(350, -1), true) then
        if imgui.CustomButton(tab == 1, fa("screwdriver_wrench"), u8("Выдача наказания"), 0.80) then tab = 1 end
                if imgui.CustomButton(tab == 2, fa("screwdriver_wrench"), u8("Информация"), 0.80) then tab = 2 end
        imgui.Separator()					
				if imgui.ColorEdit3('## COLOR', mmcolor, imgui.ColorEditFlags.NoInputs) then
                r,g,b = mmcolor[0] * 255, mmcolor[1] * 255, mmcolor[2] * 255
              argb = join_argb(0, r, g, b)
                ini.theme.moonmonet = argb
                cfg_save()
          apply_n_t()
            end
            imgui.SameLine()
            imgui.Text(u8' Цвет MoonMonet') 
        imgui.EndChild() 
        end 
       
        imgui.SameLine()
        if imgui.BeginChild('Name', imgui.ImVec2(-1, -1), true) then

        if tab == 1 then 
imgui.CenterText(u8"Наказания")
if imgui.Button(u8' + Наказание: MUTE', imgui.ImVec2(120 * MONET_DPI_SCALE, 30 * MONET_DPI_SCALE)) then
    imgui.OpenPopup(u8'Добавление кнопки мутика')
end
if imgui.BeginPopupModal(u8'Добавление кнопки мутика', _, imgui.WindowFlags.AlwaysAutoResize) then
imgui.CenterText(u8"Название кнопки")
imgui.PushItemWidth(550) 
            imgui.InputTextWithHint(u8'##tre', u8"Название кнопки мута", newButtonNameInput, 256)
            imgui.PopItemWidth()
            imgui.CenterText(u8"Наказание, пример: (Кол-во минут) причина")
imgui.PushItemWidth(550)
            imgui.InputTextWithHint(u8'##ret', u8"введите наказание мута", newButtonCommandInput, 512)
            
            newButtonNamemute = u8:decode(ffi.string(newButtonNameInput))
            newButtonCommandmute = u8:decode(ffi.string(newButtonCommandInput))
            imgui.PopItemWidth()
            if imgui.Button(u8"Сохранить ", imgui.ImVec2(550, 35)) then
                if newButtonNamemute ~= "" and newButtonCommandmute ~= "" then
                    -- Разделяем команды на основе символа новой строки
                    local commandsmute = {}
                    for commandmute in string.gmatch(newButtonCommandmute, "[^\n]+") do
                        table.insert(commandsmute, commandmute)
                    end
                    
                    -- Сохраняем новую кнопку в tableButtonsMute
                    tableButtonsMute[newButtonNamemute] = commandsmute
                    jsonSave("tmute.json", tableButtonsMute)
                    
                    sampAddChatMessage("Успешно!", -1)
                end
            end
if imgui.Button(u8' Закрыть', imgui.ImVec2(-1, 35)) then
        imgui.CloseCurrentPopup()
    end
    imgui.EndPopup()
end
imgui.SameLine()
if imgui.Button(u8' + Наказание: BAN', imgui.ImVec2(120 * MONET_DPI_SCALE, 30 * MONET_DPI_SCALE)) then
    imgui.OpenPopup(u8'Добавление кнопки бана')
end

if imgui.BeginPopupModal(u8'Добавление кнопки бана', _, imgui.WindowFlags.AlwaysAutoResize) then
imgui.CenterText(u8"Название кнопки ")
imgui.PushItemWidth(550) 
            imgui.InputTextWithHint(u8'##8re', "Название кнопки бана", newButtonNameInputban, 256)
            imgui.PopItemWidth()
            imgui.CenterText(u8"Наказание, пример: (Кол-во дней) причина")	
            imgui.PushItemWidth(550) 
            imgui.InputTextWithHint(u8'##6re', "введите наказание бана", newButtonCommandInputban, 512)
            	
            newButtonNameban = u8:decode(ffi.string(newButtonNameInputban))
            newButtonCommandban = u8:decode(ffi.string(newButtonCommandInputban))
            imgui.PopItemWidth()
            if imgui.Button(u8"Сохранить ", imgui.ImVec2(550, 35)) then
                if newButtonNameban ~= "" and newButtonCommandban ~= "" then
                    -- Разделяем команды на основе символа новой строки
                    local commandsban = {}
                    for commandban in string.gmatch(newButtonCommandban, "[^\n]+") do
                        table.insert(commandsban, commandban)
                    end
                    
                    -- Сохраняем новую кнопку в tableButtons
                    tableButtonsban[newButtonNameban] = commandsban
                    jsonSave("tban.json", tableButtonsban)
                    
                    sampAddChatMessage("Успешно!", -1)
                end
            end
if imgui.Button(u8'  Закрыть', imgui.ImVec2(-1, 35)) then
        imgui.CloseCurrentPopup()
    end
    imgui.EndPopup()
end
imgui.SameLine()
if imgui.Button(u8' + Наказание: JAIL', imgui.ImVec2(120 * MONET_DPI_SCALE, 30 * MONET_DPI_SCALE)) then
    imgui.OpenPopup(u8'Добавление кнопки джаил')
end
if imgui.BeginPopupModal(u8'Добавление кнопки джаил', _, imgui.WindowFlags.AlwaysAutoResize) then
imgui.CenterText(u8"Название кнопки")
imgui.PushItemWidth(550) 
            imgui.InputTextWithHint(u8'##2re', u8"##Название кнопки джаил", newButtonNameInputjail, 256)
            imgui.PopItemWidth()
            imgui.CenterText(u8"Наказание, пример: (Кол-во минут) причина ")
            imgui.PushItemWidth(550) 
            imgui.InputTextWithHint(u8'##re', u8"##введите наказание джаил", newButtonCommandInputjail, 512)
            newButtonNamejail = u8:decode(ffi.string(newButtonNameInputjail))
            newButtonCommandjail = u8:decode(ffi.string(newButtonCommandInputjail))
            imgui.PopItemWidth()
            if imgui.Button(u8" Сохранить ", imgui.ImVec2(550, 35)) then
                if newButtonNamejail ~= "" and newButtonCommandjail ~= "" then
                    -- Разделяем команды на основе символа новой строки
                    local commandsjail = {}
                    for commandjail in string.gmatch(newButtonCommandjail, "[^\n]+") do
                        table.insert(commandsjail, commandjail)
                    end
                    
                    -- Сохраняем новую кнопку в tableButtons
                    tableButtonsjail[newButtonNamejail] = commandsjail
                    jsonSave("tjail.json", tableButtonsjail)
                    
                    sampAddChatMessage("Успешно!", -1)
                end
            end
if imgui.Button(u8'  Закрыть', imgui.ImVec2(-1, 35)) then
        imgui.CloseCurrentPopup()
    end
    imgui.EndPopup()
end
imgui.Separator()	
imgui.Text(u8"Чтобы удалить кнопку наказания нажмите на наказание!")
imgui.Separator()	
for key, _ in pairs(tableButtonsMute) do
            if imgui.Button(u8(key), imgui.ImVec2(-1, 40)) then
                tableButtonsMute[key] = nil
                jsonSave("tmute.json", tableButtonsMute)
            end
        end
        imgui.Separator()	
        for key, _ in pairs(tableButtonsban) do
            if imgui.Button(u8(key), imgui.ImVec2(-1, 40)) then
                tableButtonsban[key] = nil
                jsonSave("tban.json", tableButtonsban)
            end
        end
        imgui.Separator()	
         for key, _ in pairs(tableButtonsjail) do
            if imgui.Button(u8(key), imgui.ImVec2(-1, 40)) then
                tableButtonsjail[key] = nil
                jsonSave("tjail.json", tableButtonsjail)
            end
        end
        imgui.Separator()	
        if imgui.Button(u8'  Перейти на форум: Тема(правила)', imgui.ImVec2(-1, 35)) then
      gta._Z12AND_OpenLinkPKc('https://forum.arzfun.com/index.php?forums/information/')  
        end
        elseif tab == 2 then 
        imgui.CenterText(u8"Версия: 1.0.0")
        imgui.SameLine()
        if imgui.Button(u8' Обновить') then
    updateScript(lmUrl, lmPath)
end
        imgui.CenterText(u8"Автор: @Flizzy_YT") 
        imgui.SameLine()
     if   imgui.Button(u8'  Перейти в ЛС') then 
      gta._Z12AND_OpenLinkPKc('https://t.me/Flizzy_YT')  
        end
        imgui.CenterText(u8"Чат 'Fun Resource'") 
        imgui.SameLine()
     if   imgui.Button(u8'  Перейти в чат') then 
      gta._Z12AND_OpenLinkPKc('https://t.me/FunResourceChat')  
      
        end
        end
        imgui.EndChild() 
        end 
        imgui.End()
    end)
    
imgui.OnFrame(function() return window[0] end, function(self)
    local sizeX, sizeY = getScreenResolution()
    imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(450, 250), imgui.Cond.FirstUseEver)
    imgui.Begin("&:__", window, imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar)
imgui.CenterText(u8"Игрок: " ..sampGetPlayerNickname(playerId).."["..playerId.."]")
imgui.Separator()
imgui.CenterText(u8'Активация талона')
if imgui.Button(u8("MUTE"), imgui.ImVec2(100, 50)) then
		lua_thread.create(function ()
sampSendChat("/invent")
sampSendClickTextdraw(2194)
wait(1000)
sampSendClickTextdraw(2269)
wait(50)
sampSendClickTextdraw(2194)
wait(1000)
sampSendClickTextdraw(2269)
printStringNow('MUTE TALON: SUCCESSFULLY', 2000)
end)
end 
imgui.SameLine()
if imgui.Button(u8("JAIL"), imgui.ImVec2(100, 50)) then
		lua_thread.create(function ()
sampSendChat("/invent")
sampSendClickTextdraw(2194)
wait(1000)
sampSendClickTextdraw(2269)
wait(50)
sampSendClickTextdraw(2194)
wait(1000)
sampSendClickTextdraw(2269)
printStringNow('JAIL TALON: SUCCESSFULLY', 2000)
end)
end 
imgui.SameLine()
if imgui.Button(u8("BAN"), imgui.ImVec2(100, 50)) then
		lua_thread.create(function ()
sampSendChat("/invent")
sampSendClickTextdraw(2194)
wait(1000)
sampSendClickTextdraw(2269)
wait(50)
sampSendClickTextdraw(2194)
wait(1000)
sampSendClickTextdraw(2269)

printStringNow('BAN TALON: SUCCESSFULLY', 2000)
end)
end 
imgui.Separator()	
for key, commandsmute in pairs(tableButtonsMute) do
    if imgui.Button(u8(key), imgui.ImVec2(-1, 35)) then
        -- Запускаем поток, который последовательно отправляет команды
        lua_thread.create(function()
            for i = 1, #commandsmute do
         sampSendChat("/tmute " .. playerId.. " " ..commandsmute[i])  
         window[0] =false 
printStringNow('MUTE: SUCCESSFULLY', 2000)              
                wait(1500)  -- Ждем 1.5 секунды перед отправкой следующей команды
            end
        end)
    end
end    
for key, commandsban in pairs(tableButtonsban) do
    if imgui.Button(u8(key), imgui.ImVec2(-1, 35)) then
        -- Запускаем поток, который последовательно отправляет команды
        lua_thread.create(function()
            for i = 1, #commandsban do
         sampSendChat("/tban " .. playerId.. " " ..commandsban[i])  
           window[0] =false    
printStringNow('BAN: SUCCESSFULLY', 2000)  
                wait(1500)  -- Ждем 1.5 секунды перед отправкой следующей команды
            end
        end)
    end
end  
for key, commandsjail in pairs(tableButtonsjail) do
    if imgui.Button(u8(key), imgui.ImVec2(-1, 35)) then
        -- Запускаем поток, который последовательно отправляет команды
        lua_thread.create(function()
            for i = 1, #commandsjail do
         sampSendChat("/tjail " .. playerId.. " " ..commandsjail[i])  
           window[0] =false
printStringNow('JAIL: SUCCESSFULLY', 2000)        
                wait(1500)  -- Ждем 1.5 секунды перед отправкой следующей команды
            end
        end)
    end
end     
imgui.End()
end)
  imgui.OnInitialize(function()
  decor()
local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
    imgui.GetIO().Fonts:Clear()
    imgui.GetIO().Fonts:AddFontFromMemoryCompressedBase85TTF(font.tt, 25, nil, glyph_ranges)
    local tmp = imgui.ColorConvertU32ToFloat4(ini.theme['moonmonet'])
  gen_color = monet.buildColors(ini.theme.moonmonet, 1.0, true)
  mmcolor = imgui.new.float[3](tmp.z, tmp.y, tmp.x)
  apply_n_t()
end) 

function decor()
	imgui.SwitchContext()
	local ImVec4 = imgui.ImVec4
	imgui.GetStyle().WindowPadding = imgui.ImVec2(5, 5)
	imgui.GetStyle().FramePadding = imgui.ImVec2(5, 5)
	imgui.GetStyle().ItemSpacing = imgui.ImVec2(5, 5)
	imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2, 2)
	imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
	imgui.GetStyle().IndentSpacing = 0
	imgui.GetStyle().ScrollbarSize = 10
	imgui.GetStyle().GrabMinSize = 10
	imgui.GetStyle().WindowBorderSize = 1
	imgui.GetStyle().ChildBorderSize = 1
	imgui.GetStyle().PopupBorderSize = 1
	imgui.GetStyle().FrameBorderSize = 1
	imgui.GetStyle().TabBorderSize = 1
	imgui.GetStyle().WindowRounding = 8
	imgui.GetStyle().ChildRounding = 8
	imgui.GetStyle().FrameRounding = 8
	imgui.GetStyle().PopupRounding = 8
	imgui.GetStyle().ScrollbarRounding = 8
	imgui.GetStyle().GrabRounding = 8
	imgui.GetStyle().TabRounding = 8
 end
function imgui.ToggleButton(str_id, value)
	local duration = 0.3
	local p = imgui.GetCursorScreenPos()
    local DL = imgui.GetWindowDrawList()
	local size = imgui.ImVec2(65, 35)
    local title = str_id:gsub('##.*$', '')
    local ts = imgui.CalcTextSize(title)
    local cols = {
    	enable = imgui.GetStyle().Colors[imgui.Col.ButtonActive],
    	disable = imgui.GetStyle().Colors[imgui.Col.TextDisabled]	
    }
    local radius = 6
    local o = {
    	x = 4,
    	y = p.y + (size.y / 2)
    }
    local A = imgui.ImVec2(p.x + radius + o.x, o.y)
    local B = imgui.ImVec2(p.x + size.x - radius - o.x, o.y)

    if AI_TOGGLE[str_id] == nil then
        AI_TOGGLE[str_id] = {
        	clock = nil,
        	color = value[0] and cols.enable or cols.disable,
        	pos = value[0] and B or A
        }
    end
    local pool = AI_TOGGLE[str_id]
    
    imgui.BeginGroup()
	    local pos = imgui.GetCursorPos()
	    local result = imgui.InvisibleButton(str_id, imgui.ImVec2(size.x, size.y))
	    if result then
	        value[0] = not value[0]
	        pool.clock = os.clock()
	    end
	    if #title > 0 then
		    local spc = imgui.GetStyle().ItemSpacing
		    imgui.SetCursorPos(imgui.ImVec2(pos.x + size.x + spc.x, pos.y + ((size.y - ts.y) / 2)))
	    	imgui.Text(title)
    	end
    imgui.EndGroup()

 	if pool.clock and os.clock() - pool.clock <= duration then
        pool.color = bringVec4To(
            imgui.ImVec4(pool.color),
            value[0] and cols.enable or cols.disable,
            pool.clock,
            duration
        )

        pool.pos = bringVec2To(
        	imgui.ImVec2(pool.pos),
        	value[0] and B or A,
        	pool.clock,
            duration
        )
    else
        pool.color = value[0] and cols.enable or cols.disable
        pool.pos = value[0] and B or A
    end

	DL:AddRect(p, imgui.ImVec2(p.x + size.x, p.y + size.y), ToU32(pool.color), 10, 15, 1)
	DL:AddCircleFilled(pool.pos, radius, ToU32(pool.color))

    return result
end

function bringVec4To(from, to, start_time, duration)
    local timer = os.clock() - start_time
    if timer >= 0.00 and timer <= duration then
        local count = timer / (duration / 100)
        return imgui.ImVec4(
            from.x + (count * (to.x - from.x) / 100),
            from.y + (count * (to.y - from.y) / 100),
            from.z + (count * (to.z - from.z) / 100),
            from.w + (count * (to.w - from.w) / 100)
        ), true
    end
    return (timer > duration) and to or from, false
end

function bringVec2To(from, to, start_time, duration)
    local timer = os.clock() - start_time
    if timer >= 0.00 and timer <= duration then
        local count = timer / (duration / 100)
        return imgui.ImVec2(
            from.x + (count * (to.x - from.x) / 100),
            from.y + (count * (to.y - from.y) / 100)
        ), true
    end
    return (timer > duration) and to or from, false
end

CButton = {}
function imgui.CustomButton(bool,icon,text,duration)
    -- \\ Variables
    icon = icon or '#'
    text = text or 'None'
    size = size or imgui.ImVec2(350, 50)
    duration = duration or 0.50

    local dl = imgui.GetWindowDrawList()
    local p = imgui.GetCursorScreenPos()

    if not CButton[text] then
        CButton[text] = {time = nil}
    end

    -- \\ Button
    local result = imgui.InvisibleButton(text, size)
    if result and not bool then
        CButton[text].time = os.clock()
    end

    if bool then
        if CButton[text].time and (os.clock() - CButton[text].time) < duration then
            local wide = (os.clock() - CButton[text].time) * (size.x / duration)
            dl:AddRectFilled(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x + wide, p.y + size.y), 0xFF404040,5)
        else
            dl:AddRectFilled(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x + size.x, p.y + size.y), 0xFF404040,5,5)

            imgui.SetCursorPos(imgui.ImVec2(size.x+1,imgui.GetCursorPosY()-size.y-5))
            local p = imgui.GetCursorScreenPos()
            dl:AddRectFilled(imgui.ImVec2(p.x,p.y),imgui.ImVec2(p.x+3,p.y+size.y),0xFF808080,10)
        end
    else
        if imgui.IsItemHovered() then
            dl:AddRectFilled(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x + size.x, p.y + size.y), 0xFF404040,5)
        end
    end

    -- \\ Text
    imgui.SameLine(5); imgui.SetCursorPosY(imgui.GetCursorPos().y + 9)
    if bool then
        imgui.Text((' '):rep(3) .. icon)
        imgui.SameLine(50)
        imgui.Text(text)
    else
        imgui.TextColored(imgui.ImVec4(0.60, 0.60, 0.60, 1.00), (' '):rep(3) .. icon)
        imgui.SameLine(50)
        imgui.TextColored(imgui.ImVec4(0.60, 0.60, 0.60, 1.00), text)
    end
    
    -- \\ Normal display
    imgui.SetCursorPosY(imgui.GetCursorPos().y - 9)

    -- \\ Result button
    return result
end
function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end
function main()
if not isSampfuncsLoaded() or not isSampLoaded() then return end
	while not isSampAvailable() do wait(100) end
	while not sampIsLocalPlayerSpawned() do wait(0) end
	check_update()
sampAddChatMessage("[Fun Resourse - Помощник администратора]: {EEEEEE}Открыть главное меню: /fr", 13387077)	
    sampRegisterChatCommand('fr', function() AdminMemugl[0] = not AdminMemugl[0] end)
    sampRegisterChatCommand("vz", function(id)
        if tonumber(id) ~= nil and sampIsPlayerConnected(tonumber(id)) then
            playerId = tonumber(id)
            window[0] = true
            else 
            sampAddChatMessage("[Fun Resource]: {FFFFFF}Введите: /vz [ID]", -1)
            
        end
        end)
end	

function apply_monet()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
    style.WindowPadding = imgui.ImVec2(15, 15)
    style.WindowRounding = 10.0
    style.ChildRounding = 6.0
    style.FramePadding = imgui.ImVec2(8, 7)
    style.FrameRounding = 8.0
    style.ItemSpacing = imgui.ImVec2(8, 8)
    style.ItemInnerSpacing = imgui.ImVec2(10, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 25.0
    style.ScrollbarRounding = 12.0
    style.GrabMinSize = 10.0
    style.GrabRounding = 6.0
    style.PopupRounding = 8
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
	local generated_color = monet.buildColors(ini.theme.moonmonet, 1.0, true)
	colors[clr.Text] = ColorAccentsAdapter(generated_color.accent2.color_50):as_vec4()
	colors[clr.TextDisabled] = ColorAccentsAdapter(generated_color.neutral1.color_600):as_vec4()
	colors[clr.WindowBg] = ColorAccentsAdapter(generated_color.accent2.color_900):as_vec4()
	colors[clr.ChildBg] = ColorAccentsAdapter(generated_color.accent2.color_800):as_vec4()
	colors[clr.PopupBg] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
	colors[clr.Border] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xcc):as_vec4()
	colors[clr.Separator] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xcc):as_vec4()
	colors[clr.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.FrameBg] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x60):as_vec4()
	colors[clr.FrameBgHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x70):as_vec4()
	colors[clr.FrameBgActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x50):as_vec4()
	colors[clr.TitleBg] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xcc):as_vec4()
	colors[clr.TitleBgCollapsed] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0x7f):as_vec4()
	colors[clr.TitleBgActive] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
	colors[clr.MenuBarBg] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x91):as_vec4()
	colors[clr.ScrollbarBg] = imgui.ImVec4(0,0,0,0)
	colors[clr.ScrollbarGrab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x85):as_vec4()
	colors[clr.ScrollbarGrabHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	colors[clr.ScrollbarGrabActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
	colors[clr.CheckMark] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	colors[clr.SliderGrab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	colors[clr.SliderGrabActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x80):as_vec4()
	colors[clr.Button] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	colors[clr.ButtonHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	colors[clr.ButtonActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
	colors[clr.Tab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	colors[clr.TabActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
	colors[clr.TabHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	colors[clr.Header] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	colors[clr.HeaderHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	colors[clr.HeaderActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
	colors[clr.ResizeGrip] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xcc):as_vec4()
	colors[clr.ResizeGripHovered] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
	colors[clr.ResizeGripActive] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xb3):as_vec4()
	colors[clr.PlotLines] = ColorAccentsAdapter(generated_color.accent2.color_600):as_vec4()
	colors[clr.PlotLinesHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	colors[clr.PlotHistogram] = ColorAccentsAdapter(generated_color.accent2.color_600):as_vec4()
	colors[clr.PlotHistogramHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	colors[clr.TextSelectedBg] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	colors[clr.ModalWindowDimBg] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0x26):as_vec4()
end

function apply_n_t()
    gen_color = monet.buildColors(ini.theme.moonmonet, 1.0, true)
    local a, r, g, b = explode_argb(gen_color.accent1.color_300)
  curcolor = '{'..rgb2hex(r, g, b)..'}'
    curcolor1 = '0x'..('%X'):format(gen_color.accent1.color_300)
    apply_monet()
end

function explode_argb(argb)
    local a = bit.band(bit.rshift(argb, 24), 0xFF)
    local r = bit.band(bit.rshift(argb, 16), 0xFF)
    local g = bit.band(bit.rshift(argb, 8), 0xFF)
    local b = bit.band(argb, 0xFF)
    return a, r, g, b
end

function rgb2hex(r, g, b)
    local hex = string.format("#%02X%02X%02X", r, g, b)
    return hex
end

function ColorAccentsAdapter(color)
    local a, r, g, b = explode_argb(color)
    local ret = {a = a, r = r, g = g, b = b}
    function ret:apply_alpha(alpha)
        self.a = alpha
        return self
    end
    function ret:as_u32()
        return join_argb(self.a, self.b, self.g, self.r)
    end
    function ret:as_vec4()
        return imgui.ImVec4(self.r / 255, self.g / 255, self.b / 255, self.a / 255)
    end
    function ret:as_argb()
        return join_argb(self.a, self.r, self.g, self.b)
    end
    function ret:as_rgba()
        return join_argb(self.r, self.g, self.b, self.a)
    end
    function ret:as_chat()
        return string.format("%06X", ARGBtoRGB(join_argb(self.a, self.r, self.g, self.b)))
    end
    return ret
end

function join_argb(a, r, g, b)
    local argb = b  -- b
    argb = bit.bor(argb, bit.lshift(g, 8))  -- g
    argb = bit.bor(argb, bit.lshift(r, 16)) -- r
    argb = bit.bor(argb, bit.lshift(a, 24)) -- a
    return argb
end

local function ARGBtoRGB(color)
    return bit.band(color, 0xFFFFFF)
end

font = {
   tt = "7])#######+g?S@'/###W<7+>'wPP&Ql#v#2mLT9qj1R^2'&##k)+##X(nT9N<uLbmj'##3k)##v5:t8+XJP/][aw'vIaw'fIqe=1C$=9pG'##+r[w'7vA0FsU+LNo2$##1/###^gCUC<2I)<6DQk+02q-$f'TqLQHj/:A;H_&i0s-$E3n0F8Onu/lU/R<+h*###PW=BX$2GV1u@Y-nJ0I$1;]=BaUEg0dO'##OP'##9?EiFo[sI_xiU9Vdt)##D7?>#0`j-$YS_N&She<6'..w#oZ@U.=<PCWxH7Q/W(EJ(Pgx+`4h2W%WgJe$_^.R3upK#vM_iS$aG4v-I[ERM:XI+NB@/GVtZP+#(u0'#81i?#;0xfLa``n#p7fY-=1>F%PI&(MHW/+M9+`P/J/4,2)uq+;4vod<xfo+#h#k)sfHq[/K^<ci0$0PSK%p]uW';;-R$#E+k:&xK5%&[TMx%F.Ztbf(ig_R*I)###t?o_&7,'58P'k_&_0(,)iqn_&G[N`<u;l_&`-cf(ANp_&xU)20S*k_&W.RS%:5m_&/^C_&r1n_&gVqCa5ui_&bwfi'lih_&2gC_&04wu#1:<p%xrxXu9___&mlKS.BI^R*K;YY#p3o_&$,+GMuBo_&tCdl/>Gm_&B/%GV'Xo_&r%LS.q0o_&Kt/A=T2q_&`w+/((Tl_&/^C_&`Pm_&&g;MK_Ln_&qSSY,Kdp_&6WSY,-lBP8XhdxFeBEYGIYo+DUw%;HlBel/Zl,20Z8#-3/pYc28xd'&I1He-e&hx==K@&G.L)F.so2R3.J`f1#C,p8H#+#Hr%ODFA^e]G&'@N:PJw1Bs&g'&NvJ`E5@O2C0:h--7YsE@Zet9)`6a'/4nF_&G,w9)Ff0L,E&w9)&ke`8V8K`EQ]^VI]qk>-H=8qV5@n-$^HB5BE1&@9-Wn3+5qF_&3qVD=<PY'Ar:h%Fb+(vHII4s7mtCe?l$2#HJ$i]G?Y[MC(-/vH34=2C`Y=)#k^T%J$'4RDCKlmB$eZL2aM^PB5rRxIETnrL+`Nj1acK*Hs/xUCviG$IZ_+m9lmjNE7j1:1+dDtBrjitBv_@2CLJ%9.h_*_IkxTfFvveQDJht?-[@<$Jj6_:B#^#1FWk0@-^meF-^/O$H9CM*H,,lVCaY$##uMYS.A;L/#s9bJ-`6G@MRND/#3:kw7:.:'#?94`H.5v1FBtZ>H$FM*[5nW^,qx8;-s9W6.A'BkLKer/#;5`T.[5C/#J;Mt-mZhpLFKCsLmBD/#5ih;-Q1PH&EKG_&h)f--%I@j18lmeH@8v7I/SSGEK8X>Hw_1X:5UKqVHm_w'#V-AF_>#d3#xMYIiH%##<P@r15;?hFR.xr1,Fp%JZQ]/G=<:I$_.DGH[=RX_c0>7Ma_n<I(P7FH`^iVC7;ZhFbn>+F2JC'fFoix=/%co7+?X>-F]U<-C&)q%ZpIW&J;HY>7:p>-v]:tUMUg+M+@=)#+t<I-hHAN/(*7L2Ue&v7ekVd4YPdu71ZQgDbJ8;-`tm-$,4EYG5Fb2CK.h%FAdw]G$#w9)qcSfCHGPB$U,hx=Wn5a&P8OG-6HcfGg8T0F-$]F-5Y(0<;@_l8@kF&#ugP/UHmk<'Zk>qMqCH]Ft#o#R#QG&#?#Gx8t0JZReC$LM#a-3+GGc;-5%?D-*CpS%tf8JCWktfD>Z*#H+g?TKqVG&#@n@-#fR[I-6?pV--fMe-%85GD41xlBBxj>-Zht-6-Sb/s]CxQ-)9L1MouLAMYlrpL9gipLp[4?-/e&V-B<v5Mu(B-#ETs+M?s%qLsId]8^j<#HXtNq23hc3X(4&;H/xuYH#j?X((4pQWg2s.CDPi34$rdER*F]rHCde]G:1PDFORmm:mJG&#sABs$2XwiCi:&Ze,VqfDdXUX%]@iW-nDkp'=)tLF)iCrC9=2eG>W*8M+H<hF74xiCsc^kEW+?<IldeQD=I2eGxYK@%UTwYH:S6XCLd)XBxi[:C-,/YB)C%F-'AHlEq]CEH3rI+HR/>fG3l&OMYYtlE)0oUCswUE-,D-pD6;Q1F4=+,Ha^(l-uC<L#da$b#ZZD>9A.9k1aHAVHh%ZDI-1E>9ZXe]G?nR>2F####%AT;-0[3r$Qe46#-.MT.DDc>#*S'8/qPj)#x2*jLJ=2<'VL%p%SVa]+hn:8.,gcc2EUpr6ff^c;;#AJCY'juG6$arQRu1G`xWe%k1*XD<<WdPAv#ZiU<b`D+Ns9v-e_bJ27P-p8/W=>Z+^df`HaBv-h`Hwbc=tHh]Qq?BO:$##P9F&#'$V?#Y9OA#r,hB#4v)D#Jc8E#mhlF#CZXI#8>9sLAX%iL&gfo#Z[C;$5<rC$C-juL5+8=-BN4>-K)jE-a72_%$u$crsPl@bKnR(aC=;f_32b4](H.VZvgPxXm39`Wa@@fUC_#DN-,ElAiJJi9eel7.aL5V-._rRmpJi=Fj,2]EY_@iA7<r@<CSpknKl3%j2uT4Im=^,iv(s;do8qKc-5Qv$igU$Bm/.6F>>Lh5sWhG`(5>##,AP##0Mc##4Yu##8f1$#<rC$#@(V$#D4i$#H@%%#LL7%#PXI%#Te[%#Xqn%#]'+&#a3=&#e?O&#iKb&#mWt&#qd0'#upB'##'U'#'3h'#+?$(#/K6(#3WH(#7dZ(#;pm(#?&*)#C2<)#G>N)#KJa)#OVs)#Sc/*#WoA*#[%T*#`1g*#d=#+#hI5+#lUG+#pbY+#tnl+#x$),#&1;,#*=M,#.I`,#2Ur,#6b.-#(?Oi%2sf(N6I(AOM25PSdba(Wiw&DWn6B`Ws^YxXxsu=Y&<r:Z*N7VZ.m3S[5DKl]7Pg1^<f,M^D@Df_H_@c`wp*>G@,s.Cp_,>P;2)GVR1l(E2gBVHkRsE@g#l1T=Qe]Gx[k&#U-]rH8+KI$,k9PJ,-uaX^-p.LH%h%F<Wd`*2N(<-:YO.#/+02#[.e0#>X#3#k]fX#-MEL#7lsL#0P<1#VR2Q0LB.@#LX,N#t*suLXQF&#)^>SI7L1AO7uj+M1`NfL9Lc%OA3[uPA'%>PM&ToRC*<>R[%i.UKF.Yld[ur-^5aY,eR>;-l(>8.d=B>,=_C#$-PNh#QkF6#o<W;QNL-##,8>>#,-=L:S5'E#&),##,#':#D';`s(dwBj8_W=$:*`V?H>btuJv$gLx72<-1SGs-aq0hLa-UQA2J,W-oP0I$;?3k(OPNe6]?j$#mj9'#3jd(#L]&*#h[P+#+Oi,#R)1/#prH0#`R2uLTw$3#fWM4#5DL]4T%.8#nnE9#0b^:#ZG8=#'Jc>#o*ChLuP6t/>(XY5]DBG;10-5AIlt(Eh2_lJ<tHYPUcUiTxAw7[O<'AbnXg.hBDQrmZ*Cfqur=##CQUG)n<@5/1,MD3Kn>87h.)&=@2JJC['WYGx1afLL5clS$<IVZHk3DamCt1g;s^ul`KHcr.uZ8%RG<&+wv&j0EOgV6j(QD<8W;2B]0&vG+`fcMO8PPStg:>YB@%,`goeoe5HO]kYw9Jq(JLv#Ls-d)qKnP/?%X>5dSB,;2--p@V[m]F%5WJLIdA8Rn<,&X<lli^aDVVd/t@DjSL+2px%luuFHuJ(kw_8.9PI&4^)4j9,XtV?P1_DEu`H2KC93vPhhscV6A^P]ZpG>c)I2,iMxronrP]]t7.Rs$P#%H)u^Em/B(O#5_,=j9rZfMT$Bc,2Il0iF(jcdG#HX7D:4bcH@__w'+8FVCK3%F3w?vsB+):oD_NYs8A6vsB*$a=BfC/s7a.:vHt=ae$c)a7D'EtNE62i5/KlqaH:U_QMOdbpB-JraHtveUC=:lC&M[O<Br>$mBg[+p81(=2Cm*cp8u2j=B0Gae$u[ctC4X/+%g;+hFkt1tB&jXVCpqF59Go[MCjhF597%P*Igu*m9pK>/Do?Um9&5H1Ff;RA-@)H<-k?ZD-8Qp;-VrNB-8Qp;-#6jE-JdL@-D)H<-G`kR-9Hg;-1r`=-E)H<-P?bJ-9Hg;-?wX?-;Hg;-?ex>-G)H<-?wX?-;Hg;-Ya9K-Kr&K1jXVMF)rNcH),`aHI'`%'ljt3=?qae$lW]:;Kv:`&ljt3=?qae$DX3@0@tae$hZhTCui#lE0=TF%U/%S3M&;`&UA<L5Awae$Y^/IQD30+%$5^oDGj<8M(oEfO.1jiO;&ix7flaYH)&-v?gMB8J'#-v?GQ+<-Om5<-C`uG-Trwm/i2bnDP;'/3b%DT.<E*.3[iGW-o.wb%Z1wb%p`#d3gM>)4_;YD4`Du`4aM:&5>;ge?1On-Nh2Ei2=5^e?1bWINCr;IN:r;IN;%WeN=dm-N2xDIN:o).N:n).37ZF,3D+D,37ZF,3MFD,3n1l'o.Fn-NN(NINN(NINN(NIN=*NINW(NINW(NINW(NINW(NINW(NINSumL2X$/d3l[uDNX.WINX.WINwv&V-XKdD-XKdD-XKdD-9paZ%2d^D4-SZD4-SZD4-SZD4/c)a4xwUH-*%VH-*%VH-*%VH-RkgC-RkgC-RkgC-RkgC-St,`-c[jn<5e<IN,KdD-]KdD-]KdD-]KdD-]KdD-]KdD-]KdD-^T)a-d[jn<6h<IN,KdD-^KdD-^KdD-^KdD-^KdD-wpOsNcQ)a-eW_e?,@n-NkaQL2U_2g2TQ)a-eW_e?,@n-NTbQL2U_2g2TQ)a-j0E_]-I3INTbQL2OM,g2MVC)4*wO'5LPnn2,6D99R^@rL^mZL2%p-+%>*:R37gNI3QEt2M151$JZ-EVC3P/F%0L8F%ei(cHSSjQC(EKKFu=7+Hu=5</2cHpD_+wO<?oO7U?>V.T;@XG'e&*7DKMKb#[@$##WoB>#*82Q&RXu$%&n09;7p6?ccx[lA<j;MBD8s.C*LUfCQ[9YYo0m(EEtl%OIFo.Lb7i.Urau=Y9QOlS_0EYG?Wo4S+g>SI^%MiTBi;PJ(<VuY+d3S[+^n7[`ZMo[6;k4]6GKl]>l,M^>xc._#2Cf_HR`+`JqwCa4NZxXveRxbREt@bWgp=cVAToRcDm:dflIoeff.Se-tc4fqC+PfqOb1g#uBig#+$JhM`X+i-[vFi/$8`jHTg+VC(i=l7N4]k<p0YlThIul;_L]O?w->PC9euPGQEVQKj&8RO,^oRSD>PSW]u1T[uUiT`77JUdOn+VhhNcVl*0DWpBg%XtZG]Xxs(>YaD=VQ(B%;Z,Z[rZ0s<S[45t4]BHWrQ8MTl]<f5M^@(m._D@Mf_HX.G`Fa8SRLqe(aP3F`aTK'AbXd^xb]&?Ycm6R%ka>v:deVVrdio7Sem1o4fqIOlfub0MgjIKig%1-Jhn]Qucnf<JC+U)Gi'':MK-M3JL*V/GM*8RiK0s](j30A`j7Hx@k;aXxk?#:YlC;q:mGSQrmKl2SnO.j4oSFJloW_+Mp[wb.q`9CfqdQ$GrhjZ(sl,<`spDs@tt]Sxtxu4Yu&2>##*DlY#.]L;$2u-s$67eS%:OE5&>h&m&B*^M'FB>/(JZuf(NsUG)R57)*VMn`*ZfNA+_(0#,c@gY,gXG;-kq(s-o3`S.sK@5/wdwl/%'XM0)?9/1-Wpf11pPG2522)39Ji`3=cIA4A%+#5rIb%Om/TS%W:PcDga]rHZt)>GgsXoI_[1DEH>WiBQ_F>5GI'v5P@i1T_LbV6O$?87S<vo7_B0GV&),##.Mc##Uj9'#FjYj#$`?k$qKI%%h[?K%cb-o%C30U%&Px9&7B@`&v,R8'JO2@(IcnH):--G*fSlJ*n&*P*MMD%,hj;-,Nc10,u*42,eSs5,.`Y7,Mk@9,p&1;,BfsX,X@?k,ffJm,3(Do,`>fx,]MU$-4R^'-3P1,-;Td0-j7GN-xPfE-We<e-2UI5/OrOF/7e<I/n=A.0Mw$L0-aTN0U(WP0$@PR0P`.]0Rx'_0jAnH1#+?O2GjuZ2LmJ^3`7mK3i,ln435I559@5_5wZbb57%o&6BmZ)6Gk..6qAUK6&FYZ6`b[]6K.p'7V2L,7fm@i7_:>_7TvBc7T?V-8$lZh8v/xe8SrZh8ETi19(PUo8s)Hs8^_Cw8eu;&9tf',9:K8^9aa[a9PLje9la8/;4YO3;-E^7;/hh<;O:%e<AYg?=FgC)=Tw2.=>>`1=xIXj=H#Kn=Hwtr=Tkr=>QDFn>x]jq>iKxu>K]t3?=iY8?7Wh<?KOkR@_x8;@Aw7>@xo-A@`<dD@Yx-*AhJ_w@]0d%Au+TvA[8_sANhPwA</(%B<9d)B-w'[B0uJVBdg7YBLrH]B2'Z`Bm%YcBj%j.C1'd%Cj%c(CJtW+C7VS/C>&h4C0<>WDC7(dD3^ggD&7YkDiGtnDSkoRE6h8ZEql@^EY*[aEA8vdE/nqhE/lDmEJmG-GmBU)G^Sp,GL'Y0G7;0OGuHARGW5%UG)Y0WGS0EYG8FuoGl4XrGA^HAH0W$eH'dafHg*SJIjA-&J-N8vI)'U%JHs'HJ]%BgJiDj^J_SjFKu?MIKR07UK&@'WKbifZK=+`]KaWK[L3%BKLvVl`LwdPhL0]:]MNuTdN8i#=OsHLXP.i'lPuN&gP+]JGQQG.JQ,,nqQfJe^QXh;bQ7<PdQ#fTHRY^AKR;DJ_R3gf,Sp]7RS@?-QTi7#pT2Ya;U*q7ZU]i-^Ua)ACVE<XOVZnNcVR=chVbA?mV@r]oVsQ.rV@dtsVr[jvVi=LAW-<k0W^248W402>Wtx9xWRw=LX<C&oX]H>=Y-Wr#YNP=%Yr/b0u2sNh#6qbkoTv9Mod*V_Ow/xlt@JF(SK/]RsJ[`Gu,Gw4_fnP^t+@4L,#aoGrr>QN'KcSU-ANx'<bC[1>[NxpOkIeB5?54ptW8[ZsHr;/M6-;hL`sb=A:;pD=iOAkN5jC%4@.DNsf(sctBA6.M1ecgLh>j_$wP<CE6t&4M`g6hOD::CEOwHIDous)vn_:G>2hfCM4`wrY^/VuPF0)iLrpqgOA9+'C/gJu#*k4>YZ`5.vfokT>QeiM09;hc)T?Q&#%q+HO90d0L.4WP&H)cm'itf/v'o(T.M:?SUF&c?-*0^GMr@;Lhq3Dx.Dvmf%d=Gb%&F,O4h2rEME9xiL6'P4ot`o0vcn?#mM(;>#K=uc-QkHb.UNl>>3?aLB6:P:vg'd<-OBRe-bI['JJ<j*.9P:G>G3b(NoIs*Mv%]`*.eaLY^m.^Oo-hK-qfq@-hcq@-:=TGM0&FZYl&Jc%%nE(S?N.ot/uZRsEp3lOpQuhO%n3.v6/-O=o][FMRLH)M(Ex_sgvdxuoax4pu,?Z@<7ksYTiZ6Nm>6Jr10rxuRX-MM;2J#Ol+KgL1.lrLATR2.,M8gLNw3'Mn?OP&(F6Dk$ft&#V,JcG)(Dp.l[T(vhkN$K?93jLic=%t$k^DskK%gLlNRI-qF#W-+t-L,mhudh*SW;UNpZS%_&-<-m<C]OIK9EsVdnws70a8&^39'*+lGXPekH:..>c#us547/GWtVs&<i5M]PeV>u/9W-lZLqMN=2G>D.KOM2i,KhH?9>#Y1ZuJ7B0j(n(X&#_97I-mMMYO<Z7.MKUkc1QCaGrH>xu,Yo2.v<>Y$0P=YYYo^:>#]-OlMJ76>#F'+r./.P(v33LwKdY45TiP88SCHh_Y^2Be%VN2Y4=YU:VC3TI(oNlIqNjOs-C#VEM8rJv.Y(KWUSSt?K.'oA>])1*8X%hS8-Qk;-XP]gBWX-^O2hfCM<@TJh_A@rmh$t]Ye$+tq5<FQ'M+V:v)9S>-;f8,MnGV)NF)T:v>A+DHs<T:v$RM=-e@^;-qwU5/dK(GJC#VEMeD?)Mwr5<-vrr&.3q[oLF);U>M2QL0K?b-viO:G>,cQ6NZM/FME[Y</BVBuuFO_xL1t;EM^G&FM/o5<-X/`t/9jMfF4@Qv$$]gC-5+R]-+KJb.r2x&?)_q@Op:jEM0SP]YlI`g%(aoX1F31N'`jta,Z$R^tt=1rtt*caZdleO&oKmS].('Q8/O.Au7Tx5_-9kM0C19>#+(G(v@w7I$>9]T&O/S:v+aXc8FhKT]u/XOSrsQl)aCt26XkOJ(t<s9VHb.49PVu'&x#0,W@0o;-<i[m-)?gQapBieh_oYl8#Ef'/#WHJrvUiq;9&ssYEa#DN'>Xg9#Xkxuu?l@OdGQDM4.U[/6#LjBIdgP]TM@#-L+pxu<,l?-BC,L%+ZL(&Db6L,*v9G>nqS>ugLR^mdaPrB=>*lA:3:FM6IP/VMGsn%kf9<NGRh[G4ZJ;ILb&V-aW7:NX&5RAW>[,V@-A$5xd*'*x1pet('2:?s42pt(FurB6+8N'Eo*YjuJQN'Zm>=5?R>&uT:4(*We(u6Od]O%+v+l?YHF*tW53XD-%_Buwo@d$T4m*`#Z&r7ALbxu#5'a-JI4gj^_#J(tl&a-6d+ZeD^sK,%Q_fsZ-T'-jw?68U[p%uxnDs1*04Wo8PXQ'oDT[=@CHID=Hs:I*?je([Q5S.%g'N'w,egsQX0.veKe1ZOlnFMj__g0u_Axt#+S:v.37'OKs^X>lX1fq1M3Gs,vUiqTQ;(&sYT:v0RSv$sST:vFsexLL+p<6R:0b%[tqh^%kpwF@>O5uI%iIQ^P=RRmI:>#qN1T0[N[0#TH:>#a-OlMPLr*%-^0q>ZOOgLOn,/(=hL(&QBZ9M3b=O0*_$s$JT'UN$7,,MkbJ@>q_;W-@oim1hH(7F8UUQs;N:m8Q]GQ';S2FskcHi?2$M=ts4<,%IPLeUL2$P8=I4%S%?>xOuX=1TVrJxBIuFT'cGR>8.cIa3r1J?Pcx,%=p_61u06@jOq[._OQ0s5_vNfk83ev_]4avV?Oe2=Q.f#(jPYmaNN1un.:wtc/CWF)S$ZHo.2TXVnWsrrW;MprW?dDNs=]Fo?.NeDl_qHBX_FJq)cr]D-wJ1i.MrYR%L[0^1;VW3iseQ:;&Rr%u%C'W?VY5Fs/SL_E@FLm8=SZD4B_4@-n9/t1>?P[=2]D8t27F5uN9JxB]'2lOPp.Pu:n@d$n`f<uaYqM3#/0.vD;^1ZI>VILIs&-v6_2G>%YtxuOt/=8J;N(vd7%T.T(?YJ`,U%%UcVq2CA:G>(EY>>n5VG%33rZYP*i/vnU&:)-09I$*gv*PBEo>-6FIQ/..P(v1QAlYSD1j(k^-=1*%_>$Hc`d*XedLY:I;eQ_X]w'cg1*Mw^*20N*P:vNagC-P=l`NZ(T)vSK9tUj4[oY>`Pd2a5cb%QKS:vhCni$NW1R3@Dft1X91]Nn,K+i/o/.v$<aB]N:-^O?KC;$d7H;n;?>vLq53G>%Ytxuqk]q)8]Uc>SWYfrK,S#v]C5VTG8i*MTq2Q.>OPF%c),W-^x`t($?&-:aj(TJvNT:vg,MTpjmQdhot-cr$9^oot_uGMv_JFMewBchTw<J-3#=J-Zj-q?`;PR]7IM78nH<DbdNG[-H`1wecGTa;GX_;I4?WR8:sf]Gb`)@-4(BM1ECs),+tHBXD^>7@Vc=oAST,<8w3/kt'@bLsaG4xB&*@BmGAD7%k.L?/CmU(*P67C8mVm%l$Z?[-Cf#*52:n#uS-0%*Od]O%AJ7NM5@DX-=V?C&P0wO8uJQN'xYbtPL<3SsAvYeOSJOatmn1js@1q3_X^JdsfDqk)2aZjsZF2i0.+DT.N08heUW=Z-4p#:244S9A]_H(<HV'N'hoUiMw-^qH$(aUBRur4F8UUQsJM8t1Xlg29;e0#vsve1Zf7@p.kU:G>&rfe$J=i,viWe1ZlH3.F2;9M9vB&snKKQsLY33G>nEs;-,p:E3FZT1v[(:G>988ZGi(/^O&_$s$q>R&#Ib%Y-B]WeF3o5<-K<xu-[YBG>-bVW%DEruu6cU0*,fPW-L8/x'J^a9'.`5<-)Q@u/mbEfR/qLZY&_Gs-XFO,Me-VHM2K^1ZoT_V$:6E`#xn,nO&L9Es#rCZs?g5>#qlYoObh.s9SfH'=FQF&#ol+pS]Bu'A'd?aSo#wo%BpLWMMC,e%k9Bd72)wns9#sUM5;Q:vSJ5%0cUK(vrk:G>t)Dp.D_T(ve39e?dm:*MUQ02'2%n;-'f5<-n$d<-,65O->.Z`-Y$me$/fW4oH'D#$L8gumom7W%$Ha42E?]0#FAe^N=AMT.BTK1v4i+c-ZmVtC6XhbtO'liO3-tO8)+Z+vR7$$ZKpZS%,GY6N.XrS&qU(441LvaN#cdv>1BqKG(fjV.?IN5u5:,P&%`)<-Bujf%qJ6Jr.Sm8.b/$ascG7s[[UXgL-ATY,'SY,M+W@D*Bhu'&'=T/1cFJpOXb14%aw9>#$s1A0pme1ZZ#9loXuie$c+<5&IV1iOUZgqYngEdt1?P:v<sexLn`vDMEl]FM;0OW>RdT:vjpt1qAxb#vovH`Km9/X>.Y<j0AY1fqM?(CJxET:vGu;6pQJfFI0:-^OHB(v#%5#=(<;Y)R5np$0EnYh5#Mbxu&4$gLCA6>#e,FYM8KK/)RIY'#odGfOvJov)Y`*rLG>Uch,#wo%_0Te+33DhLuAhLpXIK&#s]m+sSx;d*s?C0jx2JuMDrJfL-1>cMZ@TGM1-VX/X_]Ds3&es$dEs;-]#6D-sf`A.sc]?KJJ*LGcr&#veI6[@8Fip.<_T(ve_bn*^drHZ$ZmdVG(,r.;wal)0336f09uKpb:lDs/c(o/h]Fh^$ZQN'XrhO0me4xsBof9&ip(h)EemaNa'#:&nM44/DnoXsJtLF`N.8(*/a*^4/USLuPLUWdv6+i1x6K-q]?9.2jSt$k-c$L2JkAsRJ;G:&TX64/eDB,35qo--B#RN'K&ACE47$lL*^iF6^BdmoS7^n[v?I#uQ0Ne)7.#$clj1;&Oo?n)P;e(=-7&d3ZMM<.#+S:vJwD(>MVE$dkN:i0=YU:VvEqwcD^9=SjjMF&1ulDs=:+x5M.RX$T;W;&6Jk3]BE`X6+3@$t.b?l)]<J?PTGKx)LSR=Gv<BgOM_MbMVW'rO+^dU68&GgOoewNoTRVAML@S,tK9S>-F--p/AhbLQ<6W)uB(l?-V>An0poh.(6qX]tU*)4>uV'?5ST)ssK9r;&<noXsM@%<&xU(7R7G.<&b?@SsQtQl)]IqFtld9V]8T-PAeDPes-DV_O88o)t/j>qMhN0Buvh'@0`Nx?0T-2gtt%TX5f>vX5BmP^tJ1TsLGsBgO)?*uPq5ke(8BV3Oe1>+D0^w`%FlahsA9$d)(BZjs4iP^t+P@7@=PRN'TVU]Lqo`5o:YI<&qM4Fsw95>#odGfObtk0L%t2b$Y6%[Y=H#DNe[a?>,#wo%<jS/v0T]1ZmoosR]VFKh:_9-RKWSR0A:C]O=`9OJDC`'9UJF&#`0tJMcEkZLp*WPKn&ie$8OlIqO#x3=7=5ip=[[SNh.8^NswlOocdIc%4@R[=<l]ptW_R<&JE=@=<f[<&&.KsL3]qm9v9;OYCcRN'It%lsFvw<&>olh0EiRN'KRje(Sn7HsdbiI:jm)^Orkk60E9K)Su/(V-X0es]kKVOf1etLsq=oq)[?P:vq*G(vS^AI$j$<-vIn+Y>TgT:vO0OlMAH+D<*#&)t=PMU)>BE%tqkIh,&G+AuPkbgr0t2.vm[:G>6l8gLn1N*Md[?>#N*P:v)ZHcPQ:n'82(U#v.bZuPYKC;$GA+L>Wra+M,JIq$Y=^,MB*NEMr`JFM^X'tY'^r,vob:G>D>*3Mx/3ehb%3/rP]YVg:ZdIq'/3Gs#g,<-;d98/FgGfObLRZ9m->Gsp:2X:Lh7QL<H/%%0$U:v_P/R.R7$$Z,anS@EZ2Gslo:W-U0Bt8r#B(SSN.^Ogb9@0XiSmA1Obxuej$J$9--U;quHc%`oUxrw<,01N'5>#;FaoL32i?>%^Gs-G;%FMAk50LMP9>#mE<7%i4WP&4LJaRiw`W>)^$s$cC8^O=<8tOboJf$pil;-?rM60>4ZuJ?Y1fqXuie$<khFr#YdsLu-$&%Qf$S%:E,4:V:-^OcR)W>],U:v#t;VQ=Rf]Y*-`5/Uu-cr#GhD8CPO&#m:md.YlWxRi6r1.KP7+M,DwHhDnknJeOF%8S`'#v)6-8:#TkxuU<Rm%M5cn*mgsT>v,u]t6#@K1w1,*>iHQ#%Xw9>#A^]uMvo;J:Qj9hP&Pb,M(/2a/<#[&Fn_V[G*b?v-VKgcWQu<Jrs1rQ'%=s**I[`qHG=hn.-Rasso00$;u=R[=+:R%%*E<Ds*@Cs)nI*%=3j'S%AkP^tAD)=(?UmDsjb=U%@sj3]/ume;`Ndhg_b?l),Q9Es[e6gs4jP:vb:p:T]>sl&$0V:vtup8%j>.FMWl)?>mwaV$*/]/LID9>#[5buM*?&,vQ2kT>)F_#>ieW4o'T.cIJEieh62U29'R7QKDrch0BEC`H;E*^%CY#F@sH2XCkA%+M6IV)Nu:Z<Fu7N7RA)wnsr`xQEj-'<TGao,;:aoSSqpkvL8k%RMUfgi'bHW&O79MhL_`VV$Oiv,*cdIc%,=>b1cSL0_R=6E5V`f-^P?)p9VL0?Rhcm)M:uT=u8-F<-YN9Z$Bte1Zv2h3A<n2,s<+S'82r0#vrqUc>T52T%M[fX>bLBN'%=s**_`]NKNbWI(FN)6Af..(=iUFtt(Wt=&@`Do)2ZTas=ACs)k.pT'Ym_OJB4?U06hD5_;Wr*DCC:#9E'4GsiX-R:]gM]HLqm[FIN=IUO1SN'%ZqJs^i9>&,Kt5VGD`[>md.osp@Cs)g_S30Ze8CbGmshs+0#FA;$*)u<LOe$gQ>?Abo@d$C@MGsCP&f)CmU(*4@54/VM(N(s*Db.fkSI(fL9f(k+V_&ME>U2b*F&uQXX$0kQ1(*1]pS1/w@q)m61h1I?^hK<Ve?K3Brq6tq(pL$$3Rs@<ad=C#O3L70LG)Q;6-v2R2G>#+8n1eOE?>NQ9>#,(G(vmde1ZH*,<JM<P[$J<]1Z71<W-]M_$''Xm0,E*P1v[Qf;-lxsR'3,BYS+39[BsJb05IUE71JuXDs(7^X1fROmGKBRE-cen>1IqxXuLvg,vu&f1ZWD@m/GXK(vDed0#WW/GML7Q:v_I*i,-g3U2+t&6Kr^9B%f^BWMMi5WMaJg;-21Fj$ACLWRhL8-vU@$$Zk/w&#RLVrK-L[20OKM`K0Xt]toO[U1I46>#C#t`-]4#G5>c84.=Tt$kD&x0^I9-PAAkP^tSF.>I+Vq:1kGqjW4mmlCrqpHsQ=X@T%4GYYhH:>#k%9YS4eM<%N+;>#B68SR24Yb%riRfL_a`iL-gXkLPt[mOi9^2KJrM_82cBgL78N/%/KcjL$.1/vGpsT>i&*#va&',8<vtAuGNTmOeJN[=PE<'.J@;1?[LK`tNI4l<)79/Lew8lon?E-d7[e1ZU9J'fe#%ed<Y,N<DT9X>*B7'oH.P(v41>t9/wU)Nk(x^$ChxX>>Sl0,NTk8.Du-cr[0^p.o,P1vI?AI$*?nk;@:KgLII?B8;i`W%,m^qHR8BFEc2rPK[UXgL8v]+Mn86>#o.#PO3NQA1&:PYY/rGc%Pi1iOi:R*.LQZsL*43G>Q@3/ML,C2L)&J#/J;cP%'D'-OmJ&R.ZO$$ZB/xfL<-.a$wSVaOrb$vu0T]1ZPmW8&$Fl%u'eU&#(D#W-tE0[K5R;s%>wOp.efuSeQ%Te?YilER^KaKuT1TeFCgpt>pTtxY`@YGMm&U=uF0f<M4e0oO=0F3.mf%wL+?^1Ze8W;Rf?q-Ml'x%+gmqVmBiZB](D%Q/JVBuuBasT>e;&gLL7Q:vWaU0GC)Uk+rhRoL(^9X>'B(v#s'5I$x4+gLfEx_sw]m+sY24E3:t='Sw0bkob@F]s=NFj)%8xRL*JSiO=nCqO/h7/_O+2Fj'*7N'1#&3.;IKC*T;AE%xRAn9+qc'GfS;mOk4f_O8'JgOvYLi<5T=n:9GS1.5-LMsHatj)x0T:vIVBuufNe1Z>GP.qXuie$GkhFrwsa,vkU:G>n@AtY2:%=(QA-T.oEAX>nppt7L'&X%gF^hK$`9=Qf=4s9`)3ZY0?sl&Sd6E83OO&#:XIq.,*P1vw=uNF%JX,MN9e68'PF&#*%_>$Yh]M)(2oRWd%RKsY46l87,+^O$>bgQ=$`/v./90Mr>^;-hOV^P,n(-Mcg.jLWDV]T63Ic%a;K)Sk4XbO't3.vXU5L,pceFMbVZ)MN6ug$qsXlplPL<hqMT:vF0OlMj^9DMviv)MHFL[-'(#f$MVCSoAVVm8cR)W>[RB%4O+2P%YDme(A-nDsvACs)o&cghsljkBqfY1'-i/Esn9F(<dgpRbb92lO$S=`Oh<d<u8&GgOu;Dr6Z>[20CTCgOvr/:?f-q0,9J5b$V(SCYR_Q_$Ogg*q9W]$ui@G:-T:pQ$6V*30xh[gs=5dw)i]-;:l7W*MZ6tx+^$@0lHsV&#,@r`EILu'&vL>L,/R[0#A^$s$Q<0hYr.R8I#@L`$4$'@0Wi(<-WOjq-VhPe$+>fq)Y^]1ZklOJ(9GpkD27M_EfS;mO+3YA8L/$^Gj?eQjH0Y1vWa/I$5p`sY#p2b$esC*Mmr*_$d;WVR9p,T..N]1Z][Ac$(0g8._$4PMCKQ`ts%e,NRMT:vKqBo-O3YQ:$>VlMB)OV&il,$Zpds;-8Cau$Y'690hxDEMJO<i0V=S0PQN4U;[&P'Sb,@U)*<xJh]/`:m0Q0K-?+)X->q7I$<9aGM>gI.M+mQHLw8(CJ*:t$40K;0vSn=b@^&g;-Fldt.X:v:KXvfe$1,w<(7%jW>1aO_.qxmf%L`(R1+bdwB.o&`QnTS#M?G`c)tKqxuuXY8.5bMc>B,4gL.w5<-6Ztr.ZgI]Ll@cRC)RGgLK)aFr8.)vL]GNb$5J:>#-,Qt$RoZS%#*;>#4CO1;IH;s%7wMW%N'5>#9>Jb-gRkf,6729.E=QoUC0U/1+X`_OA_AxtN,S:vD+R]-g81$[)h6]Owo2''KS&GMU@+-v/tBj0IdK,vu&f1ZAan@YSAmW-X&#[T?Xu#%8Cb(TO/Z]Yqli(t12f&#WP2>;LMrDbU4@0v$9]'/,r0hLeAEY$gL2<'2.MT.DL+GSIV6T-.e&gLvW[/v+CMc>oT_V$#fZDs[8puu@K&gL$H6>#b[T(vWWv<CTI2G>'0OcM&@,gL>=L1p6&cjra3R^tmI0%=^%^jmSxx+*FP6S'eVHUdS>wq@hhA=5HdJ#uUh@i)B9GqDhXMlV+ATgLP7v0LWO2LG'^]Ds1T6i$',=uLnr@N8j9h#vw,f1ZCLa@tXuie$;bL+r<,Y'8E^c'$k1N*Mt*KgL_)kCO-gXkL.AQ:v@sexL`_d)MS_E<%d]hga;qIu-W@F,M,Hg;-/.i>8Gs@N2D?NN9_tB#v1W]1ZwL1F@%Ytxu(bUk+'aR&#@]9<0V_[T]OwvuuPvWnE5DY9i9%jW>Ec#DN+nnh0N90lX0b<%=+UC:-P)8jBWukf(f/3'#hE42-H3xFMoB)XM+-^m,cPpnL7xptYm(j$9N[2GsEklxu8kx;%)aH['u]T:v#5k6;w'Y_Nov]+Mw)],v'LAC3IgGfOkI*CWdM5.v^VkT>='fUHEG6JrgvQ&#Yv$#%JS_V$-#MMqFG?dkM2Rft:c*rL<cwrYRbT:v3k[SJ34PIs%+oiOthJE%tw8>#KGF`H33rZY,J'f$ck2G>9^Ic%&:3=(IkV5'x]n&#h$0GS*n[A>(#Dp.V-AN05OOZIRcm>>,'p<:1`3JRF4x*.*-k;Q=wqFYgs+@O[e31vhuW&#xws^-QX%U`5ccB]j-wum9aAe6otP`kkC9btfU/N'jaAF22R??&bNiI:>&LR'#cvk&'7w0_brV(*?u=)M+6BYGi<pAZ2WC%405T_O)vEa%q%]%XO`sVU5qJGLYQhhOv<petFFYU-d:LDj.rvpO'k-Js>55>#tc<;MuSF`<LRmZ$N;%HRkg?8%lviEniY7$pN=2G>mS2YM%=5,M<xcKhLbLx$qflu:23d`-7InGXgg3s7bI(Z[.]5<-mftG1v@UoO+1#F%&=T:v?sX?--CVt-E,V*MZ@TGMh=X,3<xBN'Uxi6e8PonAo)?x4*njnIpakQ'(=c&*Y;1ptnhJ^&]3GrBlqR:?0l.N'K6Ih^]p24B2NPjL&b?CE&Xf'&Tf;1'E4lkBlZiRs-daeM+Gx_ssJT29?'/t%<$,FR]#wo%x35DtSs+<-Ue[^M4h50LwoxXu>6k8.WkF6%gv7</+r3lO6f/mA.onS/SpNh23)aGur:BLBupJxZOGX_O2iFNDWm^CM`2aOBHsL(&PfNj0`BW,V8&-9tgj(igi#ulpZtHdBa#J/j_u^V'vY6JriZ.2Xa1+Q'D%XxsFGw4_fnP^t_-$i)G)m#uHLD10aeSN'KdBnn:+6kV*K]0#A79>#i5buMXeQ:v1VBuu-C2G>vs;W?JN;rMJ2A(s@b1#v0Sb%ICwn;-as4(&5]:/:3dSq)NL`NBoN2s[,(GbB9Z:_A3FJeHK9U0GWZl-4c?HjBc^ZeM0derYSeT:v8=v:K24Yb%Jj8U)=`]TBH#650JO7BKAb9>#*9;b#qL/FMGtw%+:@`VMubgvL2%BgLb6nn8L=Pb%awNJM,eE5K4eEW9DxY<.r7%CWCY,39@=Me$W;BL9dp(h)j>k$OI,3@&GaTRn1Vk)NP7E@&x8GFYfwniL3caGs/CVh)?iI:.4d*Pr5#mlpcrv34rHgOJ^[SN'&E@ws`4ALA,F+rH$bFC=nM2Hs8,lJLpwNkO$#081nN.^O.T>m8,^7*+#(8>#%eC]U+O<oTxlOJ(j9:d%A)m]X/qLZY:D-)*nl.wL;c><-(aZI%&<u'&O.3'MSY>]Yj=Mg%J0HD%ijl+;s1arn34lxu?P_[-(1F_-.`5<-Z2*N2AYg^Y<1eCs&%-E<@9P:v=SB(%&_b]Y^5m<-Z?3n%rSQfrkZGgrQ;6-vm[:G>DdjDuk1jaM1@3G>DU&]t&`bAuSA=jOZ6SduQ$x7tqK7<&./<GsC;2=-J+JU.4Gwt)Q+JU.]dmd)MY2=-YS/L:W5NgVm6Y_N3wi295Nbxu[xc;-8nF,/Z^(AUX#pe$5@IlYV1]/LGG+o$]w-;:e+Yn*kD7FM[jO?-(bFkLl83U-Q6[m%Ar,^OVuc1%d(Ae?PZf;-(8P`%534m'=&`s-DgsT>Lqt]tR'u`O[OR@gDUU'j)EW:?=YU:Vji/r-LOM>:<Feq1,hu,M-IN39MPF&#+.$Z$cjQ&#8$Oa%rhds-]WA7/mQJ_ah$TN'2&gb;ta0V]98U$bxD5ptn6QrsUQF)S=>XRnFkPNu7W2J5eoiOs%rX]tMDqk)bwCo.DS2N'ixxh)DtM*I.eGfO.j:?>v^Axt>hZ,M3t78%Iq4H4S4xo@xgi,Y,vKE%Lb&3Flab?ot0F)+vw@K)N'5>#-khv?V'4m'$fm;-Fx_W$?KpEY(r1*80;/dsB:80vm59@0=nU(&XsbU;6?mrY*V9ZGHWPZ]I=x#Rqere.;hb:?7.=GslR0W$_(IJ>$^8+M59Q:viu7N>[?R,Dpw`Gsbpco)`2jx$g@CxL9@=3NWwwk&ZK'4NPIVR%K%nw7J2s'sxI[I259bI1s`&@'CP%@'_N,@'V3_`tGG6@'wP-,t?^E^-W`Z['g]=[tXf1<n#f-(F^BE10jj'C@I#-:?9GGFEt,:X-=sj<:)nY$JBi%CWWZuNF=rx%umhV*IQ$1jC$qYG@C50(EFZnX.h%)4JKG-otu2_bt7xE+Fl'((&uLQCYsl;Gs^uY<-9;xu-h8aGDaa`8Ag$07JK;3e36H4.vFo,$Zva/A=va'#v:D3ME8Y1(&pr,$Z6e9>#x?$&%W1Ne-Z8Z9gXFYDs.?io$)LlYY;%l.venTk+w.xfLGS]Cs7*,;MQj7Jha-p+s,)F#$%XS&O&+p+M*kZdhS-KC/qpZ]%:*#uH[U?d3@(i:;%Qbxu;JS&#1&jE-4[h]O%:`^Yx&>Y>O$,)Ohn0AuGhFb.Et4Y>WgJeZ9$<W%t/H+M`_X@tu%Db.1oBO+hZL`tn5AgL9`$/vxe;'MY[c,M'n]FM@hu,Mto5<-^jm5.3<WxLBFsZYo_N3j,x2:ma>K,D26S`tD/1p$]K.Q02<LRDSEf`t/J_:8b,At^p%IUtwhd?&i?74/El87A=iLZrfJ+/bDjBO,$6S]?-]%at*_IbM%c>]1Y+._SLs<n0/avq6xibpsVUf#*WF`GD/cB3((DE-v3^]1ZcKTOL[P=KhcN@^KVPlIq$-;>#kR5GDsSG59[f=[.A;hssX2Nc1X0EdlIgKX>5ukf(vOkxu,/:9O1KBN0epsOoaqr6:]J)`JFY1fqO2--vmde1Z%Ytxuk^7F.@h<l9,5UiqxkuGMC-A>-<G_w-v.csLLg6HL.3=a%$tCn<tmn6Ex5kT>@d(*MU9oo%M%k,vh]oSSE,V*MK[KM'Fcse$VDq<1oulh0lWU:vL0OlMI46>#`w</M?WFv-d1GI:TKl'&Uh+,sJQ`q;7S$4+=c4(&.-(/rs=tj.sxmf%u)Uq1rM@NsLs3U:BE/^Oj_AxtN+;>#_UK(vpe:G>2B&q$V:7mK]_t,MSCtsYeBU:vsPq2q2GbDJpe'/v1(KgLF<%+N^kdaRKIurR6j8e?YE^@TT<&N3]+kuL(T1q>p>sl&Xuie$R+<5&jS`vL)uVxLrh]K:UDQtL9L1#v1QAlYS>5m'D`J&#o:V'84_[0#o:hc)As#EE-DS`tPkG[([2FLaj9CNER2aGsgn`x)x2>G';uRC3C]ju(H/g&tm?I+'c7Z(laxY_Fla4#[h$TN'o*#r6^L^eMEfa-vgMJGlYom>>p0eCsTRb*H+x_5/m,P1vr:_KG0[&wQj(ssY/a2,vf1EX(6;:G>#sM=G2gF]8Wbv+sVL;:%WHOgC&_lD4$`9D.^m,v:E@ns-9,>G>_<kM(4.$gL_m*3020Y1vXI$$Z[20&[O*uCT+X(ZYX@k;Q/]$s$6WVaRE/iEMM_YgL(f0k$O@2G>.QSR0Exlh0kTU:vL0OlMJn<0vK(-$ZR_]Ds1,ubMCLBX.Zgd_s6I,n:]`uuuc=:G>G5pLpi9+_S)x5jjr'DP%e[d0#^DB*eVj_r.$d1`30#9MdBFT[-At8MFp>/77<dFCFYV[;%Vm?U/x:GN%s]:OJ9T?J.;&eOJ[ul9AD2@8J$/w<Ar@[PTj-8u'sj@CEms,VLcwL_E?RxlBj;mSfp9.+ET7qf`JMbjVh33V$1SO58/XfOJFlRN'_S*48d9mkBQ'#x'2F$_sPp.vLZ%?:$J;fe=('_e?`&.^5h=Kh,6V5Qsb]hs)uGwM4)*EwB3SvM4.UI3l7KbA=7jd$vu2Y1viv[0#l3&X>71LG)vVSPN.QKN0*2IxB_gqvR$&1l8fT2C-O>DP:`id8%4/FG2$0V:vAVBuuuB`^Y[-A>,Y$me$-Ng@kN+;>#`QK1vWo/O`0Zp/1ho+:?dtDCF5/9p&Ff.@-en]X1`=v(%>DDh$A[>/tdR64EMfx`tvi^(**uM=-VFD=-N=]U.nqco)T4A:.*2xHh*/r`X@)Ej`EWS88h4wKp0+apBaE`]t]hWu)Ts]O%=`>Djx)7N'SqWI(f^+M:LIfKsnw)uP&XFnLmrTq9+m]tPsK=3Gu7DwK@VftYrF].bPF$##a9k0P#-Yl8?g'B#Y:p1B2RbA#@kvGMv[8+Mab?>#9THLPe/tpsiV=SNt=s]$G$5rBtZTC-TCtIF%(^fLviX@t4ol:MkipBA<c:G>QM%Q/]RButM;ZtP,lHkLWs78%^w+UK$u&JL&:%fQs8Wu$s)tT>xgs`<R*$Z$@PJ]uM#B:)33`(QN_leU+0VDNhYC`$Ah*<-Gcoh<P24O4Pu<O4PB]1Z^MRFR64;t%Zt5.v.F2G>3);d%]BGYsbnLgEB;S`tT(m<-BYi9.oL.+E.Sf`t72vY8caVLFFUI7tnSf34b*Z77'S47752%9^HFJE?/_l`tu]i+PRMpB&@S)ss1XLQ;^.NGsvj)/MbGUW./j,w)j<uv-iWDBMYO;qs8jFvKj'jW>LQT:v?E2DK%A1tL#=%$Zn4VeM)jX-v>Rd0#E<*gL7hwV>v.<vT;Kc]Y0dW/1iCE%tVS2oOFbkV<G*vhL?Bndh'KC;$P86-v,H]1Z.:q#vJwd0#-e:ZYm#HcD(CtM(P6o/MCs,O0=l^dR7Y%/M7e50LkSjp*xS5<-n#)t-bpexLm`^1ZW.Vnt<x;)>;2#/?5r0ARWLU]tvjJf)wT<*Eh0F2iPpwk&4#Kk;]ikV7GDQqKC_(8oo5Wv.C)FAY@ZTZTbYww+xrjkB61+9.>HknI-fSdsjj]9&&TYbVF71l+-,aNi=t%>-?j$A-ZCx:.O8]q)a_L]laT>9.+K5i'Ibr%c;`aQ/?^TC3n6TN'VHO<-<[Dm0+$p]t7cbn@=9+rHkp-C--g.Q:KS>61&P8lOH<If$)lm_a,$2^1xsQ%oVN]RR6d#_?)M4&uu`nnAw<o9.XVh_3lpGdNa'#:&^)UMNn]M#(S)dJ;HHp9;nBS*%]3r>2H.hV]MuU$b6,6pt,7Qrs9ofg%uso^F#ZB9B.`/SsxWQ@Oor<X.Kgd_sv&lv:TCL_-(B/Wo[?9dsDb7[@7n6#mri>@G:Pdt-Wp88M&#Rus1-,:&,JKv)w#c'%sD0^tb'It)9ih^sV0VeM)OC&;ZQNJ-1wc]sv8QX5fgxht(J5b$g_t]s>7>:&wXc$k[USN'KYIbMD[e'&Fm]]tX,4=&/87JrRR,E0$OcGu/mP^tVfnM`:%YkSn#rG%;b?l)ukOj0'Y[I2&s'V$OJcP%//_a*/.]m/>sb@=n6TN'W6r0%2`/*uP62X-Mf?_8@RAd`-(lPJ$OMS]Yu61,gQ9BuE$_HNF5(MuFW*#.fWhhLHOVR[A?T$.D0;EMs<6Qsl<oT%jhFLpQ=lCA?itkteS#eO$t8]+>`Ih^qXatOVq('60Zln$sa:6l*I_gip[lCAwItkt/F4l96kA/V8,:u8N?WRs`Fqwc6LO.*g;7Xc&3@$tuVl:&h`'F`K_Wa<q^),W,J>)NHI=DuTeRKu:R3W-E1k$'XB]AchKA@G'/ISf[AoPAK5G5p=`onA6hJt-1tGAMj`Lw-.6SvLrp#u#ra#=(7oWLsStYx5P*@RRZrCS]>GU$b'T5pts6QrsZQF)Su)Yu,8Xhh.ll.77C'0T2f&'>#)H[jj%J:EsE`K>=e2*^#stsQ/Of>TM$eT:vfI8j0%4--vqpe1ZoEAX>w%NGs86b(EZki(tfR3W-ua?b7)fO&#:7)=-wD&mB,L2U22n@r7(b?/rbK)/vZ)c;-LsX?-b&?D-'u19.IB(v#%]bxuJ4bA=of'/*Zt5.va`kT>&4m]Tn>sl&N'5>#miWxRG*PT.npZS%69K>%M+-thX$`ZYn-;,%>7]e%]I>W8ZNOP&:t='SLSkb$F;m/MbCE%tY$me$e_gfXM=6>#=Sh%@Ro4Zmmx4#ugFbE=3K/LEMZMg2Rnq71mNhX?9+)^#R&Gb4=:47eB_.(qvtlDs=:+x5GrFQs>jd?&r)qs-1dX<MY/1W.uqsm)f$l;.k)*o[f-#G.n(:[9Zq)F.CMS*rxt*%>:&[wXI-'O05Q?LB%I.^txh,3<I2[K>S9X1'KGmw'hRd8JTc41CGvm20aAV:vFZT1vqV0I$>'-0BaqC(&niWn*3M40L3W8>#4vmf%p*tlGqoI5`X)NZYLlv1%'MS)tN)8>#H2_uDZ8l`OQXGg*)x)<-R[o^GAlL(&HZc)6-vBoOUtG8DZw$mKl#u_./gGfOf*%#%0=e1Zq2b(Nj+E*M[.@xk=@ExB6FK%kuuxV%8Doxu$wlhL5,l+JV4Xe$LI^q)9be1Zap/B>Rc@F2xQ-4*;&?O0p1eCsvLO&#mka^-nS5NW.c5<-_:[A-TJ(_@G%2)FXv'W-_Be'/+Zc;-9'hLOIs>l04`)8FA,)uP/s4h2o_T(0F:5>#/mYoOF-V*%bq2G>M0OcM,ecgLXh5;-8jq_]lK'997Rf,tw;al*Ihns-1H[FMZ/MMsbp(h)ilXp:YX?r7k#NGs[cDBMNHxu-YoS0M^YsU6;P,o)eG@nnRRAq9Mw[7t&4i;&,=ih)xMbv%qB@I:X7[BRfZ3Gs?&%*&&[tt>qq&x>t#7s.tgq[0)lR/:p)L@0``oPs)UnY%$>&LpaR)c#MPcI%Cq9<?O4mGABE$Y?'l:u?iQS[Be/OA.,G/1B*D&k-7$K%ou_#J(qF?e=+*&Z$AjT8%s8GcEw%LNCx*mv)Y>K19U$Gm/m)_V]CN/^t,v?i$5+mpSn%ne2,-=N'>^=v-U=XkMSTo>-$ar]$w.ZD4Lb&Q/mFSxsFW01p4&aw-LWOj?E7Ycsp'<7U;vQQ%V)Sht=/2>9:Hf`tu<_5MR#_=>giY:9:afHsv3Zw)LvP^t+&s8t1POrLp*UPsqZC%*1JqdMutnf$(C-@Od&p&Z7qbko&v#BZBHWG%WX:Rs>7Vh)&4*U-q5Eq-@IujDq9cwpf1pGr<sT977']qHR-%Fs6:K)SGAV.:@.DNs+USLuq*7lONj]qH2h9i12A>29xH,mBQt(:qm4Lh,d,Ka*r9uG5Ic.k9DF`I1Lj/^t[AMh)TZTas:)0pt[[mS)NdQX5$[On32(0CGUO*]>%^4at3b(-*2?P?Gi-A32Q`cR%6M'ZL,sQN'UOZkSBnJRF@aKYm4L4q1/kGntsQg*u.:P:v-R]rBal0H2nge1ZXm,rY3.LDI-gW4oN,$-va?e1Z-0]tBmXGpOps?2L1OSM'HS;4Ys#;>#QM<$5`uMiQZsvC><=gts,>8oO4F)>#q'_^s3(sHG:`VU8KS`R'Jcs>t,.O%=(GNDslSNDsgsEr?;1X&QwNFHAuFX_s&4h`s-%)h)&;HZ7Nq+w7ZNkGsPNZ)*ud6]jkQcn@Ac/J9:#7Z>%X$9.bKTv)iZL<H?K^bV`M0^t[45:Ix6K-q((lhO)+FAY]0XU-lMIbOW8DgO'Pb&uN0<4t:_Jf$'W_W-G[Wt1dou>e^$poB]R_tPs*7WAoYCdOaZS^6p:P`8NcN^6p*n/=T$BKs3-^A&dYFI:'bJF<r-ruuF*rOBe[o)tO/S:v;TK1v[%/:)6Xe1Z+SqFZO%aQhxOr,vmde1Z=Y1fqt&i^Jqv4itkD6pRS=D_akM7i06vZRsnL2lOFFU]t'5'Fs/`JxtEdL2T,^(?>?$6aS/qLZYe?:>#G'+k3WB[0#0wUZY>rgdRoT_V$N)8>#:)MH%p1_;64igL1Ft4+)Dt.%=hRGIheH`]tPa_KATQOPsAh1e2O'3vO,R]Rs^AX]s$Csktr4IwKuo;Gs78`T.Of(ntN_To/-M'tOSgqktWD/r/Ze'N';S2Fse[9`?)JH+EkLAk(aBm.v3WAlYTri2KUg0#v0T]1Z-LV8&5-JT&N'5>#LHo>-Uj.jLw46>#14-Z$xcm9/rdGfO2c*q*WXcU/&UV(%gT+@OMk4@-P]7d1sZ*mBdL=a*)As?-gLiW0+=t)sr67r$=cSgLd?['ti1gA&/&W77/PM4B]0jGsvZ>/tCv8'HK]F@;#+/)tIa/b*t#5<-wU]F-@$Z0(;Gp-:-Of)t]IR@uNW0%=(`IQMGCF[X09nRAM$O>Hc:eQ1UQ9Esg(A1t6QKZ/-9(`=dbQJM/^#4@*`s3_<?^X81X5GsI+qUI0b7atBq^OJ1`6.;PsA$TdwLE1sv;%O?]4ms5.k(2h)rfle$>hs-e/b*AH,9.q3kB*x)'<-ZG<j$N(i10m4VC&^]%N'/F+7*/KW=AhoB+ErFXGsY5<1TBb)Z/`NTas,Q/+*g'hAuvx3=t7OA+%[i7N'g]QB*P4(*c^q'o-o#:Fn7bmZ$*TjDsw$i3]^:hP;M-TLM%nv_EnfX#%D5hc)WQ9Es:667;SAS)tUItC3r.^U7F.K8Aw@9p/jo#&cU(^#8=xt]Ph$uBf((_^s)_Lh;,;FGs`Ef%[<Bb<u#O[?/),4pR-Ni?:/u,atY4M%CI`(b%0_E%Ck7Dqm0GN4Ki_(a+4m5q1WU^MsTbQ%=Z$+]sYu899N?(a+'5'a-XfeOKAj&a+<UNe*&a?@-_K&)2nM]n[)v=_tuafKB#$LBJI1D.v=QsT>;]l%KRkrM0mcL+rN)8>#)(G(voje1Z`VwMhq0eCs,&#<gpIs*M2J#o$1b`8&8(A>-$Q8mBOki(tMGhJ)d/W#vf?*MWmq`]+4ZCW-w,f1Z]P6ct'nG;_2@LJs#/IjOfT.A_b7H/tE+fnn,G4;0LYLU>A,ENX<n^NKS(8FMvK92vM1kWq:DF-Zr%pb*DBT&O>gI.M,iW?>#&;>#0nZ]%>;G<Np:eDAet8MXSmV`$f+B#v>b7SL$Pg;-gXL10I)x#KtKT:vuwY<-5Xwd+c`n%+'d+HM*k<i0epsOoM*T.H.Qqr?h(5Gsm>J_-9,Qbd_nn(%Y6=n).bp?-B.7*Ib;]GZ(ePI%O_g[+#-XwuPnC`HMlt&#mUn.RFGx+%PH]1ZTZ/I$K`;=fUim>>hJ:>#&fB#$K;Cj(wBiW9UsG2v3$I_8A3]0#`AmrYSele$Zd8>#97)=-uLH9/StQ0uQ_s&B(^BsRYLe0vr];m/dhRoL1'`ZY&_Gs-F2`*MkrDi-oDo<U@d1A*l);f(3i5+vFo,$Zq&Q,C;XkxuomRROF0)iLk)3iO5Z;Os>vG(%@nem-bC*15-x9hLFUvEO-UY,MvLju.H.l8IS9NAC>8Q[=/uCAC+MQ10JBCs)XQ9EsI`Ys-x(W[=v5/DtFvWQ0QbT:vF8buMJ:Q:v-*+r.BTK1v0>I%>=Vu'&IoqlKQB&B>mbL+rO(Xm/%qZ]%)c4#[x)HC*9PC(SplpoO%t-Z7Ha>CE/4M%CR+L/u+68SQu29s$oYc6<&MOgL4+88%OFL)S+-Ve$#*]JhLhriLI%[/vJbKe$mRgNE.86PPi6rp$Xfv-(,^0ameF/;Ad*SU-kqiF2V?kFI4nhh0hcWU-k5P@Ol4I:Mq*eh0u[?/V@Wv3+hR2d$$Jj]tulbkL-*^qHY/8n0@qk`O7fCr$U9JbMvEN0M$;MhLeFx_sR4vP'1[oT%ui),sO_Q<h5KP`9h>vV%1A@/rdU8/v6vCp.P(?YJ>(X=?IAGb%T=sl&M<C)8ZG;s%$I`Rhcr3_$[Gfo7$6C#$[`OT9Wpa1F8UUQs];Y58HI]W&8UmjBov[,XO&$F%C@#MMY_PmspDqk)5a]NKwch0pb;oDs$KG1MnKbY$=fQB&aeB>Yg.6.vn/]0#UovqW-Zoi'TQ12v(42G>8h?VsZMwjO$u*:_qu)7R8nLxB^qTDN(K_5/CdsT>6*5DM:+OsYG@T:vgNSSoen9<fm93e$-f/N'oed9mNOvpOS6E7%_*38uiHRU0%3]hK=9W77>&etLRKJdsXU:c7LtjFI9sYSe/ZalO?efe(SrFQs'F?<__J.gtgbuYs;ZL7RbL&=BS#:<.N4FkfcIocs`b80M7Ef*H'Qtcs.9YO9UGAu,YACs)O++4M+,+OsCUF)Svp8a*cVmp./_FvsB?<r7L](Hs5gD5_r*UU-f.`<J>nD?-s3,gt]V&vHr:PGs3eghL[<sW18i90F;G#V-v[khL(F<l*(7=e*:r(+4*RS30hJq-LS=SN'ng,7RlQeos_GET^&/`dOq9D@AL#dCEs?8C&`iN9@]V=Z-i.)UB@9@fteQ+7R&^MotF%Ib1<U$@%IiFmstSnuLN?0vL)SJ7RXuKt:TYh0,$,I@*ti93MMP%Q-I;b?Nh5$N'v##,*EUuGb9pr^:4S7i;W/fI:J=pu$:U$l)]Q9Ese^+?*o+j2/LRq/umTnS^jTMpLD>:8M$/MLj(S5a*+67w7E<E#??e0OXVJ//FulE8A5LKX.^%wT.fLsQ;Y#ot/Q+4pRCGCiOq:#F17kr_EgJu[/nY%:/TE9EsRIg_G>Q;v-jk6R1d'AHs;ZL7RKtFQsK&PsoqVb09'N:o8MhS=H5*4Gst3Xe*f]JU/mijhsKNobM4K@[.8m6lFR_Ve$a=d0#-d1?>*F'f$7>w<(gV>h02QSM'R5Qs-.^G'=XT0N(B;r:HoNS2)[:fb%k[cI:kw#qOrv+:?/N3lOfmxpOS9p-LR(O=2O2Y49t,2#?J&:9(_(7i:^'#TS@GRq)25MtJ.Gl]HRg9V]vH24/e8cit@L2lO)O8lO[L%qOZ-TEseU3p1Y):q8)H,mB[+uk%ATWDsb_c/EC44X]aH;^sTIw_E2<H$20VD(S?N.ot-aidSi$&*%90^'&)6V-)Wu(csv-4=&B#T49bkN:Iu*<Gss0iB-(Q4lOM[`qHJ8cOKGripp,`JKs3-N1%BDqGDSwfcj]8C@R7_sUm@>5aIk?T:vp?2=-Ub*ufrdR(%hk:RRlKc6:hjB3:u;KhT^T.FsZ(TN:eA$LN4CPLs@CdLB_=m*%AeA>_hAJh^E93FsMMNL1f?R'2K?e%%nu:IUS?n.e%FEu;wtxMKJoL5Kfh5?Ix,1X8K#@eqgTTN'ZUrqRplpoOjN5Fsw'wns7Zie$:iVkMNh3g$@q24/Sk.HsUuh)Fv^&&u9TSLu6kt;f4ZJ7R7M2OsjjYx5l$G]sHK0(**.p^F&NW'jSSItB@O/N'APZbV4RUBurlnnIawrI1n)It)8FGb%Y/1%=>JZb%Te<F%0EtTsm%AY-[0Ih,g=UtMd'#B*V^`$'XaV_&$n)@OnbFLL[reLB@.DNst:x%uU<dE[nm9C&8[>U)SS+@O*FFLs)tQl)c(`QNgc<uLne'hMZCrgGVh?.LbHq`t-8aLBoc]v$b],tLk1MejxT;x)Q:P9V6+F,Vcjq0-oQ;0vpe:G>P,T1p_2=AGN$uWLj1ldVmO/x5bJVDs^2Z+%G>I_W$OM.DdE8ds$5^n)SIX#+gRxs-2>+c*+7'<-)DUh0a1ER]?qT4/=3l*M#)R:V=]jF2;9;nN,b<RRpN@_tjJRtBTQOPs==pethJebO4aMf$s1rt>?:-.DUHJ:H9MPk*Snas-P^XVF<4Gjh'E^otw%WJM$`6n?@L3oA[4EW7I/xtt?;^;-2M6l?Qjbps[6dw)J?''e'pxXu4+.4O6<H%+vsx8.sn:G>2vbA>apmw'G#>uu/[+RNw'#GMaiehEHRqoi'A8RRn(.d@=b./VdE2(#fmc+P,_1ZY(B`MPd9cY#xTU&#Gbtf%/sH[',jH['3:C#$Jas9)$&nc%Rw$#uVv:h)nXEZ;Z+ex-:E(8N#=oY-$S[_8>T4%PDitA#ld`:)SNo3+vIF&#g.K+<lt#IQi?uhU>0M`tta&HD=nN=IaxT:vNf>SOpKJX>eZa3OOqxXu<PAY%x+lB]%WQ['vxi(tQv9W-d:&:)`2$c%rh=a*S'U30F+L@FJ9[_OYsOShK>s1L[#d-IQ'DulN'5>#q)``*I@vgLP(7)I$bO0M^o'YC:W*^OgZXKM68[A-tH:1lw5]0##-DP'gM)GVW*6=10H]6E8<Mg%dcghL,@uRM94#dhKNT:v*v4r$w1doo+Lpcsjtu=GxogY?2)&Y%<_:'#(k-DK1&V?>cZUe$*a9>#D>UoOutbQ%n8cVMntGWMC]Gs-d0LhLNj-]-Om&fD(wkxu,8/F-CS_pM`I^VMXDGhO@m)otxWH?&=UaOJ0)RN'#])4Jx<dtZR-T_E?m[ot,s6lO%Z%F`0[gatx8r=1llmfOpmCqO9aMf$CH`JQl`xI([=nNs1^#c]hX(u#6R;mOi-A$5^lvKp&DZoBir-N''Tr5>Q6V)3MCnt)XvP^tCS#jsVVGB&F.bd9n/Wm/.mRvt%dghT9o6iTT9EhumgJuG:t%uG<DxhtbsuB&OqahL;(M_thc[Q/S$'.MD^EI:%`Fat8U0(*wwPYsSDlD3gU&Y5p.L#umVCC&JWcg)4,fF2uirv#fZTaswG-LgHE&ps6ECI:NRR77Ra3&'dc<A+JMXe#3Xfi'8_b]4j:;A=Z6JVH;8v7n<(.vGSU[MTqdfYl&,cYu%&1j^=.>,r0jOsQJ'QE*=TUE3Rb'kK5G(n]6Ix6&N:X'4fLK[54-d*WPd>11=it$Y.fN.2xpekgcC-A,W3Dud8)oi(#vH50]O7,Em(#K)Jp:g;Q(hVe.XlYmitSg;swa^#I^TZ-5,1<7hl+<@C-('GQ1CHWc$YakkNT^uDs%:&3KrQT7J;U8.*(U]Y(P_>-t5ej<cVbOmr0l(7K8+4ODYbXrpultE9F(SCSmem*&cQ%'e98.'?cp.l[T(vHvG['2@hhL@W>H2[2Y1vYL$$Z*#LjBpH3.ve.j<?s@Zt1[<G)M%&ChMp:jEMb`Xf02iBf$6Uid*]e*<-5N^oL^76>#rrbkL0r5<-vG#`/6<8pOAP0p[(E/=(&Lqt1DKit1,[5U;#)YB]B;KW%gvux42'C&,aaH&#<k?['sA%0%:1lxu&&qS/@,9G>qq)vu#SbxuWMG7*x_L'%;X4%94VQ#u&ujcO#=xnsxhjcO$U5^tbO,aW%^,r`d=C;_s88IG<)T4tD@Jf$B-[Rspg'btZQhm8**,rLaPPTsmsUNtqa]1Z9w1/v0L2G>q5WP&dU8/v.LMc>[KoN0:0`s'b0:U@'Tu'&vtUxLPW;1LYu9>#YfDSF?--aX4dh6evmO52tZYF[H9VehvxU:vc#%>VrAhMqN'5>#UcsAHhs)6.>Wl)MNFLDRbM)sYriFQ&ro.bFG0e8J)Q5Q&Pire*,TKU-BLV&a^AU%=pvj0T?AE[-*Lhu9j[/-%6`mh*i=J<Hw6aK;c99asm/5:mt&v^[0?[t/$SnnV(Nn>ucUFnnq<fnn/KW=Aa-:]+W4@Q&&]FAuKqo#G/(vR8FI=g;m%.QMAJO[=U&CpLk#2lOnu5Ns&@_`HOV4E=Bx$]=amK<hB/<X]bw?10]0[ZH4kdlOk4l/_,]$h24LfeOLB[L^ih-^4WejeOptjcOfTcRjh#J;Qodt.uB$Id`#rB'u>%FltC<81u;W$W?0?V-HZ'wns;&ke(Mjv8(ReA;-blvR96WuS&l6Z2213qHEBL$d31x]t.n&atP^b7E,W0%%+44-b-]=]32n,%HFkg*uP3k/Q&#.6Vs/:.77fn%qO.I%Y5)<aDET=_'#&(G(v<wMc>w:hc)8?op&m5/0vg`1C&7X[0#33rZYP3A_Twg?8%QX'_,Yo2.vJM^1ZdX3xog4p.2i?TgsQNsRs5Sja*AcT@->s]c?k'A4^5@QMU^$xbB3,?4^Z_(T&#ZXr$`YKlO/s<OJ,V.W-@s0i:^9BGsb]@f?Zw,K%)U^Ms_r3lOOtRhtF0O?KDW?T.KC2RQi<+itx,7lO6*GQshP;Os(bWh$fH2o@JP-Q&N)QR@CAZ6sBSl)OX_qkt7pMf$Sm(BQ^c6gs[?O5um>Z4Fb#3+2i.a0u?G5xO&/KsLSW%vtn8a.6U&(Q&aTtH8h,3a*aqOh*OS]P-Dnn'nhpse-5`#it$A48:i9]qH5>*@-)f9A2wb3Q&Fs6LDKU_vJQ#16A@rO4BQ98r@SM/f;O^ZAY)5w)E8l0q`Rm;+W.@uYHxnT4BJutS&-k(C-=H1_:6wL4;'Gh_]aN`R;S_5]sigM^O;kEe*3KAO1Bhgkf;dD,u*.6Q&d:kmi2:%xIVm%K%WmbesX`Q%=UZLRs4ntu'/)R:VsI+Q&DIkNs-bx`]L.PY1dD8M%4uv8%TpVf9Z45El,h#J(F6c3BvxnS/'wS`<NL$Hb<haR8b#]CFtm'_S1uNp9*dYCFr<I,*UR]-E>3=Gs9<cY1)Z>(FQ(QJMR*kg-s72xJC]8+Mhv_E1=04[k_kFV9jV(U8%Y-2_j,bh&i_2G>,_1ZY5mOJ(W3W#Up>sl&5'Ap&]TV=-0l:p.u$0GSXvfe$2]_^YSu@/LG)&n$?Ko5%9k=5r1Zb]PR9HW.?6][kMY&-u'DPi]a,%w1t[5+QIpC_GxtiF2JI+Q&]/B;Kc-nCYqu)7RO=_lO%:=.L<P:uU?^D[Omr^qH*i&N0G4sktoi*uB4/5sL;UQitL3Gf$g3?Q&$Jj]t<NhpLOXfgs-^9L,/0`FMec/*vjZe1Z*o:mA.5'3E%JJ^$O>E:CU>3iOPGqjWG,vXU%4vxTnPSM'7Fl&#WSBuu(:gs%=G:>#L)h.U.kCZYRk1f$W.E)+8i0H2-txFYl42:m@ec9mC#t_]L@1lOJVUQs;xW7N=BHr6*AD:-xKl/_hJwHhJ+MZs[H+[TX`nK[[t74]VSBnB9lefL*l5'2Y1HC2FX$Ihk80.v_)@<a3d3]+;9*x20Y=>%%W'Se@lti%JYc0#.0888SjC(&]OV:v?XK(vZv3G>2Xr*M=8ip.>Zoi'XI8:2;$w.MSfQiM4*D-MR]43L:/Vl-$jAUDb4G.Mx<l%lXZ;#v,I=MH$Pg;-rA=V.=dogO9<'v*))KgL#Df>-I7]jLk1N*M7Ppu,)SvH?qS^1ZiE=na$0c'&P4WP&NC%4+`KHD*MgBUN@5+/M<U#0Lj2k<_=?NgLEhF?-q6]jL_@eA-^fg,.1ne+MSeMW%-nF-%l-Eop%5v[T0ua`txS5^to1(CW<GaLBxRvw+s75>#`m$>%'GfNKR.PTS*SXgQH&Te%V<+Z%pgsT>8P@@>h4pLpQAlM(v2Ak%d**;nN)BX%sO%iOeocKDKwvuu?$vhL[&;-M2B@%+pA,b*+V39.RKM`KduH2qX>(KL0,oxuo%4;0w.n.LI1eCsY$me$8bL+r,3%Z%Q<8X:J2dt1+pdct*KrNsl0RE&`.%pJw6D<%In[otR.wB8`<3lO)Q;Q/$T4tOV^ItMZ[(`jej;;I`&>F%QJnt(KbZfMF$h@%^5.$pWtkf(m)&bn='&t%N+;>#Aumx@6)/X%:<4i0@^g]svMja*d;Jf%f+3Q&kK]e]'u1)%1c*Q&>@AqBQ'Nvp&G6atn]B^]g^P#ue[i5%)-#$on:ZKDv>LW]fiWGAZ:lB%Su4l8:O<,%3;^EsBuqktnQbU]Wsne(*[NX$1E+fDml9.V7C:.VVrd/rYo2.viWe1ZmAhMq#-V:vJ]_@-FVb^%R5cn*HxX.&cRZfe1uI4T]JvV%o`J['e+6>#+v<V0*@Mc>]T_V$4+.4OLAN(vu>O_/=w-$vu&f1ZB_6b$:X9>#]-*QL5e$RX_tT3c1n(-MccAO&bp2a*K2.<-Nr,?@aLu'&Gp=Q'Zr2.vUv<W%fLUh**.'<-NU_;*A9XW>A/Q:vk1#S.U%2PP?W)#Q*_t]YU44,MBV/+M?;rl-E0qeV?`fQa_>G+EpuL(&V]1O+ZXoi'b_Fc%[Lcb%]=w3=C[lxu^3s#7;.KgL70qH%fIteVE8:kFGMAcMV(tfLK']u-Aj1*Mrn5ZG-fGW-kY3[T>$^p%h<6X1j[$C]V#s,u4.#(jD9rst%/aiBL1jWsv^^@=4S-uQ$h=el_2*ZYg,T1pN+;>#Yu#>JA2mg)$.S:v^$M`EusicW-fGW-jkXn*%JX,Mb81@-JbFkLgtj^-<L&oSYXkwRU-oo%3IEj(RTL?7@L,HMc4wO0bcYf%O?HD%M*tpYF=T:vrQ]rBJQ7jB_j`qLalai0q+-/M^UV4F/Pg%qjR`h*x-><-@AojLNuQ:vDN'GY9^$t-J6EGsqOYRsnQbU]sx`GsdS5^t&Aoi$lm,Q&3l6b7:?quusve1ZN3C1MNKW?>MQ9>#]gI]Lc@m;-$^U-/,*P1vb*v--1wHwBtv4poO,8>#fFE9FpT>E=jd0&G,Hw?.;ED%%^HSV1I0;#<8_t20Itd0#2,`?>.Lke$6JU:v.Nx+8S>_Mq6cBaJun?p70(s<%#+S:vmpZ]%[@2rH84aJ1&NY%Jh+QU&0TQ*r6R;mO)UhaON6K.=$aAm_wZW%CEo$F'r-Cm_kjE88&JPcOeJ$0u$:P:vm*G(vVwd1ZhqVW>^/`:mAG@Z[]=m<'e/T:v`DHW%kL^Z]VZOs-s5*jLnakl&Ji(1v=&^1Z:I(C&xWT1vwJ]0#hHqhLtca)#cnZ]%+/I[X8&GgOVP<%OG&v_E`B+Q&m%EktE1>%OB2<4tU`61umOB)NHDke(9DUCA3>S%='K+Q&tW,%+0hUe*<m-@-slwl$Fc?pRtxMuMrkW^O`>kERRp.vLg6s7uTdpG.2n$Ih<wYw0>5L3`p94m3:6V2`rt7p2pdFIsX(V3O2_=Y-36b@e3s=K3t>/%%dD]RfE6A(>axT:vR2Y1vn_:G>/LjFLb[<oniBEVnWe1N%&?((&F+X,2=hugOUZ*mBX'4&b.NMM0i1[c%h(7X1+KGJ$V^]1ZMxBW._vmf%LlS_%*mXOg<s,k:_r+:?H6w_]T_kE-M`k[XH1eIIfV)<-&hb]tj2rg$;Jb?IY-lC*n^)Q&$UTXjB=5>#sdGfODOSi$+:[0#2@m&TpYoi'1E?X8(Jg;-h@9O0OAn#TfeDW>PjRfL<$Cv$<90.vu&f1ZS_Axt-AptL'ml8IGcUaOK4#Tb.S_V$.2b>$)&J#QOTGLP/>GO4N>xv5OM]Dj]f6eO.MZkO8rkeOOUsB5>vj7gQ[apt'bmCAp8VT8=5nsZp?>>I*._#vk^e1ZG2DIL8*vh%u/'-vF[?YM6OM=-P'Oh[P;-Y>wm^pRW#5F%MoZS%:=#EtbFs.vqh:G>*xK#vR5kT>G8i*MQrZY#X'Db%6sQ0%/),##]XbgL4KihLv'^fLTCH>#kBg;-;CpgLw.K;-#YlS.c@*=REhYs-*ANYM6.UL9D.pGMZ2$)MRi+<#`N6(##bU7##jZ(#eu:$#j((/#A>)4#F5<)#-;eM0K+1/#-Uv;#oI(xLOFw=N8WI;#ZFU/#o6*jLtcP&#F_I%#U=2mL7C4)#K*loLxiv)MIa?+#b4`T.o*c6#mxhP/<`ll/2(&)3TjA,3%S:9&ZMP`<x9@_/*/t.C>93d<C21F%XSl-$Dmk-$]FPk+XRu.C(;x.C2l8_AB>SR*?1trL4d%Y-f)j--ODw9)E;N9`+fkgLl?DiLcw48RT;3F%,u6m'etpA#ZF*nL5T3N0#;v3#t0e0#-Ym&Mo5DhLS[-lLwAl9#=^d9/7FO&#F-uoL+`uGM20R+#A^P+#4IKU#%u:T.w#M($8r.>-^5T;-'E:@-Kd$]-KO5F76TKYGe9Sk+ma=K)eBZY,AV%*+o'KG)$FJ_&NcEG):ikj:o6b4o7=co7K/sEIYxUV$=>>kF4Khi'BL^)t<Ddc2(XGGMQVHNLPsVrZ(#f1g4np-$9rD8At:PPTG0M^uPSqx=7?=D<7cjEe5$t8o(+e=l-^F;$BJY`bsk3,N_+AvZPM.MpU&%dse[P;-@<O8oZo_]=<aV/$qb$0#2V,lLaB4)#m0^.$1SK:#URK:#`u>7v3:96v=`fvLMW[F%>fr92(SkA#pB]7MaS^`OTnBo-vU[-?E=br?IxK-Q2fK#$lrpk.B3,b#K`pV-HrIwKt*co@.b2cixmeJ28%#KNC'7BO?2sFr7,)kbfN$,MFVpV-&pI9rclEF%PYTwKGM@&,GYL<-3*MP-db&kMbC9vLI;(sL2OWU-qM#<-sRG-M2KZs-t[XOMb%0K1L4S1p)9Bulj4;5&NN_Ee,Ogr?E[Zd<A)s.C&d^w0'up.CccCG%?6*jL1].(#2O$iL&jDxLr1>5Qn<vWMZ?-b#.4q#$txL($S96L->1QD-GDAZ$(?YF%O]8R*W2v(3q.9p/+6@G%_O35&+0e9Dd>srR0^OwKLMuQj?T#Q/aAk]#Tnw@#.l'B#2s.ZN#Nn1K%kX-?'v#Z?4@ow'?v,F%of<R*.pjk+XuYlL&QK5#KG%+MYndLM.v@(#(,]-#$V@+MWD&w##Auu#'9+;.<7YY#?,(W-Fg7RNs<[`E^[72LPmo-639j--k>N#$'.kVMu;x/M'Qnv8Z.>R*ZGckFpb,_#ab*x#J2,b#aPuO/LxL($E+eQMEOJ#MV/AqL%Zqw-]/8VMF,x_#`&q^#Th4g.1elF#3+wa0FEO&#tVc##<86&M6@DiLG1-Yu_vK;e5w#,M6S3v%K]$kkDP5P]e1QxkC%8jqFevCjBvZ9MSAD2'29/p.2M7v61JcJ2U<ml^%lB#$YW_ihuQ.>m69o5'/_^fLR.NJ:6$5_JKWDkho/DoeU^f=lZlc=lB#fP8lmlS8I.M>?$@[9M:5hs-[+eQMedgvL0YP&#ZS#lL#rW4#>h8.$#N6(#c`P8.F;SY,vIO&#_^c</b]]A$pWajLk[HLM4P&+M&TMpL+1moL7HgnLqv.0#2F_hLXE?)MUfw;#6qAo%$84_AM#####%u.CZpv.CvTMoXo?&##"
}

ffi.cdef[[
    void _Z12AND_OpenLinkPKc(const char* link);
]]
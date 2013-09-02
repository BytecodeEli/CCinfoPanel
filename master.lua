local configs = fs.open("config","r")
local confdata = configs.readAll()
local loadedconf = textutils.unserialize(confdata)
configs.close()

if table.maxn(loadedconf) == 3 then
local monside1 = loadedconf[1]
mon1 = peripheral.wrap(monside1)
moncount = 1
elseif table.maxn(loadedconf) == 6 then
local monside1 = loadedconf[1]
local monside2 = loadedconf[4]
mon1 = peripheral.wrap(monside1)
mon2 = peripheral.wrap(monside2)
moncount = 2
elseif table.maxn(loadedconf) == 9 then
local monside1 = loadedconf[1]
local monside2 = loadedconf[4]
local monside3 = loadedconf[7]
mon1 = peripheral.wrap(monside1)
mon2 = peripheral.wrap(monside2)
mon3 = peripheral.wrap(monside3)
moncount = 3
elseif table.maxn(loadedconf) == 12 then
local monside1 = loadedconf[1]
local monside2 = loadedconf[4]
local monside3 = loadedconf[7]
local monside4 = loadedconf[10]
mon1 = peripheral.wrap(monside1)
mon2 = peripheral.wrap(monside2)
mon3 = peripheral.wrap(monside3)
mon4 = peripheral.wrap(monside4)
moncount = 4
end

function monitor(func, param, param2)
   --todo
end

local button={}

function setTable(name, xmin, xmax, ymin, ymax)
   button[name] = {}
   button[name]["name"] = name
   button[name]["active"] = false
   button[name]["xmin"] = xmin
   button[name]["ymin"] = ymin
   button[name]["xmax"] = xmax
   button[name]["ymax"] = ymax
end

function delTable(name)
   button[name]["name"] = nil
   button[name]["active"] = nil
   button[name]["xmin"] = nil
   button[name]["ymin"] = nil
   button[name]["xmax"] = nil
   button[name]["ymax"] = nil
   button[name] = nil
end

function fill(text, color, bData)
   mon.setBackgroundColor(color)
   local yspot = math.floor((bData["ymin"] + bData["ymax"]) /2)
   local xspot = math.floor((bData["xmax"] - bData["xmin"] - string.len(text)) /2) +1
   for j = bData["ymin"], bData["ymax"] do
      mon.setCursorPos(bData["xmin"], j)
      if j == yspot then
         for k = 0, bData["xmax"] - bData["xmin"] - string.len(text) +1 do
            if k == xspot then
               mon.write(text)
            else
               mon.write(" ")
            end
         end
      else
         for i = bData["xmin"], bData["xmax"] do
            mon.write(" ")
         end
      end
   end
   mon.setBackgroundColor(colors.black)
end
     
function screen()
   mon.clear()
   mon.setCursorPos(1,1)
   local currColor
   for name,data in pairs(button) do
      local on = data["active"]
      if on == true then currColor = colors.lime else currColor = colors.red end
      fill(name, currColor, data)
   end
end

function toggleButton(name)
   button[name]["active"] = not button[name]["active"]
   screen()
end     

function flash(name)
   toggleButton(name)
   screen()
   sleep(0.15)
   toggleButton(name)
   screen()
end
                                             
function checkxy(x, y)
   for name, data in pairs(button) do
      if y>=data["ymin"] and  y <= data["ymax"] then
         if x>=data["xmin"] and x<= data["xmax"] then
            return data["name"]
         end
      end
   end
end
     
function heading(headtext)
   w, h = mon.getSize()
   mon.setCursorPos((w-string.len(headtext))/2+1, 1)
   mon.setTextColor(colors.orange)
   mon.write(headtext)
   mon.setTextColor(colors.white)
end
     
function label(w, h, text)
   mon.setCursorPos(w, h)
   mon.write(text)
end

function returnstatus(name)
    return button[name]["active"]
end


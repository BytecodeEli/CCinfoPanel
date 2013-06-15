--load config
local configs = fs.open("config","r")
local confdata = configs.readAll()
local loadedconf = textutils.unserialize(confdata)
configs.close()

local versionLoad = fs.open("version","r")
local versionData = versionLoad.readAll()
versionRead = textutils.unserialize(versionData)
versionLoad.close()

local monside = loadedconf[1]
mon = peripheral.wrap(monside) --made the variable to be global... hope this will help somehow
mon.setTextScale(1)
mon.setTextColor(colors.white)
local button={}
mon.setBackgroundColor(colors.black)
local urlLoad = loadedconf[2]
url = urlLoad

function info()
 newsfeed = http.get(url.."/feed.txt")
 projects = http.get(url.."/projects.txt")
 time = http.get(url.."/time.php")
 mon.setCursorPos(46,1)
 mon.write(time.readAll())
 mon.setCursorPos(1,4)
 feeddata = newsfeed.readAll()
 term.redirect(mon)
 print(feeddata)
 term.restore()
 feedx, feedy = mon.getCursorPos()
 mon.setCursorPos(1,feedy+2)
 projectsdata = projects.readAll()
 term.redirect(mon)
 print(projectsdata)
 term.restore()
end

function infoCustom()
 time = http.get(url.."/time.php")
 mon.setCursorPos(46,1)
 mon.write(time.readAll())
 mon.setCursorPos(1,4)
 infoCText = "SOME TEXT HERE"
 term.redirect(mon)
 print(infoCText)
 term.restore()
end

function infoAbout()
 Version = versionRead[1].."."..versionRead[2].."."..versionRead[3]
 Actual = http.get("http://extreme-games.6f.sk/version.txt")
 ReadActual = Actual.readAll()
 time = http.get(url.."/time.php")
 mon.setCursorPos(46,1)
 mon.write(time.readAll())
 mon.setCursorPos(1,4)
 term.redirect(mon)
 print("Installed version:"..Version)
 print("Actual version:"..ReadActual)
 term.restore()
 --print("Version check...")
 --Actual1 = http.get("http://extreme-games.6f.sk/version1.txt")
 --Actual1R = Actual1.readAll()
 --Actual2 = http.get("http://extreme-games.6f.sk/version2.txt")
 --Actual2R = Actual1.readAll()
 --Actual3 = http.get("http://extreme-games.6f.sk/version3.txt")
 --Actual3R = Actual1.readAll()
 --if Actual1R > versionRead[1] then
 -- term.redirect(mon)
 -- print("")
 -- print("Update available!")
 -- term.restore()
 --elseif Actual2R > versionRead[2] then
 -- term.redirect(mon)
 -- print("")
 -- print("Update available!")
 -- term.restore()
 --elseif Actual3R > versionRead[3] then
 -- term.redirect(mon)
 -- print("")
 -- print("Update available!")
 -- term.restore()
 --end
 term.redirect(mon)
 print("")
 print("Credits:")
 print("D3add3d - Creator, main dev.; TechniFORGE - Server with awesome community where I can test this in normal use")
 print("This program is Open-Source, check it out at")
 print("http://github.com/D3add3d/CCinfoPanel/")
end
          
function setTable(name, func, xmin, xmax, ymin, ymax)
   button[name] = {}
   button[name]["name"] = name
   button[name]["func"] = func
   button[name]["active"] = false
   button[name]["xmin"] = xmin
   button[name]["ymin"] = ymin
   button[name]["xmax"] = xmax
   button[name]["ymax"] = ymax
end

function delTable(name)
   button[name]["name"] = nil
   button[name]["func"] = nil
   button[name]["active"] = nil
   button[name]["xmin"] = nil
   button[name]["ymin"] = nil
   button[name]["xmax"] = nil
   button[name]["ymax"] = nil
   button[name] = nil
end

function refresh()
flash("Refresh")
print("Refreshed...")
end 

function bounce()
  print("Bounced...(function call is handled by another script)")
end  

function fill(text, color, bData) --add textColor? maybe?
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
      local on = data["active"] --add custom colors? sure!
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
            data["func"]()
            return data["name"]
         end
      end
   end
end

headtext = loadedconf[3]     
function heading()
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

setTable("L", bounce, 1, 1, 1, 1)
setTable("R", bounce, 2, 2, 1, 1)
setTable("Refresh", refresh, 35, 50, 17, 20)


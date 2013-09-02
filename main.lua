w, h = term.getSize()

--files check
if fs.exists("config") then
  local configs = fs.open("config","r")
  local confdata = configs.readAll()
  local loadedconf = textutils.unserialize(confdata)
  configs.close()
else
  print("Config file missing! Sending terminate event...")
  os.queueEvent("terminate")
  os.pullEvent()
end

if fs.exists("version") then
  local versionLoad = fs.open("version","r")
  local versionData = versionLoad.readAll()
  versionRead = textutils.unserialize(versionData)
  versionLoad.close()
else
  print("Version file is missing, will use 0.0.0!")
  versionRead[1] = 0
  versionRead[2] = 0
  versionRead[3] = 0
end

local monside = loadedconf[1]
mon = peripheral.wrap(monside)
mon.setTextScale(1)
mon.setTextColor(colors.white)
local button={}
mon.setBackgroundColor(colors.black)
local urlLoad = loadedconf[2]
url = urlLoad
headtext = loadedconf[3]

screenNo = 1

if os.loadAPI("master") == true then
  print("API loaded!")
elseif not (os.loadAPI("master")) and (fs.exists("master")) then
  print("API already loaded!")
elseif not (os.loadAPI("master")) and not (fs.exists("master")) then
  print("API not found!")
end

function input()
  local e,side,x,y = os.pullEvent("monitor_touch")
  result = master.checkxy(x,y)
  
  if not result == nil then
  print("result: "..result)
  else
  print("result: nil")
  end
  
  if result == "L" then
    master.flash("L")
    if screenNo > 1 then
      screenNo = screenNo - 1
    end
  end
  
  if result == "R" then
    master.flash("R")
    if screenNo < 3 then
      screenNo = screenNo + 1
    end
  end
end

function getstatus(name)
    return master.returnstatus(name)
end

function info()
 newsfeed = http.get(url.."/feed.txt")
 projects = http.get(url.."/projects.txt")
 time = http.get(url.."/time.php")
 mon.setCursorPos(w-5,1)
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
 mon.setCursorPos(w-5,1)
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
 mon.setCursorPos(w-5,1)
 mon.write(time.readAll())
 mon.setCursorPos(1,4)
 term.redirect(mon)
 print("Installed version:"..Version)
 print("Actual version:"..ReadActual)
 print("")
 print("Credits:")
 print("D3add3d - Creator, main dev.; TechniFORGE - Server with awesome community")
 print("This program is licensed under LGPL v3.")
 print("http://github.com/D3add3d/CCinfoPanel")
 term.restore()
end

master.setTable("L", 1, 1, 1, 1)
master.setTable("R", 2, 2, 1, 1)

master.heading(headtext)
while true do
 if screenNo == 1 then
  master.screen()
  master.heading(headtext)
  info()
  input()
  sleep(.1)
 elseif screenNo == 2 then
  master.screen()
  master.heading(headtext)
  infoCustom()
  input()
  sleep(.1)
 elseif screenNo == 3 then
  master.screen()
  master.heading(headtext)
  infoAbout()
  input()
  sleep(.1)
 end
end

if os.loadAPI("master") == true then
  print("API loaded!")
elseif not (os.loadAPI("master")) and (fs.exists("master")) then
  print("API already loaded!")
elseif not (os.loadAPI("master")) and not (fs.exists("master")) then
  print("API not found!")
end

screenNo = 1

function arrowleft()
master.flash("L")
 if screenNo > 1 then
  screenNo = screenNo - 1
 end
end

function arrowright()
master.flash("R")
 if screenNo < 3 then
  screenNo = screenNo + 1
 end
end

function arrows()
 master.setTable("L", main.arrowleft, 1, 3, 1, 3)
 master.setTable("R", main.arrowright, 4, 7, 1, 3)
end

master.heading(loadedconf[3])
arrows()
master.setTable("Refresh", refresh, 35, 50, 17, 20)
while true do
 if screenNo == 1 then
  master.screen()
  master.heading(loadedconf[3])
  master.info()
  local e,side,x,y = os.pullEvent("monitor_touch")
  master.checkxy(x,y)
  sleep(.1)
 elseif screenNo == 2 then
  master.screen()
  master.heading(loadedconf[3])
  master.infoCustom()
  local e,side,x,y = os.pullEvent("monitor_touch")
  master.checkxy(x,y)
  sleep(.1)
 elseif screenNo == 3 then
  master.screen()
  master.heading(loadedconf[3])
  master.infoAbout()
  local e,side,x,y = os.pullEvent("monitor_touch")
  master.checkxy(x,y)
  sleep(.1)
 end
end
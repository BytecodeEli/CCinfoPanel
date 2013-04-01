if os.loadAPI("master") == true then
  print("API loaded!")
elseif os.loadAPI("master") != true and fs.exists("master") then
  print("API already loaded!")
elseif os.loadAPI("master") != true and fs.exists("master") != true then
  print("API not found!")
end

screenNo = 1

function arrowleft()
master.flash("<")
 if screenNo > 1 then
  screenNo = screenNo - 1
 end
end

function arrowright()
master.flash(">")
 if screenNo < 3 then
  screenNo = screenNo + 1
 end
end

function arrows()
 master.setTable("<", main.arrowleft, 1, 3, 1, 3)
 master.setTable(">", main.arrowright, 4, 7, 1, 3)
 

master.heading(loadedconf[3])
while true do
 if screenNo == 1 then
  master.setTable("Refresh", refresh, 35, 50, 17, 20)
  mon.clear()
  master.screen()
  master.heading(loadedconf[3])
  master.info()
  local e,side,x,y = os.pullEvent("monitor_touch")
  master.checkxy(x,y)
  sleep(.1)
 elseif screenNo == 2
  master.setTable("Refresh", refresh, 35, 50, 17, 20)
  mon.clear()
  master.screen()
  master.heading(loadedconf[3])
  master.info()
  local e,side,x,y = os.pullEvent("monitor_touch")
  master.checkxy(x,y)
  sleep(.1)
 elseif screenNo == 2
  master.setTable("Refresh", refresh, 35, 50, 17, 20)
  mon.clear()
  master.screen()
  master.heading(loadedconf[3])
  master.info()
  local e,side,x,y = os.pullEvent("monitor_touch")
  master.checkxy(x,y)
  sleep(.1)
 end
end
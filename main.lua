if os.loadAPI("master") == true then
  print("API loaded!")
elseif os.loadAPI("master") != true and fs.exists("master") then
  print("API already loaded!")
elseif os.loadAPI("master") != true and fs.exists("master") != true then
  print("API not found!")
end
master.heading(loadedconf[3])
master.setTable("Refresh", refresh, 35, 50, 17, 20)
while true do
mon.clear()
master.screen()
master.heading(loadedconf[3])
master.info()
local e,side,x,y = os.pullEvent("monitor_touch")
master.checkxy(x,y)
sleep(.1)
end

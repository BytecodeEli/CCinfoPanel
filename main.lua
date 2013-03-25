os.loadAPI("master")
master.heading("CC INFO PANEL")
master.fillTable()
while true do
master.screen()
master.heading("CC INFO PANEL")
master.info()
master.screen()
local e,side,x,y = os.pullEvent("monitor_touch")
master.checkxy(x,y)
sleep(.1)
end
os.loadAPI("button")
button.heading("FORGE INFO PANEL")
button.fillTable()
while true do
button.monclear()
button.heading("FORGE INFO PANEL")
button.info()
button.screen()
local e,side,x,y = os.pullEvent("monitor_touch")
button.checkxy(x,y)
sleep(.1)
end
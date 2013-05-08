screenNo = 1

function input()
  local e,side,x,y = os.pullEvent("monitor_touch")
  result = master.checkxy(x,y)
  
  print("result: "..result)
  
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

if os.loadAPI("master") == true then
  print("API loaded!")
elseif not (os.loadAPI("master")) and (fs.exists("master")) then
  print("API already loaded!")
elseif not (os.loadAPI("master")) and not (fs.exists("master")) then
  print("API not found!")
end

master.heading()
while true do
 if screeno == 1 then
  master.screen()
  master.heading()
  master.info()
  input()
  sleep(.1)
 elseif screeno == 2 then
  master.screen()
  master.heading()
  master.infoCustom()
  input()
  sleep(.1)
 elseif screeno == 3 then
  master.screen()
  master.heading()
  master.infoAbout()
  input()
  sleep(.1)
 end
end

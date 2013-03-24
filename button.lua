local mon = peripheral.wrap("left")
mon.setTextScale(1)
mon.setTextColor(colors.white)
local button={}
mon.setBackgroundColor(colors.black)
function monclear()
mon.clear()
end
function info()
local newsfeed = http.get("http://extreme-games.6f.sk/feed.txt")
local projects = http.get("http://extreme-games.6f.sk/projects.txt")
local time = http.get("http://extreme-games.6f.sk/time.php")
mon.setCursorPos(46,1)
mon.write(time.readAll())
mon.setCursorPos(1,3)
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
          
function setTable(name, func, xmin, xmax, ymin, ymax)
   button[name] = {}
   button[name]["func"] = func
   button[name]["active"] = false
   button[name]["xmin"] = xmin
   button[name]["ymin"] = ymin
   button[name]["xmax"] = xmax
   button[name]["ymax"] = ymax
end
function refresh()
flash("Refresh")
print("Refreshed...")
end


function funcName()
   flash("ButtonText")
   print("You clicked buttonText")
end
        
function fillTable()
   setTable("Refresh", refresh, 35, 50, 17, 20)
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
            data["func"]()
            --data["active"] = not data["active"]
            --print(name)
         end
      end
   end
end
     
function heading(text)
   w, h = mon.getSize()
   mon.setCursorPos((w-string.len(text))/2+1, 1)
   mon.setTextColor(colors.orange)
   mon.write(text)
   mon.setTextColor(colors.white)
end
     
function label(w, h, text)
   mon.setCursorPos(w, h)
   mon.write(text)
end
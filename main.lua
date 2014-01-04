function love.load()

   -- status stuff
   winflag = false
   winimage = love.graphics.newImage("images/cake.png")

   savedblue = false
   bluecoords = {}

   -- initial settings
   love.graphics.setNewFont(15)
   love.graphics.setBackgroundColor(10,10,10)


   -- txt
   story_header = [[ ~= Story =~ ]]
   story = [[Poor blue is trapped in the wabbling 
wilderness of green help him escape 
and bring him back home where he can 
eat cake. 
Remember: He doesn't like time travel,
don't go too hard on him.]]

   controls_header = [[ ~= Controls =~ ]]
   controls = [[move: w a s d
push block: p
back in time: b
reload: r]]

   -- colors
   col_solid_cube = {100,100,100}
   col_txt = {120, 120, 120}
   col_header = {140, 140, 140}
   col_green_cube = {0, 255, 0}
   col_blue_cube = {0, 0, 255}
   col_home_cube = {255, 0, 255, 100}


   -- img
   char = {}
   char.n = love.graphics.newImage("images/char_n.png")
   char.s = love.graphics.newImage("images/char_s.png")
   char.w = love.graphics.newImage("images/char_w.png")
   char.e = love.graphics.newImage("images/char_e.png")

   -- new player
   player = {
      grid_x = 256,
      grid_y = 256,
      act_x = 200,
      act_y = 200,
      face = "north",
      speed = 10
   }

   -- map
   -- 0 : empty
   -- 1 : non pushable block
   -- 2 : pushable, time variant block
   -- 3 : pushable, time invariant block
   map = {
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
   }

   map = {
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 0, 0, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 2, 0, 3, 2, 0, 2, 1, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 2, 0, 2, 1, 0, 0, 0, 0, 0, 1 },
    { 1, 2, 2, 2, 2, 2, 2, 1, 0, 0, 0, 0, 0, 1 },
    { 1, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
   }

   timeMachine = {}
end

function love.draw()
   --love.graphics.print("^_^", player.grid_x, player.grid_y)
   local txt_left = 500
   love.graphics.setColor(col_header)
   love.graphics.setNewFont(17)
   love.graphics.print(controls_header, txt_left, 50)

   love.graphics.setColor(col_txt)
   love.graphics.setNewFont(15)
   love.graphics.print(controls, txt_left, 70)

   love.graphics.setColor(col_header)
   love.graphics.setNewFont(17)
   love.graphics.print(story_header, txt_left, 160)

   love.graphics.setColor(col_txt)
   love.graphics.setNewFont(15)
   love.graphics.print(story, txt_left, 180)


   if player.face == "north" then
      love.graphics.draw(char.n, player.act_x, player.act_y)
   elseif player.face == "south" then
      love.graphics.draw(char.s, player.act_x, player.act_y)
   elseif player.face == "west" then
      love.graphics.draw(char.w, player.act_x, player.act_y)
   elseif player.face == "east" then
      love.graphics.draw(char.e, player.act_x, player.act_y)
   end

   for y=1, #map do
      for x=1, #map[y] do
         if map[y][x] == 1 then
            love.graphics.setColor(col_solid_cube)
            love.graphics.rectangle("line", x * 32, y * 32, 32, 32)
         end
         if map[y][x] == 2 then
            love.graphics.setColor(col_green_cube)
            love.graphics.rectangle("line", x * 32, y * 32, 32, 32)
         end
         if map[y][x] == 3 then
            love.graphics.setColor(col_blue_cube)
            love.graphics.rectangle("line", x * 32, y * 32, 32, 32)
            love.graphics.setColor(255,255,255)
         end
         if map[y][x] == 4 then
            love.graphics.setColor(col_home_cube)
            love.graphics.rectangle("fill", x * 32, y * 32, 32, 32)
         end
      end
   end

   if winflag then
      love.graphics.draw(winimage, 5, 5)
      love.graphics.setNewFont(40)
      love.graphics.setColor(col_txt)
      love.graphics.print("Grats! Here you have your cake.", 20, 500)
      love.graphics.setNewFont(15)
   end
end

function love.keypressed(key)
    if key == "w" then
       if testMap(0, -1) then 
          player.grid_y = player.grid_y - 32
          saveMove("north")
       end
       player.face = "north"
    elseif key == "up" then
       if testMap(0, -1) then 
          player.grid_y = player.grid_y - 32
          saveMove("north")
       end
       player.face = "north"
    elseif key == "s" then
       if testMap(0, 1) then 
        player.grid_y = player.grid_y + 32
        saveMove("south")
       end
       player.face = "south"
    elseif key == "down" then
       if testMap(0, 1) then 
        player.grid_y = player.grid_y + 32
        saveMove("south")
       end
       player.face = "south"
    elseif key == "a" then
       if testMap(-1, 0) then 
        player.grid_x = player.grid_x - 32
       saveMove("west")
       end
       player.face = "west"
    elseif key == "left" then
       if testMap(-1, 0) then 
        player.grid_x = player.grid_x - 32
       saveMove("west")
       end
       player.face = "west"
    elseif key == "d" then
       if testMap(1, 0) then 
        player.grid_x = player.grid_x + 32
       saveMove("east")
       end
       player.face = "east"
    elseif key == "right" then
       if testMap(1, 0) then 
        player.grid_x = player.grid_x + 32
       saveMove("east")
       end
       player.face = "east"
    elseif key == "p" then
       pushBlock()
    elseif key == "b" then
       rewindTime()
    elseif key == "r" then
       love.load()
       print("reloading...")
    end
end

function love.update(dt)
   player.act_y = player.act_y - ((player.act_y - player.grid_y) * player.speed * dt)
   player.act_x = player.act_x - ((player.act_x - player.grid_x) * player.speed * dt)
end

function love.focus(f) gameIsPaused = not f end

function pushBlock()
   if player.face == "north" then
      pushBlockNorth()
   elseif player.face == "south" then
      pushBlockSouth()
   elseif player.face == "west" then
      pushBlockWest()
   elseif player.face == "east" then
      pushBlockEast()
   end
end

function win()
   winflag = true
end

function pushBlockNorth()
   local block_x = player.grid_x / 32 
   local block_y = player.grid_y / 32 - 1
   if map[block_y][block_x] == 2 then
      --print("green block: " .. block_x .. " / " .. block_y)
      if map[block_y - 1][block_x] == 0 then
         if restoreBlue(block_y, block_x) then
         else
            map[block_y][block_x] = 0
         end
         map[block_y - 1][block_x] = 2
         saveMove("blockNorth")
      end
   elseif map[block_y][block_x] == 3 then
      if map[block_y - 1][block_x] == 0 then
         map[block_y][block_x] = 0
         map[block_y - 1][block_x] = 3
      elseif map[block_y - 1][block_x] == 4 then
         map[block_y][block_x] = 0
         map[block_y - 1][block_x] = 3
         win()
      end
   end
end

function pushBlockSouth()
   local block_x = player.grid_x / 32 
   local block_y = player.grid_y / 32 + 1
   if map[block_y][block_x] == 2 then
      if map[block_y + 1][block_x] == 0 then
         map[block_y][block_x] = 0
         map[block_y + 1][block_x] = 2
         saveMove("blockSouth")
      end
   end
   if map[block_y][block_x] == 3 then
      if map[block_y + 1][block_x] == 0 then
         map[block_y][block_x] = 0
         map[block_y + 1][block_x] = 3
      elseif map[block_y + 1][block_x] == 4 then
         map[block_y][block_x] = 0
         map[block_y + 1][block_x] = 3
         win()
      end
   end
end
function pushBlockWest()
   local block_x = player.grid_x / 32 - 1 
   local block_y = player.grid_y / 32
   if map[block_y][block_x] == 2 then
      if map[block_y][block_x - 1] == 0 then
         map[block_y][block_x] = 0
         map[block_y][block_x - 1] = 2
         saveMove("blockWest")
      end
   end
   if map[block_y][block_x] == 3 then
      if map[block_y][block_x - 1] == 0 then
         map[block_y][block_x] = 0
         map[block_y][block_x - 1] = 3
      elseif map[block_y][block_x - 1] == 4 then
         map[block_y][block_x] = 0
         map[block_y][block_x - 1] = 3
         win()
      end
   end
end
function pushBlockEast()
   local block_x = player.grid_x / 32 + 1 
   local block_y = player.grid_y / 32
   if map[block_y][block_x] == 2 then
      if map[block_y][block_x + 1] == 0 then
         map[block_y][block_x] = 0
         map[block_y][block_x + 1] = 2
         saveMove("blockEast")
      end
   end
   if map[block_y][block_x] == 3 then
      if map[block_y][block_x + 1] == 0 then
         map[block_y][block_x] = 0
         map[block_y][block_x + 1] = 3
      elseif map[block_y][block_x + 1] == 4 then
         map[block_y][block_x] = 0
         map[block_y][block_x + 1] = 3
         win()
      end
   end
end

function isBlueSaved()
   if savedblue then
      return "yes"
   else
      return "no"
   end
end

function restoreBlue(foreign_y, foreign_x)
   if savedblue then
      print("blue saved: " .. isBlueSaved())
      if isBlueSaved() == "yes" then
         print("blue coords: " .. bluecoords.x .. " / " .. bluecoords.y)
      end
      if foreign_y == bluecoords.y then
         if foreign_x == bluecoords.x then
            map[foreign_y][foreign_x] = 3
            savedblue = false
            return true
         end
      end
   end
   return false
end

function rewindBlockNorth()
   local x_free = player.grid_x / 32
   local y_free = (player.grid_y / 32) - 2
   local x_moved = player.grid_x / 32
   local y_moved = (player.grid_y / 32) - 1
   
   if savedblue then
      if x_free == bluecoords.x then
         if y_free == bluecoords.y then
            map[y_free][x_free] = 3
            savedblue = false
         end
      end
   else
      map[y_free][x_free] = 0
   end
   if map[y_moved][x_moved] == 3 then
      saveBlue(y_moved,x_moved)
   end
   map[y_moved][x_moved] = 2
end
function rewindBlockSouth()
   local x_free = player.grid_x / 32
   local y_free = (player.grid_y / 32) + 2
   local x_moved = player.grid_x / 32
   local y_moved = (player.grid_y / 32) + 1
   
   if savedblue then
      if x_free == bluecoords.x then
         if y_free == bluecoords.y then
            map[y_free][x_free] = 3
            savedblue = false
         end
      end
   else
      map[y_free][x_free] = 0
   end
   if map[y_moved][x_moved] == 3 then
      saveBlue(y_moved,x_moved)
   end
   map[y_moved][x_moved] = 2
end
function rewindBlockWest()
   local x_free = player.grid_x / 32 - 2
   local y_free = (player.grid_y / 32)
   local x_moved = player.grid_x / 32 - 1
   local y_moved = (player.grid_y / 32)
   
   if savedblue then
      if x_free == bluecoords.x then
         if y_free == bluecoords.y then
            map[y_free][x_free] = 3
            savedblue = false
         end
      end
   else
      map[y_free][x_free] = 0
   end
   if map[y_moved][x_moved] == 3 then
      saveBlue(y_moved,x_moved)
   end
   map[y_moved][x_moved] = 2
end
function rewindBlockEast()
   --print("rewind block east ->")
   local x_free = player.grid_x / 32 + 2
   local y_free = (player.grid_y / 32)
   local x_moved = player.grid_x / 32 + 1
   local y_moved = (player.grid_y / 32)
   --print ("check if blue on: " .. y_free .. "/" .. x_free)
   --print ("y/x moved: " .. y_moved .. "/" .. x_moved)
   if savedblue then
      if x_free == bluecoords.x then
         if y_free == bluecoords.y then
            print("setting blue")
            map[y_free][x_free] = 3
            savedblue = false
         end
      end
   else
      map[y_free][x_free] = 0
   end
   if map[y_moved][x_moved] == 3 then
      --print("saving blue to: " .. y_moved .. "/" .. x_moved)
      saveBlue(y_moved,x_moved)
   end
   map[y_moved][x_moved] = 2
   --print ("setting green: " .. y_moved .. "/" .. x_moved)
end

function saveBlue(y,x)
   savedblue = true
   bluecoords.x = x
   bluecoords.y = y
end

function testMap(x, y)
    if map[(player.grid_y / 32) + y][(player.grid_x / 32) + x] == 1 then
        return false
    end
    if map[(player.grid_y / 32) + y][(player.grid_x / 32) + x] == 2 then
        return false
    end
    if map[(player.grid_y / 32) + y][(player.grid_x / 32) + x] == 3 then
        return false
    end
    return true
end

function saveMove(direction) 
   timeMachine[#timeMachine+1] = direction
end

function saveMoveBlock(direction) 
   timeMachineBlocks[#timeMachineBlocks+1] = direction
end

function rewindTime()
   step = timeMachine[#timeMachine]
   timeMachine[#timeMachine] = nil
   if step == "north" then
      player.grid_y = player.grid_y + 32
      player.face = "north"
   elseif step == "south" then
      player.grid_y = player.grid_y - 32
      player.face = "south"
   elseif step == "west" then
      player.grid_x = player.grid_x + 32
      player.face = "west"
   elseif step == "east" then
      player.grid_x = player.grid_x - 32
      player.face = "east"
   elseif step == "blockNorth" then
      rewindBlockNorth()
   elseif step == "blockSouth" then
      rewindBlockSouth()
   elseif step == "blockWest" then
      rewindBlockWest()
   elseif step == "blockEast" then
      rewindBlockEast()
   end
end
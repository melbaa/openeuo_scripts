--[[
you can use this to get a leather piece with nice resists. edit at the bottom
]]
    
dofile('macros.lua')
dofile('types.lua')
dofile('FluentUO.lua')



FluentUO.Options("FindVisible", true)
FluentUO.Options("FindParents", true)

--[[
local nCnt = UO.ScanItems(true)
print(tostring(n)..'->'..tostring(nCnt))
for i = 1, nCnt do
  local nID = UO.GetItem(i)
  local sName,sInfo = UO.Property(nID)
  print(tostring(i)..': '..sName..' - '..sInfo)
  print('-----------')
end
]]

--[[
for k,v in pairs(itemprops) do
   for kk, vv in pairs(v) do
      print(k,kk,vv)
   end
end
]]


--[[
t = {a=1}
print(t.a)
t.a=nil -- delete entry by key
for k,v in pairs(t) do
   print(k,v)
end

]]


--[[
--local flowg = Backpack().WithType(8966).Items --flower garland
local flo = Backpack().WithName({'Flower Garland'}).Items
for i=1, #flo do
   print(flo[i].Col)
end

]]



local journalIgnorePrefix = 'info: '


local function cleanAssert(...)
  local pcode, acode, msg = pcall(assert, unpack(arg))
  if not pcode then
    error(acode, 0)
  else
    return acode, msg
  end      
end

local function waitForTarg(timeout) --in millisec
  local maxtime = getticks() + timeout
  while not UO.TargCurs do
    if getticks() > maxtime then --timed out
      return false
    end
  end
  return true
end
             
local function target(id, timeout)
  local oldcursor = UO.TargCurs
  local oldltargetkind = UO.LTargetKind
  local oldltargetid = UO.LTargetID
  --UO.TargCurs = false
  cleanAssert(waitForTarg(timeout), 'cursor timed out')
  UO.LTargetKind = 1
  UO.LTargetID = id
  Macros.LastTarget()
  UO.TargCurs = oldcursor
  UO.LTargetKind = oldltargetkind
  UO.LTargetID = oldltargetid  
  
end

local function uoprint(msg)
  UO.SysMessage(journalIgnorePrefix .. tostring(msg))
  wait(500)
end

local function print_table(t)
  for k,v in pairs(t) do
    print('key: ' .. k)
    if type(v) == 'table' then
      print('start of value table')
      print_table(v)
      print('end of value table')
    else
      print('value: ' .. tostring(v))
    end
  end
end

while true do

   local scissors = Backpack().WithType(types.items.scissors).Items
   if #scissors == 0 then
      uoprint('fuck you give me scissors')
   end

   if #scissors ~= 0 then
     local sleeves = Backpack().WithName({'Barbed Leather Sleeves'}).Items
     for i=1, #sleeves do
        local props = FluentUO.GetProperty(sleeves[i])
        print(props.Name)
        --print_table(props.Resists)
        if props.Resists.Cold == 5 and props.Resists.Poison == 6 and props.Resists.Energy <= 10 then
           uoprint('omg got sleeves')
        else
           uoprint('cut ' ..  props.Resists.Cold .. ' ' ..  props.Resists.Poison)
           scissors[1].Use()
           local success, msg = pcall(target, sleeves[i].ID, 1000)
        end
     end
   end

   wait(600)
end
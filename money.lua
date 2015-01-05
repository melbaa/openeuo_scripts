--[[ 
  
  TODO fix looter to pick stuff up only while capslock is down
  if key is released corpse should be reinspected if pressed again 
  maybe use toggle nistead? 
  
  TODO EVAL INTENSITY AND TAKE RELATIVELY GOOD ITEMS (relics) FOR IMUBING 
  with relatively high weight  
  http://www.uoguide.com/Imbuing_Property_Weights
  do this during looting
  have an argument to tell what intensity is good so you can set it to pick up lamer items too
  
  TODO if stamina < some limit (for example where swing speed become >1s) cast divine fury
  for example when stam is <30
  
  TODO if no weapon/shield in hand (probably disarmed or casted a spell) try rearm
  
  TODO notify if an armor slot is unequipped
  
  TODO notify when reflect, reactive, protect, vamp form not casted
  
  TODO doom bone cutter try to be nonintrusive with targeting. 
  how to stay alive. bones damage. df damage. blood oath.
    
  TODO notify when prot.reactive.magic refl. vamp not on

  TODO notify when cursed in doom, they drop you like 30 in each stat
  
  disarm or somehow stop attacking (togglewarpeace twice?) when blood oathed by df in doom
  
  TODO notify when using wrong slayer against certain mobs (mostly doom)
  
  TODO scream more often when gear is relly low on dur
    
  TODO auto accept party? from whitelist only?
  
  TODO remember when you die and spam current coords and target coords. 
  when does it stop?  when corpse expires
  
  TODO provo script
  
  todo coins for joke script
    find where the accept button is 
    how to check if its gold and >= 100
    http://www.easyuo.com/forum/viewtopic.php?f=3&t=5342&start=0
    
  TODO code that switches slayer weps based on target ;/ what if opposing slayer mob is hereee

  drag gold to safe if safe not full. get safes IDS on start of script, beacuse they
    probably nott changing. drag gold on safe every few mins?
    drag and click? uo.contname = drag gump while holding something

]]

dofile('macros.lua')
dofile('types.lua')
dofile('FluentUO.lua')

FluentUO.Options("FindVisible", true)
FluentUO.Options("FindParents", true)
FluentUO.Options("ActionDelay", 700)         --when using and moving stuff


local lootFrom = {
  types.containers.corpse,
  types.containers.bones,
  types.containers.bones2,
  types.containers.ratman,  
}



local lootThis = {
  types.items.gold,
  types.items.daemonbone,
  --types.items.arrows,
  --types.items.bolts,
  types.items.aids,
  --types.items.pots.refresh,
  --types.items.pots.agility,
  --types.items.pots.strength,
  --types.items.pots.heal,
  --types.items.pots.empty,
  types.items.scrolls.bronzeskill,
  types.items.quest.pinkfeather ,
  types.items.farming.cottonbale ,
  types.items.farming.flaxbundle,
  types.items.farming.flaxbundle2,
  types.items.quest.zoogi,
}

for k,v in pairs(types.items.gems) do
   --table.insert(lootThis, v)
end

for k,v in pairs(types.items.reagents) do
   --table.insert(lootThis, v)
end

for k,v in pairs(types.items.rawfood) do
   --table.insert(lootThis, v)
end

for k,v in pairs(types.items.clothes) do
   --table.insert(lootThis, v)
end

local ignoreCorpses = {}
local ignoredItems = {}
local itemIdIgnoredTypes = {
8007, 8033, 8021, 3978, 3983, 3982, 3960, 3965, 8010, 8810, 8034, 8023, 8006, 8015, 8017, 4039, 8012, 8025, 8030, 8809, 8013, 3973, 8026, 8031, 8022, 8009, 8018, 3972
  } --things that can't be unravelled, like reagents

local shouldloot = false
local goldonly = true 

local lastmoveinfo = {
  lastx = UO.CharPosX,
  lasty = UO.CharPosY,
  lastz = UO.CharPosZ,
  lastmoveticks = getticks(),
  ticksneeded = 1000, --time without moving needed before looting
}

local hasBandSelf = true -- shard support [bandself ?. will use targeting if not

local dur_state = {
  lasttime = getticks(),
  regularticksneeded = 30000,
  alertticksneeded = 3000,
  mindur = 20,      --alert when less than or eq to this dur
}


--put the char stats without pots 
local CHARMAXDEX = 164 --for agil pots
local CHARMAXSTR = 180 -- for str pots

local dagger = Backpack().WithType(types.items.weapons.dagger).Items

local journalIgnorePrefix = 'info: '

local function uoprint(msg)
  UO.SysMessage(journalIgnorePrefix .. tostring(msg))
  wait(500)
end

local function uoexmsg(id, msg)
  local newmsg = journalIgnorePrefix .. tostring(msg) 
  --print(newmsg, msg)
  UO.ExMsg(id, newmsg)
end

local function uomsg(msg)
  UO.Msg(msg)
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

local function unpackTable(t)
  local list = {}
  for k,v in pairs(t) do
    table.insert(list, v)
  end
  return unpack(list)
end

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

local function moved()
   --print(lastmoveinfo.lastx, lastmoveinfo.lasty, lastmoveinfo.lastz)
   if lastmoveinfo.lastx ~= UO.CharPosX
   or lastmoveinfo.lasty ~= UO.CharPosY
   or lastmoveinfo.lastz ~= UO.CharPosZ 
   then
      lastmoveinfo = {
        lastx = UO.CharPosX,
        lasty = UO.CharPosY,
        lastz = UO.CharPosZ,
        lastmoveticks = getticks(),
        ticksneeded = lastmoveinfo.ticksneeded
      }

      return true
   end
   
   if lastmoveinfo.lastmoveticks + lastmoveinfo.ticksneeded >= getticks() then
     --we have moved too soon so return true, meaning we have moved
     return true
   end
   
   return false
end

local function evalItem(item)       
  --[[
  earrings  348
  plate 629
  
  items with 4 high properties or above are relics
  
  another way is to use item id to eval. slowest but future proof and doesn't need 
  item lists and properties lists updated
  
  view source of http://www.knuckleheads.dk/imbuecalc.php?itemtype=armor
  https://github.com/luaforge/json/blob/master/json4lua/json/json.lua
  itemprops.lua generated by genluaprops.py
  also cleaneditems.txt 
  
  nonarti items:
  weapons say so in their props 1h 2h for melee and range for ranged
  jewels dont have durability. int bonus, fcr 
  shields have spell channeling and hci, dci and faster casting
  subtract like 15 resist from all armor pieces
  artifacts say so in their props
  
  http://uo2.stratics.com/items/magic-effects-table
  ]]
  local proptbl = FluentUO.GetProperty(item)
  
end

local function takeItems(items)
  --return success==true if we manage to complete the whole loop without moving or turning off looting

  for i=1, #items do
    --uoprint("STARTING TO LOOT")
    --wait(1500) -- le euo fastlooter detection for ipy lol

  --[[
    uoprint('x= ' .. items[i].X)
    uoprint('Y= ' .. items[i].Y)
    uoprint('distx =' .. (UO.CharPosX - items[i].X))
    uoprint('disty =' .. (UO.CharPosY - items[i].Y))
    uoprint('fluentuo dist = ' .. items[i].Dist)
    uoprint('kind = ' .. items[i].Kind)
    uoprint('contid = ' .. items[i].ContID)
    --uoprint('rootaprent = ' .. items[i].RootParent)
     ]]

    if moved() then
      uoprint('omg moved while looting. risked a crash.')
      return false
    end
   
    if items[i].Kind == 1
    and items[i].Dist > 2 then
      uoexmsg(items[i].ID, "Loot me!")
    elseif items[i].Kind == 0
    and items[i].Parent.Dist > 2 then
      uoexmsg(items[i].Parent.ID, "Loot me!")
    elseif items[i].Kind == 1 -- on ground
    and items[i].Dist <= 2 then --THE WORLD IS MINE
      items[i].Drag() 
      UO.DropC(UO.BackpackID)
      uoprint("looted some shit")
    elseif items[i].Kind == 0
    and items[i].Parent.Dist <= 2 then
      items[i].Drag() 
      UO.DropC(UO.BackpackID)
      uoprint("looted some shit")
    end      
  end
  return true
end

local function takeItem(item) 
    if moved() then
      uoprint('omg moved while looting. risked a crash.')
      return false
    end
   
    if item.Kind == 1
    and item.Dist > 2 then
      uoexmsg(item.ID, "Loot me!")
      return false
    elseif item.Kind == 0
    and item.Parent.Dist > 2 then
      uoexmsg(item.Parent.ID, "Loot me!")
      return false
    elseif item.Kind == 1 -- on ground
    and item.Dist <= 2 then --THE WORLD IS MINE
      item.Drag() 
      UO.DropC(UO.BackpackID)
      uoprint("looted some shit")
    elseif item.Kind == 0
    and item.Parent.Dist <= 2 then
      item.Drag() 
      UO.DropC(UO.BackpackID)
      uoprint("looted some shit")
    end
    return true   
end


local function loot()

  --[[ we can crash when
  we move
  item disappears (someone else grabs it)
  second drag?/drop before first is finished (second drag before first drop i think)
  invisible item
  corpse decays
  out of range
  too fast looting. servers have delays between loots/drags/drops
  
  a cool idea is to loot only when mouse in game screen? or some other pos 
    or check if char moved last 3 sec
    or a toggle looting hotkey on/off
  ]]

  if getkey("CAPS") then
    shouldloot = not shouldloot
    if shouldloot then
      uoprint("Looting ON")
    else
      uoprint("Looting OFF")
    end
  end
  
  if not shouldloot then
    return
  end

  if moved() then
    --uoprint("STOP so i can loot")
    return
  end
  
  
  
  local corpses = Ground().InRange(2).WithType(unpack(lootFrom)).Items
  --print(#corpses)
  
  --check if we already looted this corpse
  for i=1, #corpses do
    local legit = true
    for j, ignored in ipairs(ignoreCorpses) do
      if corpses[i].ID == ignored then
        legit = false
      end
    end
    if legit then 
    
      if moved() then
        uoprint('omg moved while looting. risked a crash')
        return
      end
      
      print('currently looting ' .. corpses[i].ID)
      corpses[i].Use()
      local oldcontainer = UO.ContID
      local start = getticks()
      while oldcontainer == UO.ContID 
      and start + 2000 > getticks() 
      do
        --print(getticks())
        wait(100)
      end
      -- might want to check for timeout later. couldn't open corpse?
      
      --cut corpse
      --[[
      local cutwith = Backpack().WithType(types.items.weapons.dagger).Items
      if #cutwith == 0 then
        cutwith = Backpack().WithType(types.items.weapons.scimitar).Items
      end
      if #cutwith == 0 then
        cutwith = Backpack().WithType(types.items.weapons.katana).Items
      end
      if #cutwith > 0 then
        cutwith[1].Use()
        local success, msg = pcall(target, corpses[i].ID, 1000)
        wait(500) -- hope that we'll see the meat in the scan following
      end 
      ]]     
      
      local currentContainer = UO.ContID
      if currentContainer ~= UO.BackpackID then
        local items = World().InContainer(currentContainer).WithType(unpack(lootThis)).Items
        local success = takeItems(items)
        if success and currentContainer == UO.ContID then 
          --we finished looting successfully, because the container we started looting from is still on top
          table.insert(ignoreCorpses, currentContainer)
          --UO.HideItem(currentContainer)
          --print("number of corpses" .. table.getn(ignoreCorpses))
        end
      end
      uoprint('done looting')
    end
  end 
  
  --loot ground, but it's better to use razor scavanger probably
  --[[
  local items = Ground().InRange(3).WithType(unpack(lootThis)).Items
  takeItems(items)
  ]]
  
end

        
local function itemid(item)
  Macros.UseSkillItemIdentification()
  wait(300)
  local success, msg = pcall(target, item.ID, 1000)
  while not success do
    Macros.UseSkillItemIdentification()
    wait(300)
    success, msg = pcall(target, item.ID, 1000)
  end
end

local function itemIgnored(item) 
  for i=1, #ignoredItems do
     if item.ID == ignoredItems[i] then
        return true
     end
  end
  
  for i=1, #itemIdIgnoredTypes do
     if item.Type == itemIdIgnoredTypes[i] then
       return true
     end
  end
  return false
end

local function shouldLoot(item)
  for i=1, #lootThis do
     if item.Type == lootThis[i] then
       return true
     end 
  end

  return false
end

local function id_from_corpse(shouldId, itemEvaluated, goldonly)
      --[[ we can crash when
  we move
  item disappears (someone else grabs it)
  second drag?/drop before first is finished (second drag before first drop i think)
  invisible item
  corpse decays
  out of range
  too fast looting. servers have delays between loots/drags/drops
  
  a cool idea is to loot only when mouse in game screen? or some other pos 
    or check if char moved last 3 sec
    or a toggle looting hotkey on/off
    
  try to id 1 item from a corpse that's not ignored.
  id only if we should. we should when no previous id is pending.
  this happens when we just started script or looted an item
  looting is done by a separate function
  
  
  ]]

  if getkey("CAPS") then
    shouldloot = not shouldloot
    if shouldloot then
      uoprint("Looting ON")
    else
      uoprint("Looting OFF")
      shouldId = true
      itemEvaluated = nil
    end
  end
  
  if not shouldloot then
    return shouldId, itemEvaluated
  end
  
  if not shouldId then
    return shouldId, itemEvaluated
  end
  
  if itemEvaluated ~= nil then
    return shouldId, itemEvaluated --shouldn't really need this
  end

  if moved() then
    --uoprint("STOP so i can loot")
    return shouldId, itemEvaluated
  end
  
  
  
  local corpses = Ground().InRange(2).WithType(unpack(lootFrom)).Items
  --print(#corpses)
  
  --check if we already looted this corpse
  for i=1, #corpses do
    local legit = true
    for j, ignored in ipairs(ignoreCorpses) do
      if corpses[i].ID == ignored then
        legit = false
      end
    end
    if legit then 
    
      if moved() then
        uoprint('omg moved while looting. risked a crash')
        return shouldId, itemEvaluated
      end
      
      print('currently looting ' .. corpses[i].ID)
      corpses[i].Use()
      local oldcontainer = UO.ContID
      local start = getticks()
      while oldcontainer == UO.ContID 
      and start + 2000 > getticks() 
      do
        --print(getticks())
        wait(100)
      end
      -- might want to check for timeout later. couldn't open corpse?
      
      --cut corpse
      --[[
      local cutwith = Backpack().WithType(types.items.weapons.dagger).Items
      if #cutwith == 0 then
        cutwith = Backpack().WithType(types.items.weapons.scimitar).Items
      end
      if #cutwith == 0 then
        cutwith = Backpack().WithType(types.items.weapons.katana).Items
      end
      if #cutwith > 0 then
        cutwith[1].Use()
        local success, msg = pcall(target, corpses[i].ID, 1000)
        wait(500) -- hope that we'll see the meat in the scan following
      end 
      ]]     
      
      local currentContainer = UO.ContID
      if currentContainer ~= UO.BackpackID then
        local items = World().InContainer(currentContainer).Items
        
        for j=1, #items do --for each item in corpse
        
           if shouldLoot(items[j]) then
             takeItem(items[j])
             return shouldId, itemEvaluated
           end
        
           if not itemIgnored(items[j]) and not goldonly then
              itemid(items[j])
              shouldId = false
              itemEvaluated = items[j]
              return shouldId, itemEvaluated
           end 
        end
        
        --ignore corpse and clear item ignore list
        table.insert(ignoreCorpses, currentContainer)
        ignoredItems = {}
      end
      uoprint('done id or loot 1 item')
      return shouldId, itemEvaluated   --just one corpse
    end
    
  end 
  
  --loot ground, but it's better to use razor scavanger probably
  --[[
  local items = Ground().InRange(3).WithType(unpack(lootThis)).Items
  takeItems(items)
  ]]
  
  return shouldId
end

local function ignoreItem(item)
  table.insert(ignoredItems, item.ID)
end

local function loot_one_item(shouldId, lastjnl, itemEvaluated)
  --print(lastjnl)
  --[[
    another function used itemid on an item. the journal now contains the result
    but maybe we failed to target something. how to handle that? 

    
    What do you wish to appraise and identify?
    melba: You conclude that item cannot be magically unraveled.
    melba: You conclude that item cannot be magically unraveled. It appears to possess little to no magic.
    melba: Your Imbuing skill is not high enough to identify the imbuing ingredient.
    melba: You conclude that item will magically unravel into: Enchanted Essence
    melba: You conclude that item will magically unravel into: Magical Residue
  ]]
  
  
  local results = {
    UO.CharName .. ": You conclude that item cannot be magically unraveled.",
    UO.CharName .. ": You conclude that item cannot be magically unraveled. It appears to possess little to no magic.",
    UO.CharName .. ": Your Imbuing skill is not high enough to identify the imbuing ingredient.",
    UO.CharName .. ": You conclude that item will magically unravel into: Enchanted Essence",
    UO.CharName .. ": You conclude that item will magically unravel into: Magical Residue",
  }
  

  if shouldId == true then
     return shouldId   --no pending itemid we care about, nothing changed
  end
 
  for i,val in ipairs(results) do
    if lastjnl == val then
       shouldId = true
       
       
       
       if lastjnl:find("not high enough") or lastjnl:find("Relic") 
       --or lastjnl:find("Residue") or lastjnl:find("Essence")
       then
         local successs = takeItem(itemEvaluated)
       else
         ignoreItem(itemEvaluated)

       end
       
       if lastjnl:find("cannot be magically") and lastjnl:find("little to no") then
       elseif lastjnl:find("cannot be magically") then
          table.insert(itemIdIgnoredTypes, itemEvaluated.Type)
          
          local s = ''
          for i=1, #itemIdIgnoredTypes do
            s = s .. ', ' .. tostring(itemIdIgnoredTypes[i])
          end
          print(s)
       end  
       
       itemEvaluated = nil
    end
    
      
    
  end
  
  return shouldId, itemEvaluated
end

local function getrgb(color)
  local b = math.floor(color % 256)
  local g = math.floor(color / 256 % 256)
  local r = math.floor(color / 256 / 256 % 256)
  return r,g,b
end

local function drinkNightsight()
  if not string.find(UO.CharStatus, "G") then --continue only when in warmode 
    return
  end

  local coords = { 
    {206, 43},
    {95, 110},
    {777, 117},
    {582, 117},
  }
  local black = 0
  for i, coord in pairs(coords) do
      local x, y = unpack(coord)
      local color = UO.GetPix(x,y)
      --print(getrgb(color))
      local r,g,b = getrgb(color)
      for i,v in ipairs{r,g,b} do
        if v < 30 then --if black
          black = black + 1
        end
      end     
  end
  if black >= 6 then
    local nspots = Backpack().WithType(types.items.pots.nightsight).Items
    if #nspots > 0 then
      nspots[1].Use()
    else
      uoprint("restock nightsight potions")
    end
  end
end

local function poisoned()
  local result = not not string.find(UO.CharStatus, "C")
  --print(result)
  return result
end

local function hidden()
  local result = not not string.find(UO.CharStatus, "H")
  return result
end
  

local function drinkCure()
  --cure message 'You feel cured of poison!'
  
  local curepots = Backpack().WithType(types.items.pots.cure).Items
  if #curepots < 3 then
    uoprint("Restock cure pots")
  elseif poisoned() and #curepots > 0 then
    curepots[1].Use()
  end
end


local function drinkRefresh()
  local refreshpots = Backpack().WithType(types.items.pots.refresh).Items
  if UO.Stamina < UO.MaxStam - 20 and #refreshpots > 0 then
    refreshpots[1].Use()
  elseif #refreshpots < 3 then
    uoprint("Restock refresh pots")
  end
end

local function drinkAgility()
  if string.find(UO.CharStatus, "G")
  and UO.Dex<= CHARMAXDEX then --warmode
    local agilpots = Backpack().WithType(types.items.pots.agility).Items
    if #agilpots > 0 then
      agilpots[1].Use()
    end
  end
end

local function drinkStrength()
  if string.find(UO.CharStatus, "G")
  and UO.Str <= CHARMAXSTR then
    local strpots = Backpack().WithType(types.items.pots.strength).Items
    if #strpots > 0 then
      strpots[1].Use()
    end
  end
end

         
local function drinkHeal()
  local HEAL_AMOUNT = 32
  if UO.Hits <= UO.MaxHits - HEAL_AMOUNT then
    local healpots = Backpack().WithType(types.items.pots.heal).Items
    if #healpots < 1 then
      uoprint("restock heal pots")
      return
    end
    healpots[1].Use()
  end
end




local function bandageSelf()
  local oldcursor = UO.TargCurs
  local oldltargetkind = UO.LTargetKind
  local oldltargetid = UO.LTargetID
  local aids = Backpack().WithType(types.items.aids).Items
  cleanAssert(#aids > 0, "no aids")
  aids[1].Use()
  cleanAssert(waitForTarg(1000), 'cursor timeout')
  UO.LTargetKind = 1
  UO.LTargetID = UO.CharID
  Macros.LastTarget()
  UO.TargCurs = oldcursor
  UO.LTargetKind = oldltargetkind
  UO.LTargetID = oldltargetid
end

local function applyAids(heal, lastjnl)
  --this function supports [bandageself and targeting if required. cofigured via hasBandageSelf

  local beginheal = {
    'You begin applying the bandages.',
  }
    
  local endheal = {
    'You have failed to cure your target!',
    'You were unable to finish your work before you died.',
    'You did not stay close enough to heal your target.',
    'You are able to resurrect your patient.',
    'Target can not be resurrected at that location.',
    'The veil of death in this area is too strong and resists thy efforts to restore life.',
    'You are unable to resurrect your patient.',
    'You finish applying the bandages.',
    'You have cured the target of all poisons.',
    'You have been cured of all poisons.',
    'Thou can not be resurrected there!',
    'You bind the wound and stop the bleeding.',
    'The bleeding wounds have healed, you are no longer bleeding!',
    'You heal what little damage your patient had.',
    'You apply the bandages, but they barely help.',
    'You are able to resurrect the creature.',
    'You fail to resurrect the creature.',
  }
  
  --print(heal.state, heal.time, lastjnl)
  --print()
  --print()
  
  local nNorm, nReal, nCap, nLock = UO.GetSkill("Heal")
  if nReal < 200 then
    return --no healing, dont do anything
  end 
  
  for i,msg in ipairs(beginheal) do
    if lastjnl == msg then
      heal.state = 'healing'
      heal.time = getticks()
      return 
    end
  end
  
  for i,msg in ipairs(endheal) do
    if lastjnl == msg then
      heal.state = 'idle'
      --print(getticks() - heal.time)   --print how long it takes to heal
      return 
    end
  end  
  
   
  if heal.state == 'healing'
  and UO.Hits == UO.MaxHits
  and not poisoned() then
    heal.state = 'idle'
    return 
  end
 
 
  local maxHealTime = 20 --seconds 
  if heal.state == 'healing'
  and ((getticks() - heal.time) / 1000) > maxHealTime then
    heal.state = 'idle'
    return 
  end
 
  
  if heal.state == 'idle'
  and not hidden()
  and (UO.Hits < UO.MaxHits - 10
       or poisoned()) then
       
    if hasBandSelf == true then
      Macros.Say("[bandageself")
    else --use trageting   
      local success, msg = pcall(bandageSelf)
      if not success then
        uoprint(msg)
        return 
      end
    end
    heal.state = 'healing'
    heal.time = getticks()
    return 
  end
  return  
end   

local function applyPoison(lastjnl)
  if lastjnl == 'Select the poison you wish to use.' then
    local pots = Backpack().WithType(types.items.pots.poison).Items
    if #pots < 1 then
      uoprint("restock poison pots")
      return
    end
    local success, msg = pcall(target, pots[1].ID, 1000)
    if not success then
      uoprint(msg)
      return
    end
    
    local weps = Backpack().WithType(types.items.weapons.dagger).Items
    if #weps < 1 then
      weps = Equipment().WithType(types.items.weapons.cutlass).Items
    end
    if #weps < 1 then
      weps = Backpack().WithType(types.items.weapons.scimitar).Items
    end
    if #weps < 1 then
      uoprint("no weapon found")
      return
    end
    local success, msg = pcall(target, weps[1].ID, 1000)
    if not success then
      uoprint(msg)
      return
    end
  end   
end

local function openDoors()
  local doors = Ground().WithType(unpackTable(types.doors)).Items
  for i=1, #doors do
    if doors[i].Dist < 3 then
       Macros.OpenDoor()
    end
  end
end

local function spiritSpeak()
  if UO.Hits <= UO.MaxHits * 0.5 then
    Macros.UseSkillSpiritSpeak()
  end
end

local function cleansingWinds()
  if UO.Hits <= 50 then
    Macros.CastSpellGreaterHeal()
  else
  
    Macros.CastSpellNetherCyclone()
  end
 -- local success, msg = pcall(cleanAssert,waitForTarg(1000))

  --print('start')
  local swordsid = World().InRange(10).WithName({'A Swordsman'}).Items[1].ID
  --print('stop')
  local success, msg = pcall(target,   swordsid, 3000)
  
  if not success then
    print(msg)
  end
  wait(2000)

end

local function autoattackgrays()
  local grays = World().InRange(2).Items
  
            --[[  
1 	Innocent (Blue)
2 	Friend (Green)
3 	Grey (Grey - Animal)
4 	Criminal (Grey)
5 	Enemy (Orange)
6 	Murderer (Red)
7 	Invulnerable (Yellow)
]] 
  
  uoprint(#grays)
  for i=1, #grays do
    uoprint(grays[i].Rep)
    if ((grays[i].Rep == 4 or grays[i].Rep == 3)) then
      UO.LTargetKind = 1
      UO.LTargetID = grays[i].ID
      --Macros.AttackLast()
      Macros.AttackLast()

    end
    
    if (UO.EnemyID ~= 0) then
      --UO.Pathfind(grays[i].X, grays[i].Y, grays[i].Z)
      --UO.Move(grays[i].X, grays[i].Y, 2, 5)
    end
  end
end

local function checkDurability(dur_state)
  --[[
  notify of broken gear and noninsured doom arties in backpack
  ]]

  local lasttime = dur_state.lasttime
  local currtime = getticks()
  if dur_state.lasttime + dur_state.regularticksneeded >= currtime then
    return
  end
  dur_state.lasttime = currtime
  
  local eq = Equipment().Items
  for i=1, #eq do
    local proptbl = FluentUO.GetProperty(eq[i])
    --print("item ID " .. eq[i].ID)
    --print_table(proptbl)
    --[[
      i found a bug in openeuo, an item with a long prop list had the max dur truncated
      so needed the workaround below. 
      the min dur. is retrieved and its what we care about really
    ]]
    local itemmindur = nil
    if proptbl ~= nil 
    and proptbl.Durability ~= nil then
      if type(proptbl.Durability) == 'number' then
        itemmindur = proptbl.Durability
      else
        itemmindur = proptbl.Durability.Min
      end 
    end
    if itemmindur ~= nil 
    and itemmindur <= dur_state.mindur then
      uoprint(eq[i].Name .. ' durability is ' .. itemmindur)
      
    end
    
  end
  
  local want_arti = Backpack().Items
  for i=1, #want_arti do
    local props = FluentUO.GetProperty(want_arti[i])
    if props['Artifact Rarity'] ~= nil and props['Insured'] == nil then
       uoprint('omg got arti ' .. want_arti[i].Name) 
    end 
  
  end
  
end

local function goldsafewithdraw(lastjnl)
   if lastjnl:find("Enter the amount of gold you wish to withdraw") == nil then
     return
   end
   uomsg("15000\n")
end

   
local function cutbones() 
--[[
  bones  = {
  "MNF","QNF","PNF","KNF","JNF","LNF","YNF","VNF",  
  "JNF","KNF","LNF","MNF","NNF","ONF","QNF","WNF",
  "LNF","QNF","WNF","PNF","KNF","MNF","JNF","YNF","VNF","GUF"
  }
  for i,v in ipairs(bones) do
    print(FluentUO.Utils.ToOpenEUO(v) .. ',')
  end
]]

  if UO.Hits <= 0.6*UO.MaxHits then   --because destroying a pile does dmg i think
     return
  end  
  
  if #dagger == 0 then
    uoprint("warning: no dagger. can't cut bones")
    return
  end
  

  --can cut across screen really
  local bones = Ground().InRange(10).WithType(unpack(types.doombones)).Items
  for i=1, #bones do
    if bones[i].Name == 'Unholy Bones' then
      dagger[1].Use()
      local success, msg = pcall(target, bones[i].ID, 500)
      --uoprint('cut bones')  --theres a sysmsg anyway
      --uoexmsg(bones[i].ID, "what am i?")
    end
  end
end


local function heartwoodquestitems()
  --[[write the quest item names and click toggle quest item on yourself.
    this function will mark all found uncololred items
  ]]
  local flo = Backpack().WithName({'Flower Garland', 'Fancy Shirt', 'Kilt'}).Items
  for i=1, #flo do
     if flo[i].Col == 0 then
       local success, msg = pcall(target, flo[i].ID, 1000)
     end
  end
end 

--init healing
local heal = {}
heal.state = 'idle' -- idle or healing
heal.time = getticks()

--init journal
local journal = {}
journal.refState = 0
journal.numLines = 0
journal.refState, journal.numLines =  UO.ScanJournal(journal.refState) -- init
journal.refState, journal.numLines =  UO.ScanJournal(journal.refState) -- go to end
journal.lastLine = ""
journal.lastLineColor = 0




--[[
  ok tva det iskame e neshto da preglejda items 1 po 1
  purvo trea namerime items za loot ot nekuv trup
  posle za vseki se cuka item id,
  chete se paperdoll
  ako e relic se lootva
  trea da ne se scanva trupa vseki put a da se pazi state do kude sme i da se dava na 
    sledvashtite callbacks
]]


local shouldId = true
local itemEvaluated = nil

while true do
  --print("shouldId " .. tostring(shouldId))
  
  if UO.CharName ~= 'melba' and UO.CliCnt == 2 then
    UO.CliNr = UO.CliNr + 1
    if UO.CliNr > UO.CliCnt then
      UO.CliNr = 1
    end
    
    --print(UO.CharName, UO.CliNr)
    
  end

  local hr, min = gettime()
  local timestamp = "[" .. hr .. ":" .. min .. "] "
  for i=journal.numLines-1, 0, -1 do
    journal.lastLine, journal.lastLineColor = UO.GetJournal(i)
    local success, esuccess, capture = string.find(journal.lastLine, "^info: (.+)")
    if not success then --we have a message we care about
      
      print(timestamp .. journal.lastLine)
      applyAids(heal, journal.lastLine)
      --applyPoison(journal.lastLine)
      goldsafewithdraw(journal.lastLine)
      shouldId, itemEvaluated = loot_one_item(shouldId, journal.lastLine, itemEvaluated)
    end
  end
  applyAids(heal, "") --in case journal wasn't updated, but other state changed
  journal.refState, journal.numLines =  UO.ScanJournal(journal.refState)
  
  shouldId, itemEvaluated = id_from_corpse(shouldId, itemEvaluated, goldonly)
  checkDurability(dur_state)
  
  cutbones()
  
  --heartwoodquestitems()
  
  
  --openDoors()
  --spiritSpeak() --might kill you so mostly useful for macro
  --drinkHeal()
  --drinkStrength()
  drinkAgility()
  --drinkRefresh()
  --drinkCure()
  --drinkNightsight()
  --autoattackgrays()
  
  --  cleansingWinds()

  
  
  
  wait(200)
end
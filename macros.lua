


-- http://www.easyuo.com/openeuo/wiki/index.php/UO.Macro#Mysticism

Macros = {  
  Say = function(text) UO.Macro(1,0,text) end,  
  Emote = function(text) UO.Macro(2,0,text) end,  
  Whisper = function(text) UO.Macro(3,0,text) end,  
  Yell = function(text) UO.Macro(4,4,text) end,  
  Walk = function(direction) UO.Macro(5,direction,'') end,  
  WalkNorthWest = function() UO.Macro(5,0,'') end,  
  WalkNorth = function() UO.Macro(5,1,'') end,  
  WalkNorthEast = function() UO.Macro(5,2,'') end,  
  WalkEast = function() UO.Macro(5,3,'') end,  
  WalkSouthEast = function() UO.Macro(5,4,'') end,  
  WalkSouth = function() UO.Macro(5,5,'') end,  
  WalkSouthWest = function() UO.Macro(5,6,'') end,  
  WalkWest = function() UO.Macro(5,7,'') end,  
  ToggleWarPeace = function() UO.Macro(6,0,'') end,  
  Paste = function() UO.Macro(7,0,'') end,  
  OpenConfiguration = function() UO.Macro(8,0,'') end,  
  OpenPaperdoll = function() UO.Macro(8,1,'') end,  
  OpenStatus = function() UO.Macro(8,2,'') end,  
  OpenJournal = function() UO.Macro(8,3,'') end,  
  OpenSkills = function() UO.Macro(8,4,'') end,  
  OpenSpellbook = function() UO.Macro(8,5,'') end,  
  OpenChat = function() UO.Macro(8,6,'') end,  
  OpenBackpack = function() UO.Macro(8,7,'') end,  
  OpenOverview = function() UO.Macro(8,8,'') end,  
  OpenMail = function() UO.Macro(8,9,'') end,  
  OpenPartyManifest = function() UO.Macro(8,10,'') end,  
  OpenPartyChat = function() UO.Macro(8,11,'') end,  
  OpenNecroSpellbook = function() UO.Macro(8,12,'') end,  
  OpenPaladinSpellbook = function() UO.Macro(8,13,'') end,  
  OpenCombatBook = function() UO.Macro(8,14,'') end,  
  OpenBushidoSpellbook = function() UO.Macro(8,15,'') end,  
  OpenNinjitsuSpellbook = function() UO.Macro(8,16,'') end,  
  OpenGuild = function() UO.Macro(8,17,'') end,  
  OpenSpellweavingSpellbook = function() UO.Macro(8,18,'') end,  
  OpenQuestLog = function() UO.Macro(8,19,'') end,  
  CloseConfiguration = function() UO.Macro(9,0,'') end,  
  ClosePaperdoll = function() UO.Macro(9,1,'') end,  
  CloseStatus = function() UO.Macro(9,2,'') end,  
  CloseJournal = function() UO.Macro(8,3,'') end,  
  CloseSkills = function() UO.Macro(9,4,'') end,  
  CloseSpellbook = function() UO.Macro(9,5,'') end,  
  CloseChat = function() UO.Macro(9,6,'') end,  
  CloseBackpack = function() UO.Macro(9,7,'') end,  
  CloseOverview = function() UO.Macro(9,8,'') end,  
  CloseMail = function() UO.Macro(9,9,'') end,  
  ClosePartyManifest = function() UO.Macro(9,10,'') end,  
  ClosePartyChat = function() UO.Macro(9,11,'') end,  
  CloseNecroSpellbook = function() UO.Macro(9,12,'') end,  
  ClosePaladinSpellbook = function() UO.Macro(9,13,'') end,  
  CloseCombatBook = function() UO.Macro(9,14,'') end,  
  CloseBushidoSpellbook = function() UO.Macro(9,15,'') end,  
  CloseNinjitsuSpellbook = function() UO.Macro(9,16,'') end,  
  CloseGuild = function() UO.Macro(9,17,'') end,  
  CloseSpellweavingSpellbook = function() UO.Macro(9,18,'') end,   -- assumed
  CloseQuestLog = function() UO.Macro(9,19,'') end,     -- assumed
  MinimizePaperdoll = function() UO.Macro(10,1,'') end,  
  MinimizeStatus = function() UO.Macro(10,2,'') end,  
  MinimizeJournal = function() UO.Macro(10,3,'') end,  
  MinimizeSkills = function() UO.Macro(10,4,'') end,  
  MinimizeSpellbook = function() UO.Macro(10,5,'') end,  
  MinimizeChat = function() UO.Macro(10,6,'') end,  
  MinimizeBackpack = function() UO.Macro(10,7,'') end,  
  MinimizeOverview = function() UO.Macro(10,8,'') end,  
  MinimizeMail = function() UO.Macro(10,9,'') end,  
  MinimizePartyManifest = function() UO.Macro(10,10,'') end,  
  MinimizePartyChat = function() UO.Macro(10,11,'') end,  
  MinimizeNecroSpellbook = function() UO.Macro(10,12,'') end,  
  MinimizePaladinSpellbook = function() UO.Macro(10,13,'') end,  
  MinimizeCombatBook = function() UO.Macro(10,14,'') end,  
  MinimizeBushidoSpellbook = function() UO.Macro(10,15,'') end,  
  MinimizeNinjitsuSpellbook = function() UO.Macro(10,16,'') end,  
  MinimizeGuild = function() UO.Macro(10,17,'') end,  
  MinimizeSpellweavingSpellbook = function() UO.Macro(10,18,'') end,   -- assumed
  MaximizePaperdoll = function() UO.Macro(11,1,'') end,  
  MaximizeStatus = function() UO.Macro(11,2,'') end,  
  MaximizeJournal = function() UO.Macro(11,3,'') end,  
  MaximizeSkills = function() UO.Macro(11,4,'') end,  
  MaximizeSpellbook = function() UO.Macro(11,5,'') end,  
  MaximizeChat = function() UO.Macro(11,6,'') end,  
  MaximizeBackpack = function() UO.Macro(11,7,'') end,  
  MaximizeOverview = function() UO.Macro(11,8,'') end,  
  MaximizeMail = function() UO.Macro(11,9,'') end,  
  MaximizePartyManifest = function() UO.Macro(11,10,'') end,  
  MaximizePartyChat = function() UO.Macro(11,11,'') end,  
  MaximizeNecroSpellbook = function() UO.Macro(11,12,'') end,  
  MaximizePaladinSpellbook = function() UO.Macro(11,13,'') end,  
  MaximizeCombatBook = function() UO.Macro(11,14,'') end,  
  MaximizeBushidoSpellbook = function() UO.Macro(11,15,'') end,  
  MaximizeNinjitsuSpellbook = function() UO.Macro(11,16,'') end,  
  MaximizeGuild = function() UO.Macro(11,17,'') end,  
  MaximizeSpellweavingSpellbook = function() UO.Macro(11,18,'') end,   -- assumed
  OpenDoor = function() UO.Macro(12,0,'') end,  
  UseSkillAnatomy = function() UO.Macro(13, 1, '') end,  
  UseSkillAnimalLore = function() UO.Macro(13, 2, '') end,  
  UseSkillAnimalTaming = function() UO.Macro(13, 35, '') end,  
  UseSkillArmsLore = function() UO.Macro(13, 4, '') end,  
  UseSkillBegging = function() UO.Macro(13, 6, '') end,  
  UseSkillCartography = function() UO.Macro(13, 12, '') end,  
  UseSkillDetectingHidden = function() UO.Macro(13, 14, '') end,  
  UseSkillDiscordance = function() UO.Macro(13, 15, '') end,  
  UseSkillEvaluatingIntelligence = function() UO.Macro(13, 16, '') end,  
  UseSkillForensicEvaluation = function() UO.Macro(13, 19, '') end,  
  UseSkillHiding = function() UO.Macro(13, 21, '') end,  
  UseSkillInscription = function() UO.Macro(13, 23, '') end,  
  UseSkillItemIdentification = function() UO.Macro(13, 3, '') end,  
  UseSkillMeditation = function() UO.Macro(13, 46, '') end,  
  UseSkillPeacemaking = function() UO.Macro(13, 9, '') end,  
  UseSkillPoisoning = function() UO.Macro(13, 30, '') end,  
  UseSkillProvocation = function() UO.Macro(13, 22, '') end,  
  UseSkillRemoveTrap = function() UO.Macro(13, 48, '') end,  
  UseSkillSpiritSpeak = function() UO.Macro(13, 32, '') end,  
  UseSkillStealing = function() UO.Macro(13, 33, '') end,  
  UseSkillStealth = function() UO.Macro(13, 47, '') end,  
  UseSkillTasteIdentification = function() UO.Macro(13, 36, '') end,  
  UseSkillTracking = function() UO.Macro(13, 38, '') end,  
  LastSkill = function() UO.Macro(14, 0, '') end,  
  CastSpellClumsy = function() UO.Macro(15, 0, '') end,  
  CastSpellCreateFood = function() UO.Macro(15, 1, '') end,  
  CastSpellFeeblemind = function() UO.Macro(15, 2, '') end,  
  CastSpellHeal = function() UO.Macro(15, 3, '') end,  
  CastSpellMagicArrow = function() UO.Macro(15, 4, '') end,  
  CastSpellNightSight = function() UO.Macro(15, 5, '') end,  
  CastSpellReactiveArmor = function() UO.Macro(15, 6, '') end,  
  CastSpellWeaken = function() UO.Macro(15, 7, '') end,  
  CastSpellAgility = function() UO.Macro(15, 8, '') end,  
  CastSpellCunning = function() UO.Macro(15, 9, '') end,  
  CastSpellCure = function() UO.Macro(15, 10, '') end,  
  CastSpellHarm = function() UO.Macro(15, 11, '') end,  
  CastSpellMagicTrap = function() UO.Macro(15, 12, '') end,  
  CastSpellMagicUntrap = function() UO.Macro(15, 13, '') end,  
  CastSpellProtection = function() UO.Macro(15, 14, '') end,  
  CastSpellStrength = function() UO.Macro(15, 15, '') end,  
  CastSpellBless = function() UO.Macro(15, 16, '') end,  
  CastSpellFireball = function() UO.Macro(15, 17, '') end,  
  CastSpellMagicLock = function() UO.Macro(15, 18, '') end,  
  CastSpellPoison = function() UO.Macro(15, 19, '') end,  
  CastSpellTelekinesis = function() UO.Macro(15, 20, '') end,  
  CastSpellTeleport = function() UO.Macro(15, 21, '') end,  
  CastSpellUnlock = function() UO.Macro(15, 22, '') end,  
  CastSpellWallOfStone = function() UO.Macro(15, 23, '') end,  
  CastSpellArchCure = function() UO.Macro(15, 24, '') end,  
  CastSpellArchProtection = function() UO.Macro(15, 25, '') end,  
  CastSpellCurse = function() UO.Macro(15, 26, '') end,  
  CastSpellFireField = function() UO.Macro(15, 27, '') end,  
  CastSpellGreaterHeal = function() UO.Macro(15, 28, '') end,  
  CastSpellLightning = function() UO.Macro(15, 29, '') end,  
  CastSpellManaDrain = function() UO.Macro(15, 30, '') end,  
  CastSpellRecall = function() UO.Macro(15, 31, '') end,  
  CastSpellBladeSpirits = function() UO.Macro(15, 32, '') end,  
  CastSpellDispelField = function() UO.Macro(15, 33, '') end,  
  CastSpellIncognito = function() UO.Macro(15, 34, '') end,  
  CastSpellMagicReflection = function() UO.Macro(15, 35, '') end,  
  CastSpellMindBlast = function() UO.Macro(15, 36, '') end,  
  CastSpellParalyze = function() UO.Macro(15, 37, '') end,  
  CastSpellPoisonField = function() UO.Macro(15, 38, '') end,  
  CastSpellSummonCreature = function() UO.Macro(15, 39, '') end,  
  CastSpellDispel = function() UO.Macro(15, 40, '') end,  
  CastSpellEnergyBolt = function() UO.Macro(15, 41, '') end,  
  CastSpellExplosion = function() UO.Macro(15, 42, '') end,  
  CastSpellInvisibility = function() UO.Macro(15, 43, '') end,  
  CastSpellMark = function() UO.Macro(15, 44, '') end,  
  CastSpellMassCurse = function() UO.Macro(15, 45, '') end,  
  CastSpellParalyzeField = function() UO.Macro(15, 46, '') end,  
  CastSpellReveal = function() UO.Macro(15, 47, '') end,  
  CastSpellChainLightning = function() UO.Macro(15, 48, '') end,  
  CastSpellEnergyField = function() UO.Macro(15, 49, '') end,  
  CastSpellFlameStrike = function() UO.Macro(15, 50, '') end,  
  CastSpellGateTravel = function() UO.Macro(15, 51, '') end,  
  CastSpellManaVampire = function() UO.Macro(15, 52, '') end,  
  CastSpellMassDispel = function() UO.Macro(15, 53, '') end,  
  CastSpellMeteorSwarm = function() UO.Macro(15, 54, '') end,  
  CastSpellPolymorph = function() UO.Macro(15, 55, '') end,  
  CastSpellEarthquake = function() UO.Macro(15, 56, '') end,  
  CastSpellEnergyVortex = function() UO.Macro(15, 57, '') end,  
  CastSpellResurrection = function() UO.Macro(15, 58, '') end,  
  CastSpellAirElemental = function() UO.Macro(15, 59, '') end,  
  CastSpellSummonDaemon = function() UO.Macro(15, 60, '') end,  
  CastSpellEarthElemental = function() UO.Macro(15, 61, '') end,  
  CastSpellFireElemental = function() UO.Macro(15, 62, '') end,  
  CastSpellWaterElemental = function() UO.Macro(15, 63, '') end,  
  CastSpellAnimateDead = function() UO.Macro(15, 101, '') end,    
  CastSpellBloodOath = function() UO.Macro(15, 102, '') end,    
  CastSpellCorpseSkin = function() UO.Macro(15, 103, '') end,    
  CastSpellCurseWeapon = function() UO.Macro(15, 104, '') end,    
  CastSpellEvilOmen = function() UO.Macro(15, 105, '') end,    
  CastSpellHorrificBeast = function() UO.Macro(15, 106, '') end,    
  CastSpellLichForm = function() UO.Macro(15, 107, '') end,    
  CastSpellMindRot = function() UO.Macro(15, 108, '') end,    
  CastSpellPainSpike = function() UO.Macro(15, 109, '') end,    
  CastSpellPoisonStrike = function() UO.Macro(15, 110, '') end,    
  CastSpellStrangle = function() UO.Macro(15, 111, '') end,    
  CastSpellSummonFamiliar = function() UO.Macro(15, 112, '') end,    
  CastSpellVampiricEmbrace = function() UO.Macro(15, 113, '') end,    
  CastSpellVengefulSpirit = function() UO.Macro(15, 114, '') end,    
  CastSpellWither = function() UO.Macro(15, 115, '') end,    
  CastSpellWraithForm = function() UO.Macro(15, 116, '') end,    
  CastSpellExorcism = function() UO.Macro(15, 117, '') end,    
  CastSpellHonorableExecution = function() UO.Macro(15, 145, '') end,    
  CastSpellConfidence = function() UO.Macro(15, 146, '') end,    
  CastSpellEvasion = function() UO.Macro(15, 147, '') end,    
  CastSpellCounterAttack = function() UO.Macro(15, 148, '') end,    
  CastSpellLightningStrike = function() UO.Macro(15, 149, '') end,    
  CastSpellMomentumStrike = function() UO.Macro(15, 150, '') end,    
  CastSpellCleanseByFire = function() UO.Macro(15, 201, '') end,    
  CastSpellCloseWounds = function() UO.Macro(15, 202, '') end,    
  CastSpellConsecrateWeapon = function() UO.Macro(15, 203, '') end,    
  CastSpellDispelEvil = function() UO.Macro(15, 204, '') end,    
  CastSpellDivineFury = function() UO.Macro(15, 205, '') end,    
  CastSpellEnemyOfOne = function() UO.Macro(15, 206, '') end,    
  CastSpellHolyLight = function() UO.Macro(15, 207, '') end,    
  CastSpellNobleSacrifice = function() UO.Macro(15, 208, '') end,    
  CastSpellRemoveCurse = function() UO.Macro(15, 209, '') end,    
  CastSpellSacredJourney = function() UO.Macro(15, 210, '') end,    
  CastSpellFocusAttack = function() UO.Macro(15, 245, '') end,    
  CastSpellDeathStrike = function() UO.Macro(15, 246, '') end,    
  CastSpellAnimalForm = function() UO.Macro(15, 247, '') end,    
  CastSpellKiAttack = function() UO.Macro(15, 248, '') end,    
  CastSpellSurpriseAttack = function() UO.Macro(15, 249, '') end,    
  CastSpellBackstab = function() UO.Macro(15, 250, '') end,    
  CastSpellShadowjump = function() UO.Macro(15, 251, '') end,    
  CastSpellMirrorImage = function() UO.Macro(15, 252, '') end,    
  CastSpellArcaneCircle = function() UO.Macro(15, 601, '') end,    
  CastSpellGiftOfRenewal = function() UO.Macro(15, 602, '') end,    
  CastSpellImmolatingWeapon = function() UO.Macro(15, 603, '') end,    
  CastSpellAttunement = function() UO.Macro(15, 604, '') end,    
  CastSpellThunderstorm = function() UO.Macro(15, 605, '') end,    
  CastSpellNaturesFury = function() UO.Macro(15, 606, '') end,    
  CastSpellSummonFey = function() UO.Macro(15, 607, '') end,    
  CastSpellSummonFiend = function() UO.Macro(15, 608, '') end,    
  CastSpellReaperForm = function() UO.Macro(15, 609, '') end,    
  CastSpellWildfire = function() UO.Macro(15, 610, '') end,    
  CastSpellEssenceOfWind = function() UO.Macro(15, 611, '') end,    
  CastSpellDryadAllure = function() UO.Macro(15, 612, '') end,    
  CastSpellEtherealVoyage = function() UO.Macro(15, 613, '') end,    
  CastSpellWordOfDeath = function() UO.Macro(15, 614, '') end,    
  CastSpellGiftOfLife = function() UO.Macro(15, 615, '') end,    
  CastSpellArcaneEmpowerment = function() UO.Macro(15, 616, '') end,    
  
  CastSpellStoneForm = function() UO.Macro(15,685, '') end,
  CastSpellCleansingWinds = function() UO.Macro(15,688, '') end,
  CastSpellHailStorm = function() UO.Macro(15,691, '') end,
  CastSpellNetherCyclone = function() UO.Macro(15,692,'') end,
  
  LastSpell = function() UO.Macro(16,0,'') end,  
  LastObject = function() UO.Macro(17,0,'') end,  
  Bow = function() UO.Macro(18,0,'') end,  
  Salute = function() UO.Macro(19,0,'') end,  
  QuitGame = function() UO.Macro(20,0,'') end,  
  AllNames = function() UO.Macro(21,0,'') end,  
  LastTarget = function() UO.Macro(22,0,'') end,  
  TargetSelf = function() UO.Macro(23,0,'') end,  
  ArmDisarmLeft = function() UO.Macro(24,1,'') end,  
  ArmDisarmRight = function() UO.Macro(24,2,'') end,  
  WaitForTarget = function() UO.Macro(25,0,'') end,  
  TargetNext = function() UO.Macro(26,0,'') end,  
  AttackLast = function() UO.Macro(27,0,'') end,  
  Delay = function(x) UO.Macro(28,0,x) end,  
  CircleTrans = function() UO.Macro(29,0,'') end,  
  CloseGumps = function() UO.Macro(31,0,'') end,  
  AlwaysRun = function() UO.Macro(32,0,'') end,  
  SaveDesktop = function() UO.Macro(33,0,'') end,  
  KillGumpOpen = function() UO.Macro(34,0,'') end,  
  PrimaryAbility = function() UO.Macro(35,0,'') end,  
  SecondaryAbility = function() UO.Macro(36,0,'') end,  
  EquipLastWeapon = function() UO.Macro(37,0,'') end,  
  SetUpdateRange = function(x) UO.Macro(38,0,x) end,  
  ModifyUpdateRange = function(x) UO.Macro(39,0,x) end,  
  IncreaseUpdateRange = function() UO.Macro(40,0,'') end,  
  DecreaseUpdateRange = function() UO.Macro(41,0,'') end,  
  MaximumUpdateRange = function() UO.Macro(42,0,'') end,  
  MinimumUpdateRange = function() UO.Macro(43,0,'') end,  
  DefaultUpdateRange = function() UO.Macro(44,0,'') end,  
  UpdateUpdateRange = function() UO.Macro(45,0,'') end,  
  EnableUpdateRangeColor = function() UO.Macro(46,0,'') end,  
  DisableUpdateRangeColor = function() UO.Macro(47,0,'') end,  
  ToggleUpdateRangeColor = function() UO.Macro(48,0,'') end,  
  InvokeHonorVirtue = function() UO.Macro(49,1,'') end,  
  InvokeSacrificeVirtue = function() UO.Macro(49,2,'') end,  
  InvokeValorVirtue = function() UO.Macro(49,3,'') end,  
  InvokeCompassionVirtue = function() UO.Macro(49,4,'') end,  
  InvokeJusticeProtection = function() UO.Macro(49,7,'') end,  
  SelectNextHostile = function() UO.Macro(50,1,'') end,  
  SelectNextPartyMember = function() UO.Macro(50,2,'') end,  
  SelectNextFollower = function() UO.Macro(50,3,'') end,  
  SelectNextObject = function() UO.Macro(50,4,'') end,  
  SelectNextMobile = function() UO.Macro(50,5,'') end,  
  SelectPreviousHostile = function() UO.Macro(51,1,'') end,  
  SelectPreviousPartyMember = function() UO.Macro(51,2,'') end,  
  SelectPreviousFollower = function() UO.Macro(51,3,'') end,  
  SelectPreviousObject = function() UO.Macro(51,4,'') end,  
  SelectPreviousMobile = function() UO.Macro(51,5,'') end,  
  SelectNearestHostile = function() UO.Macro(52,1,'') end,  
  SelectNearestPartyMember = function() UO.Macro(52,2,'') end,  
  SelectNearestFollower = function() UO.Macro(52,3,'') end,  
  SelectNearestObject = function() UO.Macro(52,4,'') end,  
  SelectNearestMobile = function() UO.Macro(52,5,'') end,  
  AttackSelected = function() UO.Macro(53,'','') end,  
  UseSelected = function() UO.Macro(54,'','') end,  
  CurrentTarget = function() UO.Macro(55,'','') end,  
  TargetingSystemOnOff = function() UO.Macro(56,'','') end,  
  ToggleBuffWindow = function() UO.Macro(57,'','') end,  
  BandageSelf = function() UO.Macro(58,'','') end, --needs server support, freeshards dont have it  
  BandageTarget = function() UO.Macro(59,'','') end
}
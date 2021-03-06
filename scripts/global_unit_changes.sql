--==============================================================
--******			  U N I T S  (NON-UNIQUE)			  ******
--==============================================================


-- Melee --
UPDATE Units SET PrereqTech='TECH_MILITARY_ENGINEERING',Cost=180 WHERE UnitType='UNIT_MAN_AT_ARMS'; 
UPDATE Units SET PrereqTech='TECH_METAL_CASTING' WHERE UnitType='UNIT_MUSKETMAN'; 
UPDATE Units_XP2 SET ResourceMaintenanceAmount=1,ResourceCost=0 WHERE UnitType='UNIT_INFANTRY';
-- Anti-Cav --
UPDATE Units SET Cost=55 WHERE UnitType='UNIT_SPEARMAN';
UPDATE Units SET Cost=160 WHERE UnitType='UNIT_PIKEMAN';
UPDATE Units SET Cost=220 WHERE UnitType='UNIT_PIKE_AND_SHOT'; 


--START ANTICAV BUFF:
--new inherent hold-the-line for all anticav, but only +5 to adjacent noncav units fighting cav
--not sure if this conflicts with the original hold the line, havent tested.  it shouldnt conflict
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
	('LESSER_HOLD_THE_LINE_BONUS','MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'HOLD_THE_LINE_REQUIREMENTS'),
	('LESSER_HOLD_THE_LINE_COMBAT_BONUS','MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'ANTI_CAVALRY_OPPONENT_REQUIREMENTS')
	;

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('LESSER_HOLD_THE_LINE_BONUS', 'ModifierId', 'LESSER_HOLD_THE_LINE_COMBAT_BONUS'),
	('LESSER_HOLD_THE_LINE_COMBAT_BONUS', 'Amount', 4)
	;

--establish ability and attach to anticav
INSERT OR IGNORE INTO UnitAbilities (UnitAbilityType, Name, Description,Permanent) VALUES 
	('ABILITY_LESSER_HOLD_THE_LINE', 'LOC_ABILITY_LESSER_HOLD_THE_LINE', 'LOC_ABILITY_LESSER_HOLD_THE_LINE', 1);
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES 
	('ABILITY_LESSER_HOLD_THE_LINE','LESSER_HOLD_THE_LINE_BONUS'); 
INSERT INTO Types (Type, Kind) VALUES 
	('ABILITY_LESSER_HOLD_THE_LINE','KIND_ABILITY');
INSERT INTO TypeTags(Type, Tag) VALUES 
	('ABILITY_LESSER_HOLD_THE_LINE', 'CLASS_ANTI_CAVALRY');
--end ability establish

INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES 
	('LESSER_HOLD_THE_LINE_COMBAT_BONUS','Preview', 'LOC_ABILITY_LESSER_HOLD_THE_LINE_NAME');
--DONE ANTICAV BUFF


-- Siege --
UPDATE Units SET PrereqTech='TECH_GUNPOWDER' WHERE UnitType='UNIT_BOMBARD'; 


-- Recon --
--new promotion tree

--left side is now ranger->sentry+spyglass->sniper
--right side is now guerrilla+ignorezoc->foragers->camouflage
--final is ambush

--deleting old connections and promotions
DELETE FROM UnitPromotionPrereqs WHERE 
	UnitPromotion='PROMOTION_CAMOUFLAGE' OR PrereqUnitPromotion='PROMOTION_CAMOUFLAGE' OR
	UnitPromotion='PROMOTION_SPYGLASS' OR PrereqUnitPromotion='PROMOTION_SPYGLASS' OR
	UnitPromotion='PROMOTION_GUERRILLA' OR PrereqUnitPromotion='PROMOTION_GUERRILLA' OR
	UnitPromotion='PROMOTION_ALPINE' OR PrereqUnitPromotion='PROMOTION_ALPINE';

DELETE FROM UnitPromotions WHERE 
	UnitPromotionType='PROMOTION_SPYGLASS' OR 
	UnitPromotionType='PROMOTION_ALPINE';



--making new promotions first
--combine spyglass+sentry, and guerrilla now ignores zoc
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SENTRY','SPYGLASS_BONUS_SIGHT'),
	('PROMOTION_GUERRILLA','IGNOREZOC_IGNORE_ZOC')
	;
UPDATE UnitPromotions SET Description='Can attack after moving. Ignore ZOC.' WHERE UnitPromotionType='PROMOTION_GUERRILLA'; 

--new promotion for increased healing in neutral territory
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, PromotionClass, Column) VALUES
	('PROMOTION_SIXFIX_FORAGER','FORAGER','Increased healing in neutral territory.',2,'PROMOTION_CLASS_RECON',3)
	;
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SIXFIX_FORAGER','SIXFIX_RECON_HEAL_BONUS')
	;
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
	('SIXFIX_RECON_HEAL_BONUS', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_RECON_HEAL_BONUS', 'Amount', 10),
	('SIXFIX_RECON_HEAL_BONUS', 'Type', 'NEUTRAL')
	;
INSERT INTO Types (Type, Kind) VALUES 
	('PROMOTION_SIXFIX_FORAGER','KIND_PROMOTION');

--new promotion for increased range (we will also be attaching alpine here)
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, PromotionClass, Column) VALUES
	('PROMOTION_SIXFIX_SNIPER','SNIPER','+1 [ICON_Range] Range.  Faster [ICON_Movement] Movement in Hills.',2,'PROMOTION_CLASS_RECON',3)
	;
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SIXFIX_SNIPER','SIXFIX_RECON_RANGE_BONUS'),
	('PROMOTION_SIXFIX_SNIPER','ALPINE_IGNORE_HILLS_MOVEMENT_PENALTY')
	;
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
	('SIXFIX_RECON_RANGE_BONUS', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_RECON_RANGE_BONUS', 'Amount', 1);
INSERT INTO Types (Type, Kind) VALUES 
	('PROMOTION_SIXFIX_SNIPER','KIND_PROMOTION');


--relink promotions
--left side
--UPDATE UnitPromotions SET Level=1, Column=1 WHERE UnitPromotionType='PROMOTION_RANGER';
UPDATE UnitPromotions SET Level=3, Column=1 WHERE UnitPromotionType='PROMOTION_SIXFIX_SNIPER';
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES
	('PROMOTION_SIXFIX_SNIPER','PROMOTION_SENTRY')
	;

--right side
UPDATE UnitPromotions SET Level=1, Column=3 WHERE UnitPromotionType='PROMOTION_GUERRILLA';
UPDATE UnitPromotions SET Level=2, Column=3 WHERE UnitPromotionType='PROMOTION_SIXFIX_FORAGER';
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES
	('PROMOTION_SIXFIX_FORAGER','PROMOTION_GUERRILLA')
	;
UPDATE UnitPromotions SET Level=3, Column=3 WHERE UnitPromotionType='PROMOTION_CAMOUFLAGE';
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES
	('PROMOTION_CAMOUFLAGE','PROMOTION_SIXFIX_FORAGER')
	;

UPDATE UnitPromotions SET Level=4, Column=2 WHERE UnitPromotionType='PROMOTION_AMBUSH';
DELETE FROM UnitPromotionPrereqs WHERE UnitPromotion='PROMOTION_AMBUSH' OR PrereqUnitPromotion='PROMOTION_AMBUSH';
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES
	('PROMOTION_AMBUSH','PROMOTION_CAMOUFLAGE'),
	('PROMOTION_AMBUSH','PROMOTION_SIXFIX_SNIPER')
	;


--+1 sight to all recon and some other balances
UPDATE Units SET BaseSightRange=3 WHERE PromotionClass='PROMOTION_CLASS_RECON'; 
UPDATE Units SET Cost=110, Combat=25, PrereqTech='TECH_CONSTRUCTION' WHERE UnitType='UNIT_SKIRMISHER'; 
UPDATE Units SET Cost=270, Combat=45, Range=2 WHERE UnitType='UNIT_RANGER';
UPDATE Units SET Cost=495, Combat=60, RangedCombat=75 WHERE UnitType='UNIT_SPEC_OPS'; 

-- Light Cav --
UPDATE Units SET PrereqTech='TECH_STIRRUPS', Cost=190 WHERE UnitType='UNIT_COURSER'; 
UPDATE Units SET Cost=210 WHERE UnitType='UNIT_KNIGHT';
 
-- Heavy Cav --
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2,ResourceCost=2 WHERE UnitType='UNIT_TANK'; 
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2,ResourceCost=2 WHERE UnitType='UNIT_MODERN_ARMOR'; 

-- Support --
UPDATE Routes_XP2 SET BuildWithUnitChargeCost=0 WHERE BuildWithUnitChargeCost=1; --military engineers dont use charges to build roads
DELETE FROM Unit_BuildingPrereqs WHERE Unit='UNIT_MILITARY_ENGINEER';
UPDATE Units SET Cost=200 WHERE UnitType='UNIT_MILITARY_ENGINEER';

--battering rams and siege towers will now affect monks
--making modifiers here
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
	('ENABLE_SIXFIX_WALL_ATTACK_MONK','MODIFIER_PLAYER_UNIT_ADJUST_ENABLE_WALL_ATTACK_PROMOTION_CLASS'),
	('BYPASS_SIXFIX_WALLS_MONK','MODIFIER_PLAYER_UNIT_ADJUST_BYPASS_WALLS_PROMOTION_CLASS')
	;

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('ENABLE_SIXFIX_WALL_ATTACK_MONK','PromotionClass','PROMOTION_CLASS_MONK'),
	('BYPASS_SIXFIX_WALLS_MONK','PromotionClass','PROMOTION_CLASS_MONK')
	;

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
	('ABILITY_ENABLE_WALL_ATTACK_PROMOTION_CLASS','ENABLE_SIXFIX_WALL_ATTACK_MONK'),
	('ABILITY_BYPASS_WALLS_PROMOTION_CLASS','BYPASS_SIXFIX_WALLS_MONK')
	;



-- Naval Raider -- 
UPDATE Units SET PrereqCivic='CIVIC_EXPLORATION' WHERE UnitType='UNIT_PRIVATEER';
INSERT OR IGNORE INTO Units_XP2 ( UnitType, ResourceMaintenanceAmount, ResourceCost, ResourceMaintenanceType, CanEarnExperience, CanFormMilitaryFormation)
VALUES ( 'UNIT_NUCLEAR_SUBMARINE', 1, 1, 'RESOURCE_URANIUM', 1, 1);

-- Air --
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2,ResourceCost=2 WHERE UnitType='UNIT_FIGHTER';
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2,ResourceCost=2 WHERE UnitType='UNIT_JET_FIGHTER';
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2,ResourceCost=2 WHERE UnitType='UNIT_BOMBER';
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2,ResourceCost=2 WHERE UnitType='UNIT_JET_BOMBER';

--Warrior Monks--
--will be available with a shrine, cheaper cost, will nerf combat str accordingly
UPDATE Units SET Combat=35, Cost=50, CostProgressionModel='COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1=6 WHERE UnitType='UNIT_WARRIOR_MONK';
DELETE FROM Unit_BuildingPrereqs WHERE Unit='UNIT_WARRIOR_MONK';
INSERT INTO Unit_BuildingPrereqs (Unit,PrereqBuilding) VALUES
	('UNIT_WARRIOR_MONK','BUILDING_SHRINE');

--now have inherent faith on kill
INSERT INTO UnitAbilities(UnitAbilityType, Name, Description) VALUES
	('ABILITY_SIXFIX_MONK_FAITH_ON_KILL', 'LOC_ABILITY_SIXFIX_MONK_FAITH_ON_KILL_NAME', 'LOC_ABILITY_SIXFIX_MONK_FAITH_ON_KILL_DESC');
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
	('ABILITY_SIXFIX_MONK_FAITH_ON_KILL', 'SIXFIX_MONK_FAITH_ON_KILL_MODIFIER');
INSERT INTO Types (Type, Kind) VALUES 
	('ABILITY_SIXFIX_MONK_FAITH_ON_KILL','KIND_ABILITY');
INSERT INTO TypeTags(Type, Tag) VALUES 
	('ABILITY_SIXFIX_MONK_FAITH_ON_KILL', 'CLASS_WARRIOR_MONK');

INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
	('SIXFIX_MONK_FAITH_ON_KILL_MODIFIER','MODIFIER_UNIT_ADJUST_POST_COMBAT_YIELD')
	;

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_MONK_FAITH_ON_KILL_MODIFIER','PercentDefeatedStrength', 150),
	('SIXFIX_MONK_FAITH_ON_KILL_MODIFIER','YieldType', 'YIELD_FAITH')
	;

--benefits from generals now
--taking this code from a post by infixo on civfanatics
-- 2019-04-09 Warrior Monks don't have bonuses from Great Generals
-- They are not counted as Medieval units - must be added to a ReqSet that selects subjects (GGs from Classical and Medieval eras)
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('AOE_CLASSICAL_REQUIREMENTS', 'AOE_REQUIRES_CLASS_WARRIOR_MONK');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('AOE_MEDIEVAL_REQUIREMENTS',  'AOE_REQUIRES_CLASS_WARRIOR_MONK');
INSERT INTO Requirements (RequirementId, RequirementType)                VALUES ('AOE_REQUIRES_CLASS_WARRIOR_MONK', 'REQUIREMENT_UNIT_TAG_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value)            VALUES ('AOE_REQUIRES_CLASS_WARRIOR_MONK', 'Tag', 'CLASS_WARRIOR_MONK');

--gain combat bonuses at these civics
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
	('SIXFIX_THEOLOGY_MONK_ADJUST_STRENGTH', 'MODIFIER_UNIT_ADJUST_BASE_COMBAT_STRENGTH', 'PLAYER_HAS_THEOLOGY'),
	('SIXFIX_REFORMED_CHURCH_MONK_ADJUST_STRENGTH', 'MODIFIER_UNIT_ADJUST_BASE_COMBAT_STRENGTH', 'PLAYER_HAS_REFORMED_CHURCH')
	;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_THEOLOGY_MONK_ADJUST_STRENGTH', 'Amount', 10),
	('SIXFIX_REFORMED_CHURCH_MONK_ADJUST_STRENGTH', 'Amount', 10)
	;

--requirement stuff here
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
	('REQUIRES_SIXFIX_PLAYER_HAS_THEOLOGY','REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
	('PLAYER_HAS_THEOLOGY', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
	('PLAYER_HAS_THEOLOGY', 'REQUIRES_SIXFIX_PLAYER_HAS_THEOLOGY');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
	('REQUIRES_SIXFIX_PLAYER_HAS_THEOLOGY','CivicType','CIVIC_THEOLOGY');

INSERT INTO Requirements (RequirementId, RequirementType) VALUES
	('REQUIRES_SIXFIX_PLAYER_HAS_REFORMED_CHURCH','REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
	('PLAYER_HAS_REFORMED_CHURCH', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
	('PLAYER_HAS_REFORMED_CHURCH', 'REQUIRES_SIXFIX_PLAYER_HAS_REFORMED_CHURCH');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
	('REQUIRES_SIXFIX_PLAYER_HAS_REFORMED_CHURCH','CivicType','CIVIC_REFORMED_CHURCH');


--creating the specific abilities here
INSERT INTO UnitAbilities(UnitAbilityType, Name, Description) VALUES
	('ABILITY_SIXFIX_THEOLOGY_MONK_ADJUST_STRENGTH', 'LOC_ABILITY_SIXFIX_THEOLOGY_MONK_BONUS_NAME', 'LOC_ABILITY_SIXFIX_THEOLOGY_MONK_BONUS_DESC');
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
	('ABILITY_SIXFIX_THEOLOGY_MONK_ADJUST_STRENGTH', 'SIXFIX_THEOLOGY_MONK_ADJUST_STRENGTH');
INSERT INTO Types (Type, Kind) VALUES 
	('ABILITY_SIXFIX_THEOLOGY_MONK_ADJUST_STRENGTH','KIND_ABILITY');
INSERT INTO TypeTags (Type, Tag) VALUES 
	('ABILITY_SIXFIX_THEOLOGY_MONK_ADJUST_STRENGTH','CLASS_WARRIOR_MONK');

INSERT INTO UnitAbilities(UnitAbilityType, Name, Description) VALUES
	('ABILITY_SIXFIX_REFORMED_CHURCH_MONK_ADJUST_STRENGTH', 'LOC_ABILITY_SIXFIX_REFORMED_CHURCH_MONK_BONUS_NAME', 'LOC_ABILITY_SIXFIX_REFORMED_CHURCH_MONK_BONUS_DESC');
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
	('ABILITY_SIXFIX_REFORMED_CHURCH_MONK_ADJUST_STRENGTH', 'SIXFIX_REFORMED_CHURCH_MONK_ADJUST_STRENGTH');
INSERT INTO Types (Type, Kind) VALUES 
	('ABILITY_SIXFIX_REFORMED_CHURCH_MONK_ADJUST_STRENGTH','KIND_ABILITY');
INSERT INTO TypeTags (Type, Tag) VALUES 
	('ABILITY_SIXFIX_REFORMED_CHURCH_MONK_ADJUST_STRENGTH','CLASS_WARRIOR_MONK');



--what if monks gained a supportive role in later civics?  similar to a general or a medic?
--on mass media, be a medic?
--on prof sports, ???


--new promo tree for monks

--deleting old connections and promotions
DELETE FROM UnitPromotionPrereqs WHERE 
	UnitPromotion='PROMOTION_MONK_TWILIGHT_VEIL' OR PrereqUnitPromotion='PROMOTION_MONK_TWILIGHT_VEIL' OR
	UnitPromotion='PROMOTION_MONK_DISCIPLES' OR PrereqUnitPromotion='PROMOTION_MONK_DISCIPLES' OR
	UnitPromotion='PROMOTION_MONK_EXPLODING_PALMS' OR PrereqUnitPromotion='PROMOTION_MONK_EXPLODING_PALMS' OR
	UnitPromotion='PROMOTION_MONK_SHADOW_STRIKE' OR PrereqUnitPromotion='PROMOTION_MONK_SHADOW_STRIKE' OR 
	UnitPromotion='PROMOTION_MONK_SWEEPING_WIND' OR PrereqUnitPromotion='PROMOTION_MONK_SWEEPING_WIND' OR
	UnitPromotion='PROMOTION_MONK_DANCING_CRANE' OR PrereqUnitPromotion='PROMOTION_MONK_DANCING_CRANE' OR  
	UnitPromotion='PROMOTION_MONK_COBRA_STRIKE' OR PrereqUnitPromotion='PROMOTION_MONK_COBRA_STRIKE';
	;

DELETE FROM UnitPromotions WHERE 
	UnitPromotionType='PROMOTION_MONK_SWEEPING_WIND' OR
	UnitPromotionType='PROMOTION_MONK_TWILIGHT_VEIL' OR
	UnitPromotionType='PROMOTION_MONK_DANCING_CRANE' 
	OR UnitPromotionType='PROMOTION_MONK_COBRA_STRIKE'
	;

--	left: (designed for monks to be like cavalry)
--		shadowstrike tier 1:
--			combine with twilight veil
--		naruto run tier 2:
--			ignores rough terrain
--		exploding palms: 
--			also add hussar knockback


--new shadow strike, can simply just combine with twiveil
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_MONK_SHADOW_STRIKE','CAMOUFLAGE_STEALTH');
UPDATE UnitPromotions SET Description='2x flanking bonus.  Only adjacent enemy units can reveal this unit.' WHERE UnitPromotionType='PROMOTION_MONK_SHADOW_STRIKE';

--naruto run promotion
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, PromotionClass, Column) VALUES
	('PROMOTION_SIXFIX_NARUTO_RUN','Naruto Run','Ignore all terrain movement penalties.',2,'PROMOTION_CLASS_MONK',1);
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SIXFIX_NARUTO_RUN','MOD_IGNORE_TERRAIN_COST'),
	('PROMOTION_SIXFIX_NARUTO_RUN','AMPHIBIOUS_BONUS_IGNORE_RIVERS')
	;
INSERT INTO Types (Type, Kind) VALUES 
	('PROMOTION_SIXFIX_NARUTO_RUN','KIND_PROMOTION');

--exploding palms has hussar knockback
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_MONK_EXPLODING_PALMS','HUSSAR_FORCE_RETREAT');
UPDATE UnitPromotions SET Level=3, Description='+10 [ICON_STRENGTH] strength.  Gains Winged Hussar knockback ability.' WHERE UnitPromotionType='PROMOTION_MONK_EXPLODING_PALMS';

--right: (designed for monks to siege cities)
--		disciples tier 1:
--			add monks gain extra healing if in city following ur religion
--			
--		 crusaders tier2:
--			conquistador effect (escort part)
--		
--		 Baptists tier3:
--		conquistador effect (convert part) and killing a unit gives you an postle

--disciples buff
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_MONK_DISCIPLES','SIXFIX_DISCIPLES_HEAL_BONUS');
--not sure if this has to has be your founded religion
UPDATE UnitPromotions SET Level=1, Description='Spread religion to nearby cities on kill.  Additional healing near cities following your religion.' WHERE UnitPromotionType='PROMOTION_MONK_DISCIPLES';
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
	('SIXFIX_DISCIPLES_HEAL_BONUS', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN','SIXFIX_UNIT_NEAR_SAME_RELIGION_CITY_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_DISCIPLES_HEAL_BONUS', 'Amount', 10),
	('SIXFIX_DISCIPLES_HEAL_BONUS', 'Type', 'ALL')
	;
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
	('SIXFIX_UNIT_NEAR_SAME_RELIGION_CITY_REQUIREMENTS', 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
	('SIXFIX_UNIT_NEAR_SAME_RELIGION_CITY_REQUIREMENTS', 'REQUIRES_UNIT_NEAR_FRIENDLY_RELIGIOUS_CITY'),
	('SIXFIX_UNIT_NEAR_SAME_RELIGION_CITY_REQUIREMENTS', 'REQUIRES_UNIT_NEAR_ENEMY_RELIGIOUS_CITY')
	;

--crusaders 
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, PromotionClass, Column) VALUES
	('PROMOTION_SIXFIX_CRUSADERS','Crusaders','+10 [ICON_STRENGTH] Strength when adjacent to a religious unit.',2,'PROMOTION_CLASS_MONK',3);
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SIXFIX_CRUSADERS','CONQUISTADOR_SPECIFIC_UNIT_COMBAT');
	;
INSERT INTO Types (Type, Kind) VALUES 
	('PROMOTION_SIXFIX_CRUSADERS','KIND_PROMOTION');

--baptists
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, PromotionClass, Column) VALUES
	('PROMOTION_SIXFIX_BAPTISTS','Baptists','Conquering a city fully converts it to your religion.  Chance to gain an Apostle after a unit kill.',3,'PROMOTION_CLASS_MONK',3);
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
	('SIXFIX_GET_APOSTLE_FROM_KILL','MODIFIER_UNIT_ADJUST_COMBAT_UNIT_CAPTURE');
INSERT INTO ModifierArguments (ModifierId,Name,Value) VALUES
	('SIXFIX_GET_APOSTLE_FROM_KILL','UnitType','UNIT_APOSTLE'),
	('SIXFIX_GET_APOSTLE_FROM_KILL','CanCapture',1)
	;
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SIXFIX_BAPTISTS','CONQUISTADOR_CITY_RELIGION_COMBAT'),
	('PROMOTION_SIXFIX_BAPTISTS','SIXFIX_GET_APOSTLE_FROM_KILL')
	;
INSERT INTO Types (Type, Kind) VALUES 
	('PROMOTION_SIXFIX_BAPTISTS','KIND_PROMOTION');

--grandmaster

INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, PromotionClass, Column) VALUES
	('PROMOTION_SIXFIX_GRANDMASTERS','Grandmasters','+10 [ICON_STRENGTH] strength.  +5 [ICON_STRENGTH] strength and +1 [ICON_Movement] movement to adjacent Monks.',4,'PROMOTION_CLASS_MONK',2);

INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SIXFIX_GRANDMASTERS','SIXFIX_GRANDMASTERS_COMBAT'),
	('PROMOTION_SIXFIX_GRANDMASTERS','SIXFIX_GRANDMASTERS_MOVEMENT')
	;
INSERT INTO Types (Type, Kind) VALUES 
	('PROMOTION_SIXFIX_GRANDMASTERS','KIND_PROMOTION');
INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES 
	('SIXFIX_GRANDMASTERS_COMBAT_BONUS','Preview', 'LOC_SIXFIX_GRANDMASTERS_COMBAT_DESC');

INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
	('SIXFIX_GRANDMASTERS_COMBAT','MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'HOLD_THE_LINE_REQUIREMENTS'),
	('SIXFIX_GRANDMASTERS_MOVEMENT','MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'HOLD_THE_LINE_REQUIREMENTS'),
	('SIXFIX_GRANDMASTERS_COMBAT_BONUS','MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'SIXFIX_UNIT_IS_MONK_REQUIREMENTS'),
	('SIXFIX_GRANDMASTERS_MOVEMENT_BONUS','MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'SIXFIX_UNIT_IS_MONK_REQUIREMENTS')
	;

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_GRANDMASTERS_COMBAT', 'ModifierId', 'SIXFIX_GRANDMASTERS_COMBAT_BONUS'),
	('SIXFIX_GRANDMASTERS_MOVEMENT', 'ModifierId', 'SIXFIX_GRANDMASTERS_MOVEMENT_BONUS'),
	('SIXFIX_GRANDMASTERS_COMBAT_BONUS', 'Amount', 5),
	('SIXFIX_GRANDMASTERS_MOVEMENT_BONUS','Amount', 1)
	;



--BUGGED/UNUSED: monks will only be able to do ranged attacks, cant figure out how to make them like immortals where they are classed as a melee with a ranged attk
--new promotion for ranged attack
/*
INSERT INTO UnitAbilities(UnitAbilityType, Name, Description) VALUES
	('ABILITY_SIXFIX_MONK_MELEE_AND_RANGED', 'LOC_ABILITY_SIXFIX_MONK_MELEE_AND_RANGED_NAME', 'LOC_ABILITY_SIXFIX_MONK_MELEE_AND_RANGED_DESC');
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
	('ABILITY_SIXFIX_MONK_MELEE_AND_RANGED', 'SIXFIX_GRANT_MONK_IMMORTAL_ATTACH_MODIFIER');
INSERT INTO Types (Type, Kind) VALUES 
	('ABILITY_SIXFIX_MONK_MELEE_AND_RANGED','KIND_ABILITY');
INSERT INTO TypeTags (Type, Tag) VALUES 
	('ABILITY_SIXFIX_MONK_MELEE_AND_RANGED','CLASS_WARRIOR_MONK'),
	('ABILITY_IMMORTAL', 'CLASS_WARRIOR_MONK')
	;

INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
	('SIXFIX_GRANT_MONK_IMMORTAL_ATTACH_MODIFIER', 'MODIFIER_ALL_PLAYER_UNITS_ATTACH_MODIFIER'),
	('SIXFIX_GRANT_MONK_IMMORTAL_ABILITY', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY')
	;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_GRANT_MONK_IMMORTAL_ATTACH_MODIFIER', 'ModifierId', 'SIXFIX_GRANT_MONK_IMMORTAL_ABILITY'),
	('SIXFIX_GRANT_MONK_IMMORTAL_ABILITY', 'AbilityType', 'ABILITY_IMMORTAL')
	;

UPDATE Units SET RangedCombat=55, Range=1 WHERE UnitType='UNIT_WARRIOR_MONK';
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, PromotionClass, Column) VALUES
	('PROMOTION_SIXFIX_KI_BLAST','KI BLAST','Enables the ranged attack. +2 [ICON_Range] Range and deals full damage to walls.',4,'PROMOTION_CLASS_MONK',2)
	;
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SIXFIX_KI_BLAST','SIXFIX_MONK_RANGE_BONUS'),
	('PROMOTION_SIXFIX_KI_BLAST','SIXFIX_MONK_RANGED_FULL_DAMAGE_WALLS')
	;
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
	('SIXFIX_MONK_RANGE_BONUS', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE'),
	('SIXFIX_MONK_RANGED_FULL_DAMAGE_WALLS', 'MODIFIER_PLAYER_UNIT_IGNORE_RANGED_VS_DISTRICT_PENALTY')
	;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_MONK_RANGE_BONUS', 'Amount', 1),
	('SIXFIX_MONK_RANGED_FULL_DAMAGE_WALLS', 'Ignore',1)
	;

INSERT INTO Types (Type, Kind) VALUES 
	('PROMOTION_SIXFIX_KI_BLAST','KIND_PROMOTION');
*/


--LINKING promotions
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES
	('PROMOTION_SIXFIX_NARUTO_RUN','PROMOTION_MONK_SHADOW_STRIKE'),
	('PROMOTION_MONK_EXPLODING_PALMS','PROMOTION_SIXFIX_NARUTO_RUN'),
	('PROMOTION_SIXFIX_CRUSADERS','PROMOTION_MONK_DISCIPLES'),
	('PROMOTION_SIXFIX_BAPTISTS','PROMOTION_SIXFIX_CRUSADERS'),
	('PROMOTION_SIXFIX_GRANDMASTERS','PROMOTION_SIXFIX_BAPTISTS'),
	('PROMOTION_SIXFIX_GRANDMASTERS','PROMOTION_MONK_EXPLODING_PALMS')
	;

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
	('LESSER_HOLD_THE_LINE_COMBAT_BONUS', 'Amount', 3)
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
--UPDATE Units SET BaseSightRange=3 WHERE PromotionClass='PROMOTION_CLASS_RECON'; 
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
UPDATE Units SET Combat=35, Cost=50, CostProgressionModel='COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1=10 WHERE UnitType='UNIT_WARRIOR_MONK';
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
	('SIXFIX_MONK_FAITH_ON_KILL_MODIFIER','PercentDefeatedStrength', 100),
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
	('SIXFIX_DIVINE_RIGHT_MONK_ADJUST_STRENGTH', 'MODIFIER_UNIT_ADJUST_BASE_COMBAT_STRENGTH', 'PLAYER_HAS_DIVINE_RIGHT'),
	('SIXFIX_REFORMED_CHURCH_MONK_ADJUST_STRENGTH', 'MODIFIER_UNIT_ADJUST_BASE_COMBAT_STRENGTH', 'PLAYER_HAS_REFORMED_CHURCH')
	;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_THEOLOGY_MONK_ADJUST_STRENGTH', 'Amount', 5),
	('SIXFIX_DIVINE_RIGHT_MONK_ADJUST_STRENGTH', 'Amount', 5),
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
	('REQUIRES_SIXFIX_PLAYER_HAS_DIVINE_RIGHT','REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
	('PLAYER_HAS_DIVINE_RIGHT', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
	('PLAYER_HAS_DIVINE_RIGHT', 'REQUIRES_SIXFIX_PLAYER_HAS_DIVINE_RIGHT');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
	('REQUIRES_SIXFIX_PLAYER_HAS_DIVINE_RIGHT','CivicType','CIVIC_DIVINE_RIGHT');

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
	('ABILITY_SIXFIX_DIVINE_RIGHT_MONK_ADJUST_STRENGTH', 'LOC_ABILITY_SIXFIX_DIVINE_RIGHT_MONK_BONUS_NAME', 'LOC_ABILITY_SIXFIX_DIVINE_RIGHT_MONK_BONUS_DESC');
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
	('ABILITY_SIXFIX_DIVINE_RIGHT_MONK_ADJUST_STRENGTH', 'SIXFIX_DIVINE_RIGHT_MONK_ADJUST_STRENGTH');
INSERT INTO Types (Type, Kind) VALUES 
	('ABILITY_SIXFIX_DIVINE_RIGHT_MONK_ADJUST_STRENGTH','KIND_ABILITY');
INSERT INTO TypeTags (Type, Tag) VALUES 
	('ABILITY_SIXFIX_DIVINE_RIGHT_MONK_ADJUST_STRENGTH','CLASS_WARRIOR_MONK');

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



--SPIES
UPDATE Units SET Cost=125 WHERE UnitType='UNIT_SPY';

-- global_building_changes
-- Author: Cezas
-- DateCreated: 8/21/2021 3:36:20 PM
--------------------------------------------------------------

--City Center
INSERT INTO Building_BuildChargeProductions (BuildingType, UnitType, PercentProductionPerCharge) VALUES 
	('BUILDING_WALLS','UNIT_MILITARY_ENGINEER', 10),
	('BUILDING_CASTLE','UNIT_MILITARY_ENGINEER', 10),
	('BUILDING_STAR_FORT','UNIT_MILITARY_ENGINEER', 10)
	;

--BUG: somerthing wrong with this statement?
--UPDATE Buildings SET Cost=70 WHERE BuildingType='BUILDING_WATER_MILL';

--Encampments
UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType='BUILDING_BARRACKS';
UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType='BUILDING_STABLE';
UPDATE Buildings SET PrereqTech='TECH_ANIMAL_HUSBANDRY', Cost=90 WHERE BuildingType='BUILDING_STABLE';

--definining the additional military engineer buffs here
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('SIXFIX_ADDITIONAL_MILITARYENGINEER_CHARGE', 'MODIFIER_SINGLE_CITY_BUILDER_CHARGES', 'UNIT_IS_MILITARY_ENGINEER')
	;
--barracks +1 charge to engie and increesed milieng prod
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('SIXFIX_ADDITIONAL_MILITARYENGINEER_CHARGE', 'Amount', '1')
	;
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES 
	('BUILDING_BARRACKS','SIXFIX_ADDITIONAL_MILITARYENGINEER_CHARGE'),
	('BUILDING_BARRACKS','SIXFIX_ADJUST_MILITARY_ENGINEER_PRODUCTION')
	;

--stable +1 move to support and increased engprod
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES 
	('BUILDING_STABLE','SIXFIX_SUPPORT_MOVEMENT_MODIFIER'),
	('BUILDING_STABLE','SIXFIX_ADJUST_MILITARY_ENGINEER_PRODUCTION')
	;

--defining the needed modifier here
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
	('SIXFIX_SUPPORT_MOVEMENT_MODIFIER', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS'),
	('SIXFIX_SUPPORT_ADJUST_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT')
	;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('SIXFIX_SUPPORT_MOVEMENT_MODIFIER', 'AbilityType', 'ABILITY_SIXFIX_SUPPORT_INCREASED_MOVEMENT'),
	('SIXFIX_SUPPORT_ADJUST_MOVEMENT', 'Amount', 1)
	;
INSERT OR IGNORE INTO UnitAbilities (UnitAbilityType, Name, Description, Inactive, Permanent) VALUES 
	('ABILITY_SIXFIX_SUPPORT_INCREASED_MOVEMENT', 'LOC_ABILITY_SIXFIX_SUPPORT_INCREASED_MOVEMENT_NAME', 'LOC_ABILITY_SIXFIX_SUPPORT_INCREASED_MOVEMENT_DESC', 1, 1);
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES 
	('ABILITY_SIXFIX_SUPPORT_INCREASED_MOVEMENT','SIXFIX_SUPPORT_ADJUST_MOVEMENT'); 
INSERT INTO Types (Type, Kind) VALUES 
	('ABILITY_SIXFIX_SUPPORT_INCREASED_MOVEMENT','KIND_ABILITY');
INSERT INTO TypeTags(Type, Tag) VALUES 
	('ABILITY_SIXFIX_SUPPORT_INCREASED_MOVEMENT', 'CLASS_SUPPORT');



--armory provides more production reduction to miliengs and makes all support units made in that city ignore terrain
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES 
	('BUILDING_ARMORY','SIXFIX_ADJUST_MILITARY_ENGINEER_PRODUCTION'),
	('BUILDING_ARMORY','SIXFIX_SUPPORT_IGNORE_TERRAIN_MODIFIER')
	;

--adding ignore movement ability/modifier here
INSERT OR IGNORE INTO UnitAbilities (UnitAbilityType, Name, Description, Inactive, Permanent) VALUES 
	('ABILITY_SIXFIX_SUPPORT_IGNORE_TERRAIN', 'LOC_ABILITY_SIXFIX_SUPPORT_IGNORE_TERRAIN_NAME', 'LOC_ABILITY_SIXFIX_SUPPORT_IGNORE_TERRAIN_DESC', 1, 1);
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES 
	('ABILITY_SIXFIX_SUPPORT_IGNORE_TERRAIN','MOD_IGNORE_TERRAIN_COST'); 
INSERT INTO Types (Type, Kind) VALUES 
	('ABILITY_SIXFIX_SUPPORT_IGNORE_TERRAIN','KIND_ABILITY');
INSERT INTO TypeTags(Type, Tag) VALUES 
	('ABILITY_SIXFIX_SUPPORT_IGNORE_TERRAIN', 'CLASS_SUPPORT');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
	('SIXFIX_SUPPORT_IGNORE_TERRAIN_MODIFIER', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS')
	;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('SIXFIX_SUPPORT_IGNORE_TERRAIN_MODIFIER', 'AbilityType', 'ABILITY_SIXFIX_SUPPORT_IGNORE_TERRAIN')
	;

--mili academy gives more prod towards for now, will be more creative later
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES 
	('BUILDING_MILITARY_ACADEMY','SIXFIX_ADJUST_MILITARY_ENGINEER_PRODUCTION')
	;

--Holy site
--temples make warrior monks cost 150
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
	('BUILDING_TEMPLE', 'SIXFIX_ADJUST_WARRIOR_MONK_PRODUCTION');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
	('SIXFIX_ADJUST_WARRIOR_MONK_PRODUCTION','MODIFIER_SINGLE_CITY_ADJUST_UNIT_PURCHASE_COST')
	;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_ADJUST_WARRIOR_MONK_PRODUCTION','UnitType','UNIT_WARRIOR_MONK'), 
	('SIXFIX_ADJUST_WARRIOR_MONK_PRODUCTION','Amount',25)
	;

--ON HOLD: not sure where to add the requirementset for only monks
--temples also grant 50% exp bonus to monks
--INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
--	('BUILDING_TEMPLE', 'SIXFIX_ADJUST_WARRIOR_MONK_PRODUCTION');
--INSERT INTO Modifiers (ModifierId, ModifierType, Permanent) VALUES 
--	('SIXFIX_TEMPLE_TRAINED_UNIT_XP_MODIFIER','MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS',1),
--	('SIXFIX_TEMPLE_TRAINED_UNIT_XP','MODIFIER_PLAYER_UNIT_ADJUST_UNIT_EXPERIENCE_MODIFIER',1)
--	;
--INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
--	('SIXFIX_TEMPLE_TRAINED_UNIT_XP_MODIFIER','AbilityType','SIXFIX_ABILITY_TEMPLE_TRAINED_UNIT_XP'), 
--	('SIXFIX_TEMPLE_TRAINED_UNIT_XP','Amount',50)
--	;


--Theatre Square
UPDATE Building_YieldChanges SET YieldChange=4 WHERE BuildingType='BUILDING_BROADCAST_CENTER';
UPDATE Buildings_XP2 SET RequiredPower=2 WHERE BuildingType='BUILDING_BROADCAST_CENTER';
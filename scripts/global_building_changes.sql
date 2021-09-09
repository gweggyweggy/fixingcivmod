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

--definining the additional military engineer buffs here
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('SIXFIX_ADDITIONAL_MILITARYENGINEER_CHARGE', 'MODIFIER_SINGLE_CITY_BUILDER_CHARGES', 'UNIT_IS_MILITARY_ENGINEER')
	;
--barracks +1 charge to engie
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('SIXFIX_ADDITIONAL_MILITARYENGINEER_CHARGE', 'Amount', '1')
	;
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES 
	('BUILDING_BARRACKS','SIXFIX_ADDITIONAL_MILITARYENGINEER_CHARGE')
	;

--stable +1 move to support
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

INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES 
	('BUILDING_STABLE','SIXFIX_SUPPORT_MOVEMENT_MODIFIER')
	;


--Theatre Square
UPDATE Building_YieldChanges SET YieldChange=4 WHERE BuildingType='BUILDING_BROADCAST_CENTER';
UPDATE Buildings_XP2 SET RequiredPower=2 WHERE BuildingType='BUILDING_BROADCAST_CENTER';
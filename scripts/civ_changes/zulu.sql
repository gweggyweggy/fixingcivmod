-- zulu
-- Author: Cezas
-- DateCreated: 9/5/2021 2:47:18 PM
--------------------------------------------------------------
--taking some zulu changes from from BBG directly
UPDATE ModifierArguments SET Value='YIELD_CULTURE' WHERE Name='YieldType' AND ModifierID IN
    ('TRAIT_IKANDA_BARRACKS_SCIENCE', 'TRAIT_IKANDA_STABLE_SCIENCE', 'TRAIT_IKANDA_ARMORY_SCIENCE', 'TRAIT_IKANDA_MILITARY_ACADEMY_SCIENCE');

--tweaking a BBG change where corps get amibutho bonus the same time armies are unlocked
UPDATE Modifiers SET SubjectRequirementSetId='SIXFIX_PLAYER_HAS_NATIONALISM_REQUIREMENTS' WHERE ModifierId='TRAIT_LAND_CORPS_COMBAT_STRENGTH';
UPDATE Modifiers SET SubjectRequirementSetId='SIXFIX_PLAYER_HAS_MOBILIZATION_REQUIREMENTS' WHERE ModifierId='TRAIT_LAND_ARMIES_COMBAT_STRENGTH';


INSERT OR IGNORE INTO RequirementSets(RequirementSetId , RequirementSetType) VALUES
	('SIXFIX_PLAYER_HAS_NATIONALISM_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId , RequirementId) VALUES
	('SIXFIX_PLAYER_HAS_NATIONALISM_REQUIREMENTS', 'SIXFIX_PLAYER_HAS_NATIONALISM_REQUIREMENT');
INSERT OR IGNORE INTO Requirements(RequirementId , RequirementType) VALUES
	('SIXFIX_PLAYER_HAS_NATIONALISM_REQUIREMENT' , 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT OR IGNORE INTO RequirementArguments(RequirementId , Name, Value) VALUES
	('SIXFIX_PLAYER_HAS_NATIONALISM_REQUIREMENT' , 'CivicType', 'CIVIC_NATIONALISM');

INSERT OR IGNORE INTO RequirementSets(RequirementSetId , RequirementSetType) VALUES
	('SIXFIX_PLAYER_HAS_MOBILIZATION_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId , RequirementId) VALUES
	('SIXFIX_PLAYER_HAS_MOBILIZATION_REQUIREMENTS', 'SIXFIX_PLAYER_HAS_MOBILIZATION_REQUIREMENT');
INSERT OR IGNORE INTO Requirements(RequirementId , RequirementType) VALUES
	('SIXFIX_PLAYER_HAS_MOBILIZATION_REQUIREMENT' , 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT OR IGNORE INTO RequirementArguments(RequirementId , Name, Value) VALUES
	('SIXFIX_PLAYER_HAS_MOBILIZATION_REQUIREMENT' , 'CivicType', 'CIVIC_MOBILIZATION');

--keeping encampment replaces inline with mili eng buffs
INSERT INTO DistrictModifiers (DistrictType, ModifierId) VALUES 
	('DISTRICT_IKANDA','SIXFIX_ADJUST_MILITARY_ENGINEER_PRODUCTION')
	;
INSERT INTO District_BuildChargeProductions (DistrictType, UnitType, PercentProductionPerCharge) VALUES 
	('DISTRICT_IKANDA','UNIT_MILITARY_ENGINEER', 10)
	;

--nerfing impi against anticav as anticav are now more viable in general, and for historical purposes (iklwa's were much shorter than halberds)
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
	('SIXFIX_IMPI_COMBAT_MALUS','MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'ANTI_CAVALRY_OPPONENT_REQUIREMENTS')
	;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_IMPI_COMBAT_MALUS', 'Amount', -5)
	;
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES 
	('ABILITY_ZULU_IMPI','SIXFIX_IMPI_COMBAT_MALUS'); 

--couldnt get this to properly parse for some reason
INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES 
	('SIXFIX_IMPI_COMBAT_MALUS','Preview', 'Iklwas: -5 [ICON_STRENGTH] against Cavalry class units.');
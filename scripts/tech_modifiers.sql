-- tech_modifiers
-- Author: Cezas
-- DateCreated: 9/9/2021 3:54:54 PM
--------------------------------------------------------------

----SIEGE TACTICS

UPDATE Technologies SET Description='LOC_TECH_SIEGE_TACTICS_DESCRIPTION' WHERE TechnologyType='TECH_SIEGE_TACTICS';
--player gets +5 to city strike attacks, units gain +5 defending against cities
INSERT OR IGNORE INTO TechnologyModifiers (TechnologyType, ModifierId) VALUES 
	('TECH_SIEGE_TACTICS', 'SIXFIX_SIEGETACTICS_CITY_STRIKE_ATTACK_BONUS'),
	--('TECH_SIEGE_TACTICS', 'SIXFIX_SIEGETACTICS_UNIT_ATTACK_BONUS'),
	('TECH_SIEGE_TACTICS', 'SIXFIX_SIEGETACTICS_UNIT_DEFEND_BONUS')
	;

INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
	('SIXFIX_SIEGETACTICS_CITY_STRIKE_ATTACK_BONUS', 'MODIFIER_PLAYER_CITIES_ADJUST_RANGED_STRIKE')
	;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
	--('SIXFIX_SIEGETACTICS_UNIT_ATTACK_BONUS', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH','UNIT_ATTACKING_DISTRICT_REQUIREMENTS'),
	('SIXFIX_SIEGETACTICS_UNIT_DEFEND_BONUS', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH','EMPLACEMENT_REQUIREMENTS')
	;

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	--('SIXFIX_SIEGETACTICS_UNIT_ATTACK_BONUS', 'Amount', 5),
	('SIXFIX_SIEGETACTICS_CITY_STRIKE_ATTACK_BONUS', 'Amount', 5),
	('SIXFIX_SIEGETACTICS_UNIT_DEFEND_BONUS', 'Amount', 5)
	;

--forts can be built in rough terrain and features
INSERT INTO Improvement_ValidFeatures ('ImprovementType','FeatureType','PrereqTech') VALUES
	('IMPROVEMENT_FORT','FEATURE_FOREST','TECH_SIEGE_TACTICS'),
	('IMPROVEMENT_FORT','FEATURE_JUNGLE','TECH_SIEGE_TACTICS'),
	('IMPROVEMENT_FORT','FEATURE_MARSH','TECH_SIEGE_TACTICS'),
	('IMPROVEMENT_FORT','FEATURE_FLOODPLAINS','TECH_SIEGE_TACTICS'),
	('IMPROVEMENT_FORT','FEATURE_FLOODPLAINS_GRASSLAND','TECH_SIEGE_TACTICS'),
	('IMPROVEMENT_FORT','FEATURE_FLOODPLAINS_PLAINS','TECH_SIEGE_TACTICS')
	;

--TODO, this doesnt work
--units gain additional defenses in forts 
--INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
--	('SIXFIX_SIEGETACTICS_UNIT_DEFEND_FORT_BONUS', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH','SIXFIX_SIEGETACTICS_IMPROVED_FORT_REQUIREMENTS')
--	;

--INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
--	('SIXFIX_SIEGETACTICS_UNIT_DEFEND_FORT_BONUS', 'Amount', 30);

--INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES 
--	('SIXFIX_SIEGETACTICS_IMPROVED_FORT_REQUIREMENTS','REQUIREMENTSET_TEST_ALL')
--	;
--INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
--	('SIXFIX_SIEGETACTICS_IMPROVED_FORT_REQUIREMENTS','UNIT_IS_OCCUPYING_DEFENSE_IMPROVEMENT'),
--	('SIXFIX_SIEGETACTICS_IMPROVED_FORT_REQUIREMENTS','PLAYER_IS_DEFENDER_REQUIREMENTS')
--	;

--units gain +5 attacking into units with forts
	

-- zulu
-- Author: Cezas
-- DateCreated: 9/5/2021 2:47:18 PM
--------------------------------------------------------------
--taking some zulu changes from from BBG directly
UPDATE ModifierArguments SET Value='YIELD_CULTURE' WHERE Name='YieldType' AND ModifierID IN
    ('TRAIT_IKANDA_BARRACKS_SCIENCE', 'TRAIT_IKANDA_STABLE_SCIENCE', 'TRAIT_IKANDA_ARMORY_SCIENCE', 'TRAIT_IKANDA_MILITARY_ACADEMY_SCIENCE');

--tweaking BBG change where corps get amibutho bonus the same time armies are unlocked
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

INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES 
	('TRAIT_LAND_CORPS_COMBAT_STRENGTH','Preview', '+5 [ICON_Strength] Combat Strength to corps from Amabutho Ability');

INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES 
	('TRAIT_LAND_ARMIES_COMBAT_STRENGTH','Preview', '+5 [ICON_Strength] Combat Strength to armies from Amabutho Ability');


-- rome
-- Author: Cezas
-- DateCreated: 11/8/2021 7:35:14 PM
--------------------------------------------------------------
UPDATE Modifiers SET SubjectRequirementSetId='SIXFIX_PLAYER_HAS_CODE_OF_LAWS_REQUIREMENTS' WHERE ModifierId='TRAIT_ADJUST_NON_CAPITAL_FREE_CHEAPEST_BUILDING';



INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
	('SIXFIX_PLAYER_HAS_CODE_OF_LAWS_REQUIREMENTS','REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
	('SIXFIX_PLAYER_HAS_CODE_OF_LAWS_REQUIREMENTS','SIXFIX_PLAYER_HAS_CODE_OF_LAWS');

INSERT INTO Requirements (RequirementId, RequirementType) VALUES
	('SIXFIX_PLAYER_HAS_CODE_OF_LAWS','REQUIREMENT_PLAYER_HAS_CIVIC');

INSERT INTO RequirementArguments (RequirementId, Name, Value)  VALUES
	('SIXFIX_PLAYER_HAS_CODE_OF_LAWS','CivicType','CIVIC_CODE_OF_LAWS');



	
 
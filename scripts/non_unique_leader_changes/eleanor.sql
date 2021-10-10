-- eleanor
-- Author: Cezas
-- DateCreated: 10/6/2021 9:19:46 PM
--------------------------------------------------------------


UPDATE ModifierArguments SET Value=3 WHERE ModifierId='IDENTITY_NEARBY_GREATWORKS';

--UNUSED, might be too buggy with conquering
--INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
--	('SIXFIX_TRAIT_DOUBLE_WRITING_SLOTS', 'MODIFIER_PLAYER_CITIES_ADJUST_EXTRA_GREAT_WORK_SLOTS')
--	;
--INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
--	('SIXFIX_TRAIT_DOUBLE_WRITING_SLOTS','BuildingType', 'BUILDING_AMPHITHEATER'),
--	('SIXFIX_TRAIT_DOUBLE_WRITING_SLOTS','GreatWorkSlotType', 'GREATWORKSLOT_WRITING'),
--	('SIXFIX_TRAIT_DOUBLE_WRITING_SLOTS','Amount', '2');

--stealing from bbg
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId)
	VALUES
	('TRAIT_LEADER_ELEANOR_LOYALTY', 'THEATER_BUILDING_PRODUCTION_BONUS_CPLMOD');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId, OwnerRequirementSetId)
	VALUES
	('THEATER_BUILDING_PRODUCTION_BONUS_CPLMOD', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION', NULL, NULL);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value)
	VALUES
	('THEATER_BUILDING_PRODUCTION_BONUS_CPLMOD', 'DistrictType', 'DISTRICT_THEATER'),
	('THEATER_BUILDING_PRODUCTION_BONUS_CPLMOD', 'Amount', '100'                     );


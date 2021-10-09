-- georgia
-- Author: Cezas
-- DateCreated: 9/4/2021 4:04:06 PM
--------------------------------------------------------------
UPDATE Units SET Cost=180, Combat=45, PrereqTech='TECH_CASTLES' WHERE UnitType='UNIT_GEORGIAN_KHEVSURETI'; 
INSERT INTO Building_BuildChargeProductions (BuildingType, UnitType, PercentProductionPerCharge) VALUES 
	('BUILDING_TSIKHE','UNIT_MILITARY_ENGINEER', 10)
	;

--PLAYER_HAS_GOLDEN_AGE
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
	('SIXFIX_TAMAR_FAITH_PURCHASE_DISCOUNT_IN_GOLDEN_AGE', 'MODIFIER_PLAYER_GOVERNMENT_FLAT_BONUS', 'PLAYER_HAS_GOLDEN_AGE'),
	('SIXFIX_TAMAR_MORE_FAITH_ON_KILL_IN_GOLDEN_AGE', 'MODIFIER_PLAYER_UNITS_ADJUST_POST_COMBAT_YIELD', 'PLAYER_HAS_GOLDEN_AGE'),
	('SIXFIX_TAMAR_EXTRA_COMBAT_STRENGTH_IN_GOLDEN_AGE', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'PLAYER_HAS_GOLDEN_AGE')
	;

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('SIXFIX_TAMAR_FAITH_PURCHASE_DISCOUNT_IN_GOLDEN_AGE', 'BonusType', 'GOVERNMENTBONUS_FAITH_PURCHASES'),
	('SIXFIX_TAMAR_FAITH_PURCHASE_DISCOUNT_IN_GOLDEN_AGE', 'Amount', 25),
	('SIXFIX_TAMAR_MORE_FAITH_ON_KILL_IN_GOLDEN_AGE', 'PercentDefeatedStrength', 50),
	('SIXFIX_TAMAR_EXTRA_COMBAT_STRENGTH_IN_GOLDEN_AGE', 'Amount', 5)
	;

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
	('TRAIT_LEADER_RELIGION_CITY_STATES', 'SIXFIX_TAMAR_FAITH_PURCHASE_DISCOUNT_IN_GOLDEN_AGE')
	--THESE ARE BUGGED?  causes crashes when displaying combat diff against an enemy unit
	--('TRAIT_LEADER_RELIGION_CITY_STATES', 'SIXFIX_TAMAR_MORE_FAITH_ON_KILL_IN_GOLDEN_AGE')
	--('TRAIT_LEADER_RELIGION_CITY_STATES', 'SIXFIX_TAMAR_EXTRA_COMBAT_STRENGTH_IN_GOLDEN_AGE')
	;
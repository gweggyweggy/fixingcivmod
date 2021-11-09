-- scythia
-- Author: Cezas
-- DateCreated: 10/28/2021 6:17:02 PM
--------------------------------------------------------------
DELETE FROM TraitModifiers WHERE ModifierId='BONUS_VS_WOUNDED_UNITS';

UPDATE ModifierArguments SET Value=50 WHERE ModifierId='TOMYRIS_HEAL_AFTER_DEFEATING_UNIT';

UPDATE Units SET Cost=80, StrategicResource='RESOURCE_HORSES' WHERE UnitType='UNIT_SCYTHIAN_HORSE_ARCHER';

INSERT INTO Units_XP2 (UnitType, ResourceCost, CanEarnExperience, CanFormMilitaryFormation) VALUES
	('UNIT_SCYTHIAN_HORSE_ARCHER',10, 1, 1);
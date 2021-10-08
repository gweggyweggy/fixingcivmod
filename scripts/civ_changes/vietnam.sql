-- vietnam
-- Author: Cezas
-- DateCreated: 9/8/2021 11:00:38 PM
--------------------------------------------------------------
INSERT INTO DistrictModifiers (DistrictType, ModifierId) VALUES 
	('DISTRICT_THANH','SIXFIX_ADJUST_MILITARY_ENGINEER_PRODUCTION')
	;
INSERT INTO District_BuildChargeProductions (DistrictType, UnitType, PercentProductionPerCharge) VALUES 
	('DISTRICT_THANH','UNIT_MILITARY_ENGINEER', 10)
	;

UPDATE UnitAbilityModifiers SET ModifierId='IGNOREZOC_IGNORE_ZOC' WHERE UnitAbilityType='ABILITY_VOI_CHIEN';
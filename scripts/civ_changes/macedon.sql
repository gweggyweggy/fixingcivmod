-- macedon
-- Author: Cezas
-- DateCreated: 9/8/2021 10:57:09 PM
--------------------------------------------------------------
UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType='BUILDING_BASILIKOI_PAIDES';
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES 
	('BUILDING_BASILIKOI_PAIDES','SIXFIX_SUPPORT_MOVEMENT_MODIFIER'),
	('BUILDING_BASILIKOI_PAIDES','SIXFIX_ADDITIONAL_MILITARYENGINEER_CHARGE')
	;
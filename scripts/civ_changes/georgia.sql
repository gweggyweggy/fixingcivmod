-- georgia
-- Author: Cezas
-- DateCreated: 9/4/2021 4:04:06 PM
--------------------------------------------------------------
UPDATE Units SET Cost=180, Combat=45 PrereqTech='TECH_CASTLES' WHERE UnitType='UNIT_GEORGIAN_KHEVSURETI'; 
INSERT INTO Building_BuildChargeProductions (BuildingType, UnitType, PercentProductionPerCharge) VALUES 
	('BUILDING_TSIKHE','UNIT_MILITARY_ENGINEER', 10)
	;
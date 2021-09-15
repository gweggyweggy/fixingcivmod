-- khmer
-- Author: Cezas
-- DateCreated: 9/14/2021 8:51:11 PM
--------------------------------------------------------------
--apply temple monk change to prasat
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
	('BUILDING_PRASAT', 'SIXFIX_ADJUST_WARRIOR_MONK_PRODUCTION');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
	('SIXFIX_ADJUST_WARRIOR_MONK_PRODUCTION','MODIFIER_SINGLE_CITY_ADJUST_UNIT_PURCHASE_COST')
	;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_ADJUST_WARRIOR_MONK_PRODUCTION','UnitType','UNIT_WARRIOR_MONK'), 
	('SIXFIX_ADJUST_WARRIOR_MONK_PRODUCTION','Amount',25)
	;

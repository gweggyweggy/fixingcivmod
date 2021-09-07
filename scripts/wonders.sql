-- wonders
-- Author: Cezas
-- DateCreated: 9/4/2021 4:05:59 PM
--------------------------------------------------------------
--wonders are technically under the same table as buildings, but that's a little confusing so im making a seperate script for that

UPDATE Buildings SET PrereqCivic='CIVIC_MILITARY_TRADITION', Cost=180 WHERE BuildingType='BUILDING_STATUE_OF_ZEUS'; 

--huey teocali buff

INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES 
	('BUILDING_HUEY_TEOCALLI','SIXFIX_HUEYTEOCALLI_COMMERCIALHUB_LAKE_ADJ')
	;

INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
	('SIXFIX_HUEYTEOCALLI_COMMERCIALHUB_LAKE_ADJ','MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY')
	;

--TODO: make a custom terraintype for lakes
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('SIXFIX_HUEYTEOCALLI_COMMERCIALHUB_LAKE_ADJ', 'DistrictType', 'DISTRICT_COMMERCIAL_HUB'),
	('SIXFIX_HUEYTEOCALLI_COMMERCIALHUB_LAKE_ADJ', 'TerrainType', 'TERRAIN_COAST'),
	('SIXFIX_HUEYTEOCALLI_COMMERCIALHUB_LAKE_ADJ', 'YieldType', 'YIELD_GOLD'),
	('SIXFIX_HUEYTEOCALLI_COMMERCIALHUB_LAKE_ADJ', 'Amount', '1'),
	('SIXFIX_HUEYTEOCALLI_COMMERCIALHUB_LAKE_ADJ', 'Description', 'LOC_BUILDING_HUEYTEOCALLI_GOLD_ADJ')
	;

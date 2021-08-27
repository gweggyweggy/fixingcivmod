-- global_district_changes
-- Author: Cezas
-- DateCreated: 8/23/2021 8:48:06 PM
--------------------------------------------------------------

--BUFFING SOME DISTRICTS
--not making hippodromes nonspecialty since that might be a little broken
UPDATE Districts SET RequiresPopulation=0 WHERE DistrictType='DISTRICT_ENTERTAINMENT_COMPLEX' OR 
												DistrictType='DISTRICT_WATER_ENTERTAINMENT_COMPLEX' OR
												DistrictType='DISTRICT_STREET_CARNIVAL' OR
												DistrictType='DISTRICT_WATER_STREET_CARNIVAL' OR
												DistrictType='DISTRICT_PRESERVE' OR
												DistrictType='DISTRICT_DIPLOMATIC_QUARTER'
												;
UPDATE Districts SET Cost=40 WHERE DistrictType='DISTRICT_ENTERTAINMENT_COMPLEX' OR 
								   DistrictType='DISTRICT_WATER_ENTERTAINMENT_COMPLEX' OR
								   DistrictType='DISTRICT_PRESERVE'
								   ;

--UPDATE Districts SET Cost=20 WHERE DistrictType='DISTRICT_STREET_CARNIVAL' OR
--								   DistrictType='DISTRICT_WATER_STREET_CARNIVAL'
--								   ;


--BUFFING COASTAL CITIES

--BUFF: coastal cities build harbors and the harbor buildings faster
--we need to make a new modifier since the only other adjust_district applies to every single district type
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType)
VALUES ('MODIFIER_SINGLE_CITY_ADJUST_SPECIFIC_DISTRICT_PRODUCTION', 'COLLECTION_OWNER', 'EFFECT_ADJUST_DISTRICT_PRODUCTION');
INSERT INTO Types (Type, Kind)
VALUES ('MODIFIER_SINGLE_CITY_ADJUST_SPECIFIC_DISTRICT_PRODUCTION', 'KIND_MODIFIER')
;

--apply when a a city is created
INSERT INTO DistrictModifiers (DistrictType, ModifierId)
VALUES 
('DISTRICT_CITY_CENTER','MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION'),
('DISTRICT_CITY_CENTER','MARITIME_CITY_HARBOR_BUILDING_PRODUCTION')
;

INSERT INTO Modifiers (ModifierId, ModifierType,SubjectRequirementSetId)
VALUES 
('MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION','MODIFIER_SINGLE_CITY_ADJUST_SPECIFIC_DISTRICT_PRODUCTION', 'PLOT_IS_ADJACENT_COAST_CITY_CENTER_REQUIREMENTS'),
('MARITIME_CITY_HARBOR_BUILDING_PRODUCTION','MODIFIER_SINGLE_CITY_ADJUST_BUILDING_PRODUCTION', 'PLOT_IS_ADJACENT_COAST_CITY_CENTER_REQUIREMENTS')
;

--this bonus value may be adjusted after further gameplay testing
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES 
('MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION','Amount',50), 
('MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION','DistrictType','DISTRICT_HARBOR'),
('MARITIME_CITY_HARBOR_BUILDING_PRODUCTION','Amount',50), 
('MARITIME_CITY_HARBOR_BUILDING_PRODUCTION','DistrictType','DISTRICT_HARBOR')
;


--BUFF: each coastal tile adjacent to city center provides +1 prod
--TODO: add desc for what the modifier is (e.g. +2 production from (2 adjacent coastal tiles)), what is the LOC_ value?
--might have been able to use the all cities modifier, but this works just fine
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType)
VALUES ('MODIFIER_SINGLE_CITY_PRODUCTION_FROM_ADJACENT_COAST', 'COLLECTION_OWNER', 'EFFECT_TERRAIN_ADJACENCY');
INSERT INTO Types (Type, Kind)
VALUES ('MODIFIER_SINGLE_CITY_PRODUCTION_FROM_ADJACENT_COAST', 'KIND_MODIFIER');

INSERT INTO DistrictModifiers (DistrictType, ModifierId)
VALUES 
('DISTRICT_CITY_CENTER','MARITIME_CITY_PRODUCTION_FROM_ADJACENT_COAST')
;

INSERT INTO Modifiers (ModifierId, ModifierType,SubjectRequirementSetId)
VALUES 
('MARITIME_CITY_PRODUCTION_FROM_ADJACENT_COAST','MODIFIER_SINGLE_CITY_PRODUCTION_FROM_ADJACENT_COAST', 'PLOT_IS_ADJACENT_COAST_CITY_CENTER_REQUIREMENTS')
;

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES 
('MARITIME_CITY_PRODUCTION_FROM_ADJACENT_COAST','Amount',1), 
('MARITIME_CITY_PRODUCTION_FROM_ADJACENT_COAST','DistrictType','DISTRICT_CITY_CENTER'),
('MARITIME_CITY_PRODUCTION_FROM_ADJACENT_COAST','TerrainType','TERRAIN_COAST'),
('MARITIME_CITY_PRODUCTION_FROM_ADJACENT_COAST','YieldType','YIELD_PRODUCTION')
;


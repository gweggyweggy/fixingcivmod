-- global_district_changes
-- Author: Cezas
-- DateCreated: 8/23/2021 8:48:06 PM
--------------------------------------------------------------

--not making hippodromes nonspecialty since that might be a little broken
--TODO: make entertainment complexes only give +1 since they are basically free now
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

UPDATE Districts SET Cost=20 WHERE DistrictType='DISTRICT_STREET_CARNIVAL' OR
								   DistrictType='DISTRICT_WATER_STREET_CARNIVAL'
								   ;



--giving city centers next to coast a boon to promote more settling on coasts (at least for humans)

INSERT INTO DistrictModifiers (DistrictType, ModifierId)
VALUES ('DISTRICT_CITY_CENTER','MARITIME_CITY_HARBOR_BUILDINGS_PRODUCTION'),
	   ('DISTRICT_CITY_CENTER','MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION')
	   ;

--doing player_cities instead of all_cities since we would have to A. add a dynamicmod and B. it seems to add flat production instead of a percentage
INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId)
VALUES 
('MARITIME_CITY_HARBOR_BUILDINGS_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_BUILDING_PRODUCTION', 'PLOT_IS_ADJACENT_COAST_CITY_CENTER_REQUIREMENTS'),
('MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION', 'PLOT_IS_ADJACENT_COAST_CITY_CENTER_REQUIREMENTS')
;

--unused dynamic modifier, keeping as an example for later development
--INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType)
--VALUES ('MODIFIER_ALL_CITIES_ADJUST_DISTRICT_PRODUCTION', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_PRODUCTION_DISTRICT');
--INSERT INTO Types (Type, Kind)
--VALUES ('MODIFIER_ALL_CITIES_ADJUST_DISTRICT_PRODUCTION', 'KIND_MODIFIER');

--TODO: test with unique harbors
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES 
('MARITIME_CITY_HARBOR_BUILDINGS_PRODUCTION','Amount',30),
('MARITIME_CITY_HARBOR_BUILDINGS_PRODUCTION','DistrictType', 'DISTRICT_HARBOR'),
('MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION','Amount',30), 
('MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION','DistrictType','DISTRICT_HARBOR')
;



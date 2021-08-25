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

--we'll have these modifiers apply everyone immediately
--INSERT INTO GameModifiers (ModifierId)
--VALUES ('MARITIME_CITY_HARBOR_BUILDINGS_PRODUCTION'),
--	   ('MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION');


INSERT INTO DistrictModifiers (DistrictType, ModifierId)
VALUES ('DISTRICT_CITY_CENTER','MARITIME_CITY_HARBOR_BUILDINGS_PRODUCTION'),
	   ('DISTRICT_CITY_CENTER','MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION');


--but we only want it to apply to coastal cities
--TODO: test that this seg works
INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId)
VALUES 
('MARITIME_CITY_HARBOR_BUILDINGS_PRODUCTION','MODIFIER_ALL_CITIES_ADJUST_DISTRICT_BUILDING_PRODUCTION', 'PLOT_IS_ADJACENT_COAST_CITY_CENTER_REQUIREMENTS'),
('MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION','MODIFIER_ALL_CITIES_ADJUST_DISTRICT_PRODUCTION', 'PLOT_IS_ADJACENT_COAST_CITY_CENTER_REQUIREMENTS');


--TODO: test that this seg works
--need to add a dynamic modifier for building districts faster for everyone (the buildings in district already exists because thats a world congress effect)
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType)
VALUES ('MODIFIER_ALL_CITIES_ADJUST_DISTRICT_PRODUCTION', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_PRODUCTION_DISTRICT');
INSERT INTO Types (Type, Kind)
VALUES ('MODIFIER_ALL_CITIES_ADJUST_DISTRICT_PRODUCTION', 'KIND_MODIFIER');

--finally decide what values we want
--TODO: test with unique harbors
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES 
('MARITIME_CITY_HARBOR_BUILDINGS_PRODUCTION','Amount',20), --need playtesting to see if this discount is substantial enough
('MARITIME_CITY_HARBOR_BUILDINGS_PRODUCTION','DistrictType', 'DISTRICT_HARBOR'),
('MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION','Amount',20), 
('MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION','DistrictType','DISTRICT_HARBOR');



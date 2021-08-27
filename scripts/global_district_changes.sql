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

--TODO also adjust harbor buildings

--we need to make a new modifier since the only other adjust_district applies to every single district type
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType)
VALUES ('MODIFIER_SINGLE_CITY_ADJUST_SPECIFIC_DISTRICT_PRODUCTION', 'COLLECTION_OWNER', 'EFFECT_ADJUST_DISTRICT_PRODUCTION');
INSERT INTO Types (Type, Kind)
VALUES ('MODIFIER_SINGLE_CITY_ADJUST_SPECIFIC_DISTRICT_PRODUCTION', 'KIND_MODIFIER');

INSERT INTO DistrictModifiers (DistrictType, ModifierId)
VALUES 
('DISTRICT_CITY_CENTER','MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION')
;

INSERT INTO Modifiers (ModifierId, ModifierType,SubjectRequirementSetId)
VALUES 
('MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION','MODIFIER_SINGLE_CITY_ADJUST_SPECIFIC_DISTRICT_PRODUCTION', 'PLOT_IS_ADJACENT_COAST_CITY_CENTER_REQUIREMENTS')
;

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES 
('MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION','Amount',90), 
('MARITIME_CITY_HARBOR_DISTRICT_PRODUCTION','DistrictType','DISTRICT_HARBOR')
;


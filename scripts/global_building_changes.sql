-- global_building_changes
-- Author: Cezas
-- DateCreated: 8/21/2021 3:36:20 PM
--------------------------------------------------------------
UPDATE Buildings SET Cost=70 WHERE BuildingType='BUILDING_WATER_MILL';
UPDATE Buildings SET YieldChange=2 WHERE BuildingType='BUILDING_STABLE' AND YieldType='YIELD_PRODUCTION';
UPDATE Buildings SET YieldChange=2 WHERE BuildingType='BUILDING_BARRACKS' AND YieldType='YIELD_PRODUCTION';
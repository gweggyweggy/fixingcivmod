-- global_building_changes
-- Author: Cezas
-- DateCreated: 8/21/2021 3:36:20 PM
--------------------------------------------------------------

--City Center
--BUG: somerthing wrong with this statement?
--UPDATE Buildings SET Cost=70 WHERE BuildingType='BUILDING_WATER_MILL';

--Encampments
UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType='BUILDING_BARRACKS';
UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType='BUILDING_STABLE';

--Theatre Square
UPDATE Building_YieldChanges SET YieldChange=4 WHERE BuildingType='BUILDING_BROADCAST_CENTER';
UPDATE Buildings_XP2 SET RequiredPower=2 WHERE BuildingType='BUILDING_BROADCAST_CENTER';
-- global_improvement_changes
-- Author: Cezas
-- DateCreated: 9/4/2021 3:52:16 PM
--------------------------------------------------------------
UPDATE Improvements SET PrereqTech='TECH_CASTLES' WHERE ImprovementType='IMPROVEMENT_FORT'; 
UPDATE Improvement_BonusYieldChanges SET BonusYieldChange=2 WHERE PrereqTech='TECH_GUNPOWDER'; 
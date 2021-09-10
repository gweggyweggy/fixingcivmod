-- global_improvement_changes
-- Author: Cezas
-- DateCreated: 9/4/2021 3:52:16 PM
--------------------------------------------------------------
UPDATE Improvements SET PrereqTech='TECH_CASTLES' WHERE ImprovementType='IMPROVEMENT_FORT'; 
UPDATE Improvement_BonusYieldChanges SET BonusYieldChange=2 WHERE PrereqTech='TECH_GUNPOWDER'; 

--attaching the lumber improvement text as a tech description
UPDATE Technologies SET Description='LOC_TECH_MASS_PRODUCTION_DESCRIPTION' WHERE TechnologyType='TECH_MASS_PRODUCTION';
INSERT INTO Improvement_BonusYieldChanges (ImprovementType, YieldType, BonusYieldChange, PrereqTech) VALUES 
	('IMPROVEMENT_LUMBER_MILL','YIELD_PRODUCTION',1,'TECH_MASS_PRODUCTION')
	;
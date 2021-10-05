-- civic_modifiers
-- Author: Cezas
-- DateCreated: 9/14/2021 9:11:01 PM
--------------------------------------------------------------
UPDATE Civics SET Description='LOC_CIVIC_THEOLOGY_DESCRIPTION' WHERE CivicType='CIVIC_THEOLOGY';
UPDATE Civics SET Description='LOC_CIVIC_REFORMED_CHURCH_DESCRIPTION' WHERE CivicType='CIVIC_REFORMED_CHURCH';

--granting spies at these civics
UPDATE Civics SET Description='LOC_CIVIC_POLITICAL_PHILOSOPHY_DESCRIPTION' WHERE CivicType='CIVIC_POLITICAL_PHILOSOPHY';
UPDATE Civics SET Description='LOC_CIVIC_CIVIL_SERVICE_DESCRIPTION' WHERE CivicType='CIVIC_CIVIL_SERVICE';
INSERT INTO CivicModifiers (CivicType, ModifierId) VALUES
	('CIVIC_POLITICAL_PHILOSOPHY','CIVIC_GRANT_SPY'),
	('CIVIC_CIVIL_SERVICE','CIVIC_GRANT_SPY');
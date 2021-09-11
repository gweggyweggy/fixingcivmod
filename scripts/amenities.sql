-- amenities
-- Author: Cezas
-- DateCreated: 9/10/2021 10:14:20 PM
--------------------------------------------------------------

--changing thresholds for amenities to punish rampant warmongering
--these values are highly subject to change, will need a lot of playtesting to find a sweet spot
--although, with entertainment complexes being free, maybe it wont be as bad?
UPDATE Happinesses SET RebellionPoints=0 WHERE HappinessType='HAPPINESS_DISPLEASED';
UPDATE Happinesses SET MinimumAmenityScore=-3, MaximumAmenityScore=-3, RebellionPoints=1 WHERE HappinessType='HAPPINESS_UNHAPPY';
UPDATE Happinesses SET MinimumAmenityScore=-4, MaximumAmenityScore=-4, RebellionPoints=2, GrowthModifier=-50, NonFoodYieldModifier=-40 WHERE HappinessType='HAPPINESS_UNREST';
UPDATE Happinesses SET MinimumAmenityScore=NULL, MaximumAmenityScore=-5, RebellionPoints=3, NonFoodYieldModifier=-50 WHERE HappinessType='HAPPINESS_REVOLT';

--loyalty changes
UPDATE Happinesses_XP1 SET IdentityPerTurnChange=-9 WHERE HappinessType='HAPPINESS_UNREST';
UPDATE Happinesses_XP1 SET IdentityPerTurnChange=-12 WHERE HappinessType='HAPPINESS_REVOLT';
--need to figure out how to readd free amenity to new cities

-- zulu
-- Author: Cezas
-- DateCreated: 9/5/2021 2:47:18 PM
--------------------------------------------------------------
--taking this from BBG directly
UPDATE ModifierArguments SET Value='YIELD_CULTURE' WHERE Name='YieldType' AND ModifierID IN
    ('TRAIT_IKANDA_BARRACKS_SCIENCE', 'TRAIT_IKANDA_STABLE_SCIENCE', 'TRAIT_IKANDA_ARMORY_SCIENCE', 'TRAIT_IKANDA_MILITARY_ACADEMY_SCIENCE');
--==============================================================
--******			  U N I T S  (NON-UNIQUE)			  ******
--==============================================================


-- Melee --
UPDATE Units SET PrereqTech='TECH_MILITARY_ENGINEERING',Cost=180 WHERE UnitType='UNIT_MAN_AT_ARMS'; 
-- Anti-Cav --
UPDATE Units SET Cost=60 WHERE UnitType='UNIT_SPEARMAN';
UPDATE Units SET Cost=160 WHERE UnitType='UNIT_PIKEMAN';
UPDATE Units SET Cost=220 WHERE UnitType='UNIT_PIKE_AND_SHOT'; 

--going to try to make hold the line passive for all anticav, but to a lesser degree

INSERT INTO Modifiers (ModifierId, ModifierType)
VALUES 
('LESSER_HOLD_THE_LINE_BONUS','MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER'),
('LESSER_HOLD_THE_LINE_COMBAT_BONUS','MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH')
;

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES 
('LESSER_HOLD_THE_LINE_BONUS', 'ModifierId', 'LESSER_HOLD_THE_LINE_COMBAT_BONUS'),
('LESSER_HOLD_THE_LINE_COMBAT_BONUS', 'Amount', '20')
;

--establish ability and attach to anticav
INSERT OR IGNORE INTO UnitAbilities (UnitAbilityType, Name, Description,Permanent)
VALUES ('ABILITY_LESSER_HOLD_THE_LINE', 'LOC_ABILITY_LESSER_HOLD_THE_LINE', 'LOC_ABILITY_LESSER_HOLD_THE_LINE', 1);

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
VALUES ('ABILITY_LESSER_HOLD_THE_LINE','LESSER_HOLD_THE_LINE_COMBAT_BONUS'); 

INSERT INTO Types (Type, Kind)
VALUES ('ABILITY_LESSER_HOLD_THE_LINE','KIND_ABILITY');

INSERT INTO TypeTags(Type, Tag)
VALUES ('ABILITY_LESSER_HOLD_THE_LINE', 'CLASS_ANTI_CAVALRY');

--end ability establish


INSERT INTO Traits (TraitType)
VALUES ('TRAIT_MYTEST');
INSERT INTO Types (Type, Kind)
VALUES ('TRAIT_MYTEST','KIND_TRAIT');

INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_MYTEST', 'GRANT_ABILITY_LESSER_HOLD_THE_LINE');

INSERT INTO Modifiers (ModifierId, ModifierType)
VALUES ('GRANT_ABILITY_LESSER_HOLD_THE_LINE', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY');

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('GRANT_ABILITY_LESSER_HOLD_THE_LINE', 'AbilityType', 'ABILITY_LESSER_HOLD_THE_LINE');

-- Recon --
UPDATE Units SET BaseSightRange=3 WHERE PromotionClass='PROMOTION_CLASS_RECON'; 
UPDATE Units SET Cost=90,Combat=25 WHERE UnitType='UNIT_SKIRMISHER'; 
UPDATE Units SET Cost=270,Combat=50,RangedCombat=65 WHERE UnitType='UNIT_RANGER';
UPDATE Units SET Cost=495,Combat=60,RangedCombat=75 WHERE UnitType='UNIT_SPEC_OPS'; 

-- Light Cav --

-- Heavy Cav --
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2,ResourceCost=2 WHERE UnitType='UNIT_TANK'; 
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2,ResourceCost=2 WHERE UnitType='UNIT_MODERN_ARMOR'; 

-- Support --
UPDATE Routes_XP2 SET BuildWithUnitChargeCost=0 WHERE BuildWithUnitChargeCost=1; --NOTTESTED

-- Naval Raider -- 
UPDATE Units SET PrereqCivic='CIVIC_EXPLORATION' WHERE UnitType='UNIT_PRIVATEER';
INSERT OR IGNORE INTO Units_XP2 ( UnitType, ResourceMaintenanceAmount, ResourceCost, ResourceMaintenanceType, CanEarnExperience, CanFormMilitaryFormation)
VALUES ( 'UNIT_NUCLEAR_SUBMARINE', 1, 1, 'RESOURCE_URANIUM', 1, 1);

-- Air --
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2,ResourceCost=2 WHERE UnitType='UNIT_FIGHTER';
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2,ResourceCost=2 WHERE UnitType='UNIT_JET_FIGHTER';
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2,ResourceCost=2 WHERE UnitType='UNIT_BOMBER';
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2,ResourceCost=2 WHERE UnitType='UNIT_JET_BOMBER';

--Warrior Monks--

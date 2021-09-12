--==============================================================
--******			  U N I T S  (NON-UNIQUE)			  ******
--==============================================================


-- Melee --
UPDATE Units SET PrereqTech='TECH_MILITARY_ENGINEERING',Cost=180 WHERE UnitType='UNIT_MAN_AT_ARMS'; 
UPDATE Units SET PrereqTech='TECH_METAL_CASTING' WHERE UnitType='UNIT_MUSKETMAN'; 
UPDATE Units_XP2 SET ResourceMaintenanceAmount=1,ResourceCost=0 WHERE UnitType='UNIT_INFANTRY';
-- Anti-Cav --
UPDATE Units SET Cost=55 WHERE UnitType='UNIT_SPEARMAN';
UPDATE Units SET Cost=160 WHERE UnitType='UNIT_PIKEMAN';
UPDATE Units SET Cost=220 WHERE UnitType='UNIT_PIKE_AND_SHOT'; 


--START ANTICAV BUFF:
--new inherent hold-the-line for all anticav, but only +5 to adjacent noncav units fighting cav
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
	('LESSER_HOLD_THE_LINE_BONUS','MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'HOLD_THE_LINE_REQUIREMENTS'),
	('LESSER_HOLD_THE_LINE_COMBAT_BONUS','MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'ANTI_CAVALRY_OPPONENT_REQUIREMENTS')
	;

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('LESSER_HOLD_THE_LINE_BONUS', 'ModifierId', 'LESSER_HOLD_THE_LINE_COMBAT_BONUS'),
	('LESSER_HOLD_THE_LINE_COMBAT_BONUS', 'Amount', 4)
	;

--establish ability and attach to anticav
INSERT OR IGNORE INTO UnitAbilities (UnitAbilityType, Name, Description,Permanent) VALUES 
	('ABILITY_LESSER_HOLD_THE_LINE', 'LOC_ABILITY_LESSER_HOLD_THE_LINE', 'LOC_ABILITY_LESSER_HOLD_THE_LINE', 1);
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES 
	('ABILITY_LESSER_HOLD_THE_LINE','LESSER_HOLD_THE_LINE_BONUS'); 
INSERT INTO Types (Type, Kind) VALUES 
	('ABILITY_LESSER_HOLD_THE_LINE','KIND_ABILITY');
INSERT INTO TypeTags(Type, Tag) VALUES 
	('ABILITY_LESSER_HOLD_THE_LINE', 'CLASS_ANTI_CAVALRY');
--end ability establish

--having ability apply as a trait to all
INSERT INTO Traits (TraitType) VALUES 
	('TRAIT_INHERENT_HOLD_THE_LINE');
INSERT INTO Types (Type, Kind) VALUES 
	('TRAIT_INHERENT_HOLD_THE_LINE','KIND_TRAIT');
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES 
	('TRAIT_INHERENT_HOLD_THE_LINE', 'GRANT_ABILITY_LESSER_HOLD_THE_LINE');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
	('GRANT_ABILITY_LESSER_HOLD_THE_LINE', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('GRANT_ABILITY_LESSER_HOLD_THE_LINE', 'AbilityType', 'ABILITY_LESSER_HOLD_THE_LINE');

--this stacks btw
INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES 
	('LESSER_HOLD_THE_LINE_COMBAT_BONUS','Preview', 'LOC_ABILITY_LESSER_HOLD_THE_LINE_NAME');
--DONE ANTICAV BUFF


-- Siege --
UPDATE Units SET PrereqTech='TECH_GUNPOWDER' WHERE UnitType='UNIT_BOMBARD'; 


-- Recon --
--new promotion tree

--left side is now ranger->sentry+spyglass->sniper
--right side is now guerrilla+ignorezoc->foragers->camouflage
--final is ambush

--deleting old connections and promotions
DELETE FROM UnitPromotionPrereqs WHERE 
	UnitPromotion='PROMOTION_CAMOUFLAGE' OR PrereqUnitPromotion='PROMOTION_CAMOUFLAGE' OR
	UnitPromotion='PROMOTION_SPYGLASS' OR PrereqUnitPromotion='PROMOTION_SPYGLASS' OR
	UnitPromotion='PROMOTION_GUERRILLA' OR PrereqUnitPromotion='PROMOTION_GUERRILLA' OR
	UnitPromotion='PROMOTION_ALPINE' OR PrereqUnitPromotion='PROMOTION_ALPINE';

DELETE FROM UnitPromotions WHERE 
	UnitPromotionType='PROMOTION_SPYGLASS' OR 
	UnitPromotionType='PROMOTION_ALPINE';



--making new promotions first
--combine spyglass+sentry, and guerrilla now ignores zoc
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SENTRY','SPYGLASS_BONUS_SIGHT'),
	('PROMOTION_GUERRILLA','IGNOREZOC_IGNORE_ZOC')
	;
	;

--new promotion for increased healing in neutral territory
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, PromotionClass, Column) VALUES
	('PROMOTION_SIXFIX_FORAGER','FORAGER','Increased healing in neutral territory.',2,'PROMOTION_CLASS_RECON',3)
	;
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SIXFIX_FORAGER','SIXFIX_RECON_HEAL_BONUS')
	;
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
	('SIXFIX_RECON_HEAL_BONUS', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_RECON_HEAL_BONUS', 'Amount', 10),
	('SIXFIX_RECON_HEAL_BONUS', 'Type', 'NEUTRAL')
	;
INSERT INTO Types (Type, Kind) VALUES 
	('PROMOTION_SIXFIX_FORAGER','KIND_PROMOTION');

--new promotion for increased range (we will also be attaching alpine here)
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, PromotionClass, Column) VALUES
	('PROMOTION_SIXFIX_SNIPER','SNIPER','+1 [ICON_Range] Range.  Faster [ICON_Movement] Movement in Hills.',2,'PROMOTION_CLASS_RECON',3)
	;
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SIXFIX_SNIPER','SIXFIX_RECON_RANGE_BONUS'),
	('PROMOTION_SIXFIX_SNIPER','ALPINE_IGNORE_HILLS_MOVEMENT_PENALTY')
	;
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
	('SIXFIX_RECON_RANGE_BONUS', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_RECON_RANGE_BONUS', 'Amount', 1);
INSERT INTO Types (Type, Kind) VALUES 
	('PROMOTION_SIXFIX_SNIPER','KIND_PROMOTION');


--relink promotions
--left side
--UPDATE UnitPromotions SET Level=1, Column=1 WHERE UnitPromotionType='PROMOTION_RANGER';
UPDATE UnitPromotions SET Level=3, Column=1 WHERE UnitPromotionType='PROMOTION_SIXFIX_SNIPER';
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES
	('PROMOTION_SIXFIX_SNIPER','PROMOTION_SENTRY')
	;

--right side
UPDATE UnitPromotions SET Level=1, Column=3 WHERE UnitPromotionType='PROMOTION_GUERRILLA';
UPDATE UnitPromotions SET Level=2, Column=3 WHERE UnitPromotionType='PROMOTION_SIXFIX_FORAGER';
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES
	('PROMOTION_SIXFIX_FORAGER','PROMOTION_GUERRILLA')
	;
UPDATE UnitPromotions SET Level=3, Column=3 WHERE UnitPromotionType='PROMOTION_CAMOUFLAGE';
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES
	('PROMOTION_CAMOUFLAGE','PROMOTION_SIXFIX_FORAGER')
	;

UPDATE UnitPromotions SET Level=4, Column=2 WHERE UnitPromotionType='PROMOTION_AMBUSH';
DELETE FROM UnitPromotionPrereqs WHERE UnitPromotion='PROMOTION_AMBUSH' OR PrereqUnitPromotion='PROMOTION_AMBUSH';
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES
	('PROMOTION_AMBUSH','PROMOTION_CAMOUFLAGE'),
	('PROMOTION_AMBUSH','PROMOTION_SIXFIX_SNIPER')
	;


--+1 sight to all recon and some other balances
UPDATE Units SET BaseSightRange=3 WHERE PromotionClass='PROMOTION_CLASS_RECON'; 
UPDATE Units SET Cost=110, Combat=25, PrereqTech='TECH_CONSTRUCTION' WHERE UnitType='UNIT_SKIRMISHER'; 
UPDATE Units SET Cost=270, Combat=45, Range=2 WHERE UnitType='UNIT_RANGER';
UPDATE Units SET Cost=495, Combat=60, RangedCombat=75 WHERE UnitType='UNIT_SPEC_OPS'; 

-- Light Cav --
UPDATE Units SET PrereqTech='TECH_STIRRUPS', Cost=190 WHERE UnitType='UNIT_COURSER'; 
UPDATE Units SET Cost=210 WHERE UnitType='UNIT_KNIGHT';
 
-- Heavy Cav --
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2,ResourceCost=2 WHERE UnitType='UNIT_TANK'; 
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2,ResourceCost=2 WHERE UnitType='UNIT_MODERN_ARMOR'; 

-- Support --
UPDATE Routes_XP2 SET BuildWithUnitChargeCost=0 WHERE BuildWithUnitChargeCost=1; --military engineers dont use charges to build roads
DELETE FROM Unit_BuildingPrereqs WHERE Unit='UNIT_MILITARY_ENGINEER';
UPDATE Units SET Cost=200 WHERE UnitType='UNIT_MILITARY_ENGINEER';

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
--deleting old connections and promotions
--DELETE FROM UnitPromotionPrereqs WHERE PrereqUnitPromotion='PROMOTION_SHADOW_STRIKE';
--DELETE FROM UnitPromotionPrereqs WHERE PrereqUnitPromotion='PROMOTION_TWILIGHT_VEIL';


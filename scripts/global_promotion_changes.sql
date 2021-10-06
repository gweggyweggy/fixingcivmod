-- global_promotion_changes
-- Author: Cezas
-- DateCreated: 10/5/2021 8:33:00 PM
--------------------------------------------------------------

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
UPDATE UnitPromotions SET Description='Can attack after moving. Ignore ZOC.' WHERE UnitPromotionType='PROMOTION_GUERRILLA'; 

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


--new promo tree for monks

--deleting old connections and promotions
DELETE FROM UnitPromotionPrereqs WHERE 
	UnitPromotion='PROMOTION_MONK_TWILIGHT_VEIL' OR PrereqUnitPromotion='PROMOTION_MONK_TWILIGHT_VEIL' OR
	UnitPromotion='PROMOTION_MONK_DISCIPLES' OR PrereqUnitPromotion='PROMOTION_MONK_DISCIPLES' OR
	UnitPromotion='PROMOTION_MONK_EXPLODING_PALMS' OR PrereqUnitPromotion='PROMOTION_MONK_EXPLODING_PALMS' OR
	UnitPromotion='PROMOTION_MONK_SHADOW_STRIKE' OR PrereqUnitPromotion='PROMOTION_MONK_SHADOW_STRIKE' OR 
	UnitPromotion='PROMOTION_MONK_SWEEPING_WIND' OR PrereqUnitPromotion='PROMOTION_MONK_SWEEPING_WIND' OR
	UnitPromotion='PROMOTION_MONK_DANCING_CRANE' OR PrereqUnitPromotion='PROMOTION_MONK_DANCING_CRANE' OR  
	UnitPromotion='PROMOTION_MONK_COBRA_STRIKE' OR PrereqUnitPromotion='PROMOTION_MONK_COBRA_STRIKE';
	;

DELETE FROM UnitPromotions WHERE 
	UnitPromotionType='PROMOTION_MONK_SWEEPING_WIND' OR
	UnitPromotionType='PROMOTION_MONK_TWILIGHT_VEIL' OR
	UnitPromotionType='PROMOTION_MONK_DANCING_CRANE' 
	OR UnitPromotionType='PROMOTION_MONK_COBRA_STRIKE'
	;

--	left: (designed for monks to be like cavalry)
--		shadowstrike tier 1:
--			combine with twilight veil
--		naruto run tier 2:
--			ignores rough terrain
--		exploding palms: 
--			also add hussar knockback


--new shadow strike, can simply just combine with twiveil
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_MONK_SHADOW_STRIKE','CAMOUFLAGE_STEALTH');
UPDATE UnitPromotions SET Description='2x flanking bonus.  Only adjacent enemy units can reveal this unit.' WHERE UnitPromotionType='PROMOTION_MONK_SHADOW_STRIKE';

--naruto run promotion
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, PromotionClass, Column) VALUES
	('PROMOTION_SIXFIX_NARUTO_RUN','Naruto Run','Ignore all terrain movement penalties.',2,'PROMOTION_CLASS_MONK',1);
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SIXFIX_NARUTO_RUN','MOD_IGNORE_TERRAIN_COST'),
	('PROMOTION_SIXFIX_NARUTO_RUN','AMPHIBIOUS_BONUS_IGNORE_RIVERS')
	;
INSERT INTO Types (Type, Kind) VALUES 
	('PROMOTION_SIXFIX_NARUTO_RUN','KIND_PROMOTION');

--exploding palms has hussar knockback
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_MONK_EXPLODING_PALMS','HUSSAR_FORCE_RETREAT');
UPDATE UnitPromotions SET Level=3, Description='+10 [ICON_STRENGTH] strength.  Gains Winged Hussar knockback ability.' WHERE UnitPromotionType='PROMOTION_MONK_EXPLODING_PALMS';

--right: (designed for monks to siege cities)
--		disciples tier 1:
--			add monks gain extra healing if in city following ur religion
--			
--		 crusaders tier2:
--			conquistador effect (escort part)
--		
--		 Baptists tier3:
--		conquistador effect (convert part) and killing a unit gives you an postle

--disciples buff
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_MONK_DISCIPLES','SIXFIX_DISCIPLES_HEAL_BONUS');
--not sure if this has to has be your founded religion
UPDATE UnitPromotions SET Level=1, Description='Spread religion to nearby cities on kill.  Additional healing near cities following your religion.' WHERE UnitPromotionType='PROMOTION_MONK_DISCIPLES';
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
	('SIXFIX_DISCIPLES_HEAL_BONUS', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN','SIXFIX_UNIT_NEAR_SAME_RELIGION_CITY_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_DISCIPLES_HEAL_BONUS', 'Amount', 10),
	('SIXFIX_DISCIPLES_HEAL_BONUS', 'Type', 'ALL')
	;
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
	('SIXFIX_UNIT_NEAR_SAME_RELIGION_CITY_REQUIREMENTS', 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
	('SIXFIX_UNIT_NEAR_SAME_RELIGION_CITY_REQUIREMENTS', 'REQUIRES_UNIT_NEAR_FRIENDLY_RELIGIOUS_CITY'),
	('SIXFIX_UNIT_NEAR_SAME_RELIGION_CITY_REQUIREMENTS', 'REQUIRES_UNIT_NEAR_ENEMY_RELIGIOUS_CITY')
	;

--crusaders 
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, PromotionClass, Column) VALUES
	('PROMOTION_SIXFIX_CRUSADERS','Crusaders','+10 [ICON_STRENGTH] Strength when adjacent to a religious unit.',2,'PROMOTION_CLASS_MONK',3);
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SIXFIX_CRUSADERS','CONQUISTADOR_SPECIFIC_UNIT_COMBAT');
	;
INSERT INTO Types (Type, Kind) VALUES 
	('PROMOTION_SIXFIX_CRUSADERS','KIND_PROMOTION');

--baptists
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, PromotionClass, Column) VALUES
	('PROMOTION_SIXFIX_BAPTISTS','Baptists','Conquering a city fully converts it to your religion.  Chance to gain an Apostle after a unit kill.',3,'PROMOTION_CLASS_MONK',3);
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
	('SIXFIX_GET_APOSTLE_FROM_KILL','MODIFIER_UNIT_ADJUST_COMBAT_UNIT_CAPTURE');
INSERT INTO ModifierArguments (ModifierId,Name,Value) VALUES
	('SIXFIX_GET_APOSTLE_FROM_KILL','UnitType','UNIT_APOSTLE'),
	('SIXFIX_GET_APOSTLE_FROM_KILL','CanCapture',1)
	;
INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SIXFIX_BAPTISTS','CONQUISTADOR_CITY_RELIGION_COMBAT'),
	('PROMOTION_SIXFIX_BAPTISTS','SIXFIX_GET_APOSTLE_FROM_KILL')
	;
INSERT INTO Types (Type, Kind) VALUES 
	('PROMOTION_SIXFIX_BAPTISTS','KIND_PROMOTION');

--grandmaster

INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, PromotionClass, Column) VALUES
	('PROMOTION_SIXFIX_GRANDMASTERS','Grandmasters','+10 [ICON_STRENGTH] strength.  +5 [ICON_STRENGTH] strength and +1 [ICON_Movement] movement to adjacent Monks.',4,'PROMOTION_CLASS_MONK',2);

INSERT INTO UnitPromotionModifiers (UnitPromotionType,ModifierId) VALUES
	('PROMOTION_SIXFIX_GRANDMASTERS','SIXFIX_GRANDMASTERS_COMBAT'),
	('PROMOTION_SIXFIX_GRANDMASTERS','SIXFIX_GRANDMASTERS_MOVEMENT')
	;
INSERT INTO Types (Type, Kind) VALUES 
	('PROMOTION_SIXFIX_GRANDMASTERS','KIND_PROMOTION');
INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES 
	('SIXFIX_GRANDMASTERS_COMBAT_BONUS','Preview', 'LOC_SIXFIX_GRANDMASTERS_COMBAT_DESC');

INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
	('SIXFIX_GRANDMASTERS_COMBAT','MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'HOLD_THE_LINE_REQUIREMENTS'),
	('SIXFIX_GRANDMASTERS_MOVEMENT','MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'HOLD_THE_LINE_REQUIREMENTS'),
	('SIXFIX_GRANDMASTERS_COMBAT_BONUS','MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'SIXFIX_UNIT_IS_MONK_REQUIREMENTS'),
	('SIXFIX_GRANDMASTERS_MOVEMENT_BONUS','MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'SIXFIX_UNIT_IS_MONK_REQUIREMENTS')
	;

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_GRANDMASTERS_COMBAT', 'ModifierId', 'SIXFIX_GRANDMASTERS_COMBAT_BONUS'),
	('SIXFIX_GRANDMASTERS_MOVEMENT', 'ModifierId', 'SIXFIX_GRANDMASTERS_MOVEMENT_BONUS'),
	('SIXFIX_GRANDMASTERS_COMBAT_BONUS', 'Amount', 5),
	('SIXFIX_GRANDMASTERS_MOVEMENT_BONUS','Amount', 1)
	;


--LINKING promotions
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES
	('PROMOTION_SIXFIX_NARUTO_RUN','PROMOTION_MONK_SHADOW_STRIKE'),
	('PROMOTION_MONK_EXPLODING_PALMS','PROMOTION_SIXFIX_NARUTO_RUN'),
	('PROMOTION_SIXFIX_CRUSADERS','PROMOTION_MONK_DISCIPLES'),
	('PROMOTION_SIXFIX_BAPTISTS','PROMOTION_SIXFIX_CRUSADERS'),
	('PROMOTION_SIXFIX_GRANDMASTERS','PROMOTION_SIXFIX_BAPTISTS'),
	('PROMOTION_SIXFIX_GRANDMASTERS','PROMOTION_MONK_EXPLODING_PALMS')
	;

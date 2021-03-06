-- policies
-- Author: Cezas
-- DateCreated: 9/9/2021 9:20:39 PM
--------------------------------------------------------------

--MILITARY--

--new production cards for siege and supports

--defining the modifiers here
INSERT INTO PolicyModifiers (PolicyType, ModifierId) VALUES
	('POLICY_SIXFIX_SIEGE_TRAINS','SIXFIX_SIEGE_TRAINS_ANCIENT_SUPPORT_PRODUCTION'),
	('POLICY_SIXFIX_SIEGE_TRAINS','SIXFIX_SIEGE_TRAINS_ANCIENT_SIEGE_PRODUCTION'),
	('POLICY_SIXFIX_SIEGE_TRAINS','SIXFIX_SIEGE_TRAINS_CLASSICAL_SUPPORT_PRODUCTION'),
	('POLICY_SIXFIX_SIEGE_TRAINS','SIXFIX_SIEGE_TRAINS_CLASSICAL_SIEGE_PRODUCTION'),
	
	('POLICY_SIXFIX_FOUNDRIES','SIXFIX_SIEGE_TRAINS_ANCIENT_SUPPORT_PRODUCTION'),
	('POLICY_SIXFIX_FOUNDRIES','SIXFIX_SIEGE_TRAINS_ANCIENT_SIEGE_PRODUCTION'),
	('POLICY_SIXFIX_FOUNDRIES','SIXFIX_SIEGE_TRAINS_CLASSICAL_SUPPORT_PRODUCTION'),
	('POLICY_SIXFIX_FOUNDRIES','SIXFIX_SIEGE_TRAINS_CLASSICAL_SIEGE_PRODUCTION'),
	('POLICY_SIXFIX_FOUNDRIES','SIXFIX_FOUNDRIES_MEDIEVAL_SUPPORT_PRODUCTION'),
	('POLICY_SIXFIX_FOUNDRIES','SIXFIX_FOUNDRIES_MEDIEVAL_SIEGE_PRODUCTION'),
	('POLICY_SIXFIX_FOUNDRIES','SIXFIX_FOUNDRIES_RENAISSANCE_SUPPORT_PRODUCTION'),
	('POLICY_SIXFIX_FOUNDRIES','SIXFIX_FOUNDRIES_RENAISSANCE_SIEGE_PRODUCTION'),

	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_SIEGE_TRAINS_ANCIENT_SUPPORT_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_SIEGE_TRAINS_ANCIENT_SIEGE_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_SIEGE_TRAINS_CLASSICAL_SUPPORT_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_SIEGE_TRAINS_CLASSICAL_SIEGE_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_FOUNDRIES_MEDIEVAL_SUPPORT_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_FOUNDRIES_MEDIEVAL_SIEGE_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_FOUNDRIES_RENAISSANCE_SUPPORT_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_FOUNDRIES_RENAISSANCE_SIEGE_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_WAR_MACHINES_INDUSTRIAL_SUPPORT_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_WAR_MACHINES_INDUSTRIAL_SIEGE_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_WAR_MACHINES_MODERN_SUPPORT_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_WAR_MACHINES_MODERN_SIEGE_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_WAR_MACHINES_ATOMIC_SUPPORT_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_WAR_MACHINES_ATOMIC_SIEGE_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_WAR_MACHINES_INFORMATION_SUPPORT_PRODUCTION'),
	('POLICY_SIXFIX_WAR_MACHINES','SIXFIX_WAR_MACHINES_INFORMATION_SIEGE_PRODUCTION')
	;

INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
	('SIXFIX_SIEGE_TRAINS_ANCIENT_SUPPORT_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('SIXFIX_SIEGE_TRAINS_ANCIENT_SIEGE_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('SIXFIX_SIEGE_TRAINS_CLASSICAL_SUPPORT_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('SIXFIX_SIEGE_TRAINS_CLASSICAL_SIEGE_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),

	('SIXFIX_FOUNDRIES_MEDIEVAL_SUPPORT_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('SIXFIX_FOUNDRIES_MEDIEVAL_SIEGE_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('SIXFIX_FOUNDRIES_RENAISSANCE_SUPPORT_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('SIXFIX_FOUNDRIES_RENAISSANCE_SIEGE_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),

	('SIXFIX_WAR_MACHINES_INDUSTRIAL_SUPPORT_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('SIXFIX_WAR_MACHINES_INDUSTRIAL_SIEGE_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('SIXFIX_WAR_MACHINES_MODERN_SUPPORT_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('SIXFIX_WAR_MACHINES_MODERN_SIEGE_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('SIXFIX_WAR_MACHINES_ATOMIC_SUPPORT_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('SIXFIX_WAR_MACHINES_ATOMIC_SIEGE_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('SIXFIX_WAR_MACHINES_INFORMATION_SUPPORT_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('SIXFIX_WAR_MACHINES_INFORMATION_SIEGE_PRODUCTION','MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION')
	;

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_SIEGE_TRAINS_ANCIENT_SUPPORT_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SUPPORT'),
	('SIXFIX_SIEGE_TRAINS_ANCIENT_SUPPORT_PRODUCTION', 'EraType', 'ERA_ANCIENT'),
	('SIXFIX_SIEGE_TRAINS_ANCIENT_SUPPORT_PRODUCTION', 'Amount', '25'),
	('SIXFIX_SIEGE_TRAINS_ANCIENT_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE'),
	('SIXFIX_SIEGE_TRAINS_ANCIENT_SIEGE_PRODUCTION', 'EraType', 'ERA_ANCIENT'),
	('SIXFIX_SIEGE_TRAINS_ANCIENT_SIEGE_PRODUCTION', 'Amount', '25'),
	('SIXFIX_SIEGE_TRAINS_CLASSICAL_SUPPORT_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SUPPORT'),
	('SIXFIX_SIEGE_TRAINS_CLASSICAL_SUPPORT_PRODUCTION', 'EraType', 'ERA_CLASSICAL'),
	('SIXFIX_SIEGE_TRAINS_CLASSICAL_SUPPORT_PRODUCTION', 'Amount', '25'),
	('SIXFIX_SIEGE_TRAINS_CLASSICAL_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE'),
	('SIXFIX_SIEGE_TRAINS_CLASSICAL_SIEGE_PRODUCTION', 'EraType', 'ERA_CLASSICAL'),
	('SIXFIX_SIEGE_TRAINS_CLASSICAL_SIEGE_PRODUCTION', 'Amount', '25'),

	('SIXFIX_FOUNDRIES_MEDIEVAL_SUPPORT_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SUPPORT'),
	('SIXFIX_FOUNDRIES_MEDIEVAL_SUPPORT_PRODUCTION', 'EraType', 'ERA_MEDIEVAL'),
	('SIXFIX_FOUNDRIES_MEDIEVAL_SUPPORT_PRODUCTION', 'Amount', '25'),
	('SIXFIX_FOUNDRIES_MEDIEVAL_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE'),
	('SIXFIX_FOUNDRIES_MEDIEVAL_SIEGE_PRODUCTION', 'EraType', 'ERA_MEDIEVAL'),
	('SIXFIX_FOUNDRIES_MEDIEVAL_SIEGE_PRODUCTION', 'Amount', '25'),
	('SIXFIX_FOUNDRIES_RENAISSANCE_SUPPORT_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SUPPORT'),
	('SIXFIX_FOUNDRIES_RENAISSANCE_SUPPORT_PRODUCTION', 'EraType', 'ERA_RENAISSANCE'),
	('SIXFIX_FOUNDRIES_RENAISSANCE_SUPPORT_PRODUCTION', 'Amount', '25'),
	('SIXFIX_FOUNDRIES_RENAISSANCE_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE'),
	('SIXFIX_FOUNDRIES_RENAISSANCE_SIEGE_PRODUCTION', 'EraType', 'ERA_RENAISSANCE'),
	('SIXFIX_FOUNDRIES_RENAISSANCE_SIEGE_PRODUCTION', 'Amount', '25'),

	('SIXFIX_WAR_MACHINES_INDUSTRIAL_SUPPORT_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SUPPORT'),
	('SIXFIX_WAR_MACHINES_INDUSTRIAL_SUPPORT_PRODUCTION', 'EraType', 'ERA_INDUSTRIAL'),
	('SIXFIX_WAR_MACHINES_INDUSTRIAL_SUPPORT_PRODUCTION', 'Amount', '25'),
	('SIXFIX_WAR_MACHINES_INDUSTRIAL_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE'),
	('SIXFIX_WAR_MACHINES_INDUSTRIAL_SIEGE_PRODUCTION', 'EraType', 'ERA_INDUSTRIAL'),
	('SIXFIX_WAR_MACHINES_INDUSTRIAL_SIEGE_PRODUCTION', 'Amount', '25'),
	('SIXFIX_WAR_MACHINES_MODERN_SUPPORT_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SUPPORT'),
	('SIXFIX_WAR_MACHINES_MODERN_SUPPORT_PRODUCTION', 'EraType', 'ERA_MODERN'),
	('SIXFIX_WAR_MACHINES_MODERN_SUPPORT_PRODUCTION', 'Amount', '25'),
	('SIXFIX_WAR_MACHINES_MODERN_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE'),
	('SIXFIX_WAR_MACHINES_MODERN_SIEGE_PRODUCTION', 'EraType', 'ERA_MODERN'),
	('SIXFIX_WAR_MACHINES_MODERN_SIEGE_PRODUCTION', 'Amount', '25'),
	('SIXFIX_WAR_MACHINES_ATOMIC_SUPPORT_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SUPPORT'),
	('SIXFIX_WAR_MACHINES_ATOMIC_SUPPORT_PRODUCTION', 'EraType', 'ERA_ATOMIC'),
	('SIXFIX_WAR_MACHINES_ATOMIC_SUPPORT_PRODUCTION', 'Amount', '25'),
	('SIXFIX_WAR_MACHINES_ATOMIC_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE'),
	('SIXFIX_WAR_MACHINES_ATOMIC_SIEGE_PRODUCTION', 'EraType', 'ERA_ATOMIC'),
	('SIXFIX_WAR_MACHINES_ATOMIC_SIEGE_PRODUCTION', 'Amount', '25'),
	('SIXFIX_WAR_MACHINES_INFORMATION_SUPPORT_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SUPPORT'),
	('SIXFIX_WAR_MACHINES_INFORMATION_SUPPORT_PRODUCTION', 'EraType', 'ERA_INFORMATION'),
	('SIXFIX_WAR_MACHINES_INFORMATION_SUPPORT_PRODUCTION', 'Amount', '25'),
	('SIXFIX_WAR_MACHINES_INFORMATION_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE'),
	('SIXFIX_WAR_MACHINES_INFORMATION_SIEGE_PRODUCTION', 'EraType', 'ERA_INFORMATION'),
	('SIXFIX_WAR_MACHINES_INFORMATION_SIEGE_PRODUCTION', 'Amount', '25')
	;


--add policies here
INSERT INTO Policies (PolicyType, Description, PrereqCivic, Name, GovernmentSlotType) VALUES
	('POLICY_SIXFIX_SIEGE_TRAINS','LOC_POLICY_SIXFIX_SIEGE_TRAINS_DESCRIPTION','CIVIC_MILITARY_TRAINING','LOC_POLICY_SIXFIX_SIEGE_TRAINS_NAME','SLOT_MILITARY'),
	('POLICY_SIXFIX_FOUNDRIES','LOC_POLICY_SIXFIX_FOUNDRIES_DESCRIPTION','CIVIC_MEDIEVAL_FAIRES','LOC_POLICY_SIXFIX_FOUNDRIES_NAME','SLOT_MILITARY'),
	('POLICY_SIXFIX_WAR_MACHINES','LOC_POLICY_SIXFIX_WAR_MACHINES_DESCRIPTION','CIVIC_MOBILIZATION','LOC_POLICY_SIXFIX_WAR_MACHINES_NAME','SLOT_MILITARY')
	;

INSERT INTO Types (Type, Kind) VALUES 
	('POLICY_SIXFIX_SIEGE_TRAINS','KIND_POLICY'),
	('POLICY_SIXFIX_FOUNDRIES','KIND_POLICY'),
	('POLICY_SIXFIX_WAR_MACHINES','KIND_POLICY')
	;

INSERT INTO ObsoletePolicies (PolicyType, ObsoletePolicy) VALUES
	('POLICY_SIXFIX_SIEGE_TRAINS','POLICY_SIXFIX_FOUNDRIES'),
	('POLICY_SIXFIX_FOUNDRIES','POLICY_SIXFIX_WAR_MACHINES')
	;

--ECONOMIC--

--DIPLO--

--WILD--

--DARK--
--updating twilight valor to affect warrior monks
INSERT INTO TypeTags (Type, Tag) VALUES
	('ABILITY_TWILIGHT_VALOR_ATTACK_BONUS','CLASS_WARRIOR_MONK');
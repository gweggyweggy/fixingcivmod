-- tech_modifiers
-- Author: Cezas
-- DateCreated: 9/9/2021 3:54:54 PM
--------------------------------------------------------------

--siege tactics
--player gets +5 to city strike attacks, units gain +5 attacking and defending against cities
--not sure if i want to add +5 to city defense, defender is already favored in the game
INSERT OR IGNORE INTO TechnologyModifiers (TechnologyType, ModifierId) VALUES 
	('TECH_SIEGE_TACTICS', 'SIXFIX_SIEGETACTICS_CITY_STRIKE_ATTACK_BONUS'),
	('TECH_SIEGE_TACTICS', 'SIXFIX_SIEGETACTICS_UNIT_ATTACK_BONUS'),
	('TECH_SIEGE_TACTICS', 'SIXFIX_SIEGETACTICS_UNIT_DEFEND_BONUS')
	;

INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
	('SIXFIX_SIEGETACTICS_CITY_STRIKE_ATTACK_BONUS', 'MODIFIER_PLAYER_CITIES_ADJUST_RANGED_STRIKE')
	;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
	('SIXFIX_SIEGETACTICS_UNIT_ATTACK_BONUS', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH','UNIT_ATTACKING_DISTRICT_REQUIREMENTS'),
	('SIXFIX_SIEGETACTICS_UNIT_DEFEND_BONUS', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH','EMPLACEMENT_REQUIREMENTS')
	;

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
	('SIXFIX_SIEGETACTICS_UNIT_ATTACK_BONUS', 'Amount', 5),
	('SIXFIX_SIEGETACTICS_CITY_STRIKE_ATTACK_BONUS', 'Amount', 5),
	('SIXFIX_SIEGETACTICS_UNIT_DEFEND_BONUS', 'Amount', 5)
	;
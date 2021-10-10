-- sweden
-- Author: Cezas
-- DateCreated: 10/9/2021 10:05:17 PM
--------------------------------------------------------------
INSERT INTO Modifiers (ModifierId, ModifierType,Repeatable) VALUES
	--('SIXFIX_SWEDEN_ACCUMULATIVE_GPP','MODIFIER_PLAYER_ADJUST_FREE_GREAT_PERSON_POINTS',1),
	('SIXFIX_TECH_BOOST_ON_PROPHET_RECRUIT','MODIFIER_PLAYER_GRANT_BOOST_WITH_GREAT_PERSON',1),
	('SIXFIX_TECH_BOOST_ON_WRITER_RECRUIT','MODIFIER_PLAYER_GRANT_BOOST_WITH_GREAT_PERSON',1),
	('SIXFIX_TECH_BOOST_ON_ARTIST_RECRUIT','MODIFIER_PLAYER_GRANT_BOOST_WITH_GREAT_PERSON',1),
	('SIXFIX_TECH_BOOST_ON_MUSICIAN_RECRUIT','MODIFIER_PLAYER_GRANT_BOOST_WITH_GREAT_PERSON',1)
	;

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	--('SIXFIX_SWEDEN_ACCUMULATIVE_GPP', 'Amount', 1),
	('SIXFIX_TECH_BOOST_ON_WRITER_RECRUIT','GreatPersonClass','GREAT_PERSON_CLASS_WRITER'),
	('SIXFIX_TECH_BOOST_ON_WRITER_RECRUIT','TechBoost',1),
	('SIXFIX_TECH_BOOST_ON_WRITER_RECRUIT','OtherPlayers',0),

	('SIXFIX_TECH_BOOST_ON_ARTIST_RECRUIT','GreatPersonClass','GREAT_PERSON_CLASS_ARTIST'),
	('SIXFIX_TECH_BOOST_ON_ARTIST_RECRUIT','TechBoost',1),
	('SIXFIX_TECH_BOOST_ON_ARTIST_RECRUIT','OtherPlayers',0),

	('SIXFIX_TECH_BOOST_ON_MUSICIAN_RECRUIT','GreatPersonClass','GREAT_PERSON_CLASS_MUSICIAN'),
	('SIXFIX_TECH_BOOST_ON_MUSICIAN_RECRUIT','TechBoost',1),
	('SIXFIX_TECH_BOOST_ON_MUSICIAN_RECRUIT','OtherPlayers',0),

	('SIXFIX_TECH_BOOST_ON_PROPHET_RECRUIT','GreatPersonClass','GREAT_PERSON_CLASS_PROPHET'),
	('SIXFIX_TECH_BOOST_ON_PROPHET_RECRUIT','TechBoost',1),
	('SIXFIX_TECH_BOOST_ON_PROPHET_RECRUIT','OtherPlayers',0)
	;


INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
	--('TRAIT_CIVILIZATION_NOBEL_PRIZE','SIXFIX_SWEDEN_ACCUMULATIVE_GPP'), --this needs to be linked to great person recruit
	('TRAIT_CIVILIZATION_NOBEL_PRIZE','SIXFIX_TECH_BOOST_ON_WRITER_RECRUIT'),
	('TRAIT_CIVILIZATION_NOBEL_PRIZE','SIXFIX_TECH_BOOST_ON_ARTIST_RECRUIT'),
	('TRAIT_CIVILIZATION_NOBEL_PRIZE','SIXFIX_TECH_BOOST_ON_MUSICIAN_RECRUIT'),
	('TRAIT_CIVILIZATION_NOBEL_PRIZE','SIXFIX_TECH_BOOST_ON_PROPHET_RECRUIT')
	;

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES 
	('TRAIT_LEADER_KRISTINA_AUTO_THEME', 'TRAIT_DOUBLE_WRITER_POINTS'),
	('TRAIT_LEADER_KRISTINA_AUTO_THEME', 'TRAIT_DOUBLE_ARTIST_POINTS'),
	('TRAIT_LEADER_KRISTINA_AUTO_THEME', 'TRAIT_DOUBLE_MUSICIAN_POINTS')
	; 
--==============================================================
--******			  U N I T S  (NON-UNIQUE)			  ******
--==============================================================

-- Melee --
UPDATE Units SET PrereqTech='TECH_MILITARY_ENGINEERING', Cost=180 WHERE UnitType='UNIT_MAN_AT_ARMS'; 
UPDATE Units_XP2 SET ResourceMaintenanceAmount=0, ResourceCost=20 WHERE UnitType='UNIT_INFANTRY';

-- Anti-Cav --
UPDATE Units SET Cost=160 WHERE UnitType='UNIT_PIKEMAN';
UPDATE Units SET Cost=220 WHERE UnitType='UNIT_PIKE_AND_SHOT'; 
--UPDATE Units SET Combat=80 WHERE UnitType='UNIT_AT_CREW'; 
--UPDATE Units SET Combat=90 WHERE UnitType='UNIT_MODERN_AT'; 
-- concept, adjacent enemy cav lose 5 combat strength

-- Recon --
--will probably add more sophisticated buff to these guys, maybe adjust their promotion trees
--intended promotion tree, Woodwalker AND Guerilla -> Ambush -> +1 range OR Camouflage 
UPDATE Units SET BaseSightRange=3 WHERE PromotionClass='PROMOTION_CLASS_RECON'; 
--production costs for these recon units are calculated as "earlier ranged unit cost * 1.5) i.e. Archer(60) -> Skirmisher(90)
UPDATE Units SET Cost=90 WHERE UnitType='UNIT_SKIRMISHER'; 
UPDATE Units SET Cost=270 WHERE UnitType='UNIT_RANGER';
UPDATE Units SET Cost=495, RangedCombat=75 WHERE UnitType='UNIT_SPEC_OPS'; 


-- Light Cav --
UPDATE Units_XP2 SET ResourceMaintenanceAmount=0, ResourceCost=20 WHERE UnitType='UNIT_HELICOPTER';
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2, ResourceCost=10 WHERE UnitType='UNIT_TANK'; 

-- Heavy Cav --
UPDATE Units_XP2 SET ResourceMaintenanceAmount=2, ResourceCost=10 WHERE UnitType='UNIT_MODERN_ARMOR'; 

-- Support --
--UPDATE Unit_BuildingPrereqs SET PrereqBuilding='BUILDING_BARRACKS' WHERE Unit='UNIT_MILITARY_ENGINEER'; --NOTTESTED
UPDATE Routes_XP2 SET BuildWithUnitChargeCost=0 WHERE BuildWithUnitChargeCost=1; --NOTTESTED

-- Naval Raider -- 
UPDATE Units SET PrereqCivic='CIVIC_EXPLORATION' WHERE UnitType='UNIT_PRIVATEER'; --NOTTESTED

-- Air --
--todo, make air maintenance 2 alum
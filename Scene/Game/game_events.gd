extends Node

signal exp_vial_collected(number: float)
signal skill_upgrade_added(upgrade: SkillUpgrade, current_upgrades: Dictionary)

func emit_exp_vial_collected(number: float):
	exp_vial_collected.emit(number)
	

func emit_skill_upgrade_added(upgrade: SkillUpgrade, current_upgrades: Dictionary):
	skill_upgrade_added.emit(upgrade, current_upgrades)
	

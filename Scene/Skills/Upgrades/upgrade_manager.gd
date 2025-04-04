extends Node

@export var upgrade_pool: Array[SkillUpgrade]
@export var exp_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

func _ready():
	exp_manager.lvl_up.connect(on_lvl_up)
	
func on_lvl_up(current_lvl: int):
	var chosen_upgrade = upgrade_pool.pick_random()
	if chosen_upgrade == null:
		return
	
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_skill_upgrades([chosen_upgrade] as Array[SkillUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)

func apply_upgrade(upgrade: SkillUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
		
	GameEvents.emit_skill_upgrade_added(upgrade, current_upgrades)

func on_upgrade_selected(upgrade: SkillUpgrade):
	apply_upgrade(upgrade)

extends CanvasLayer

signal upgrade_selected(upgrade: SkillUpgrade)

@export var upgrade_card_scene: PackedScene

@onready var card_container: HBoxContainer = $%CardContainer

func _ready():
	get_tree().paused = true

func set_skill_upgrades(upgrades: Array[SkillUpgrade]):
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.set_skill_upgrade(upgrade)
		card_instance.selected.connect(on_upgrade_selected.bind(upgrade))

func on_upgrade_selected(upgrade: SkillUpgrade):
	upgrade_selected.emit(upgrade)
	get_tree().paused = false
	queue_free()

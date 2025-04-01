extends Node

class_name HealthComponent

signal died
signal hp_changed

@export var max_hp: float = 10

var current_hp

func _ready():
	current_hp = max_hp

func damage(damage_amount: float):
	current_hp = max(current_hp - damage_amount, 0)
	hp_changed.emit()
	Callable(check_death).call_deferred()

func get_hp_percent():
	if max_hp <= 0:
		return 0
	return min(current_hp / max_hp, 1)

func check_death():
	if current_hp == 0:
		died.emit()
		owner.queue_free()

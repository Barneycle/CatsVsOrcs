extends Node2D

func _ready():
	$Area2D.area_entered.connect(on_area_entered)

func on_area_entered(other_area: Node2D):
	GameEvents.emit_exp_vial_collected(1)
	queue_free()

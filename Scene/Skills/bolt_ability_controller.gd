extends Node

@export var bolt_ability: PackedScene
var projectile_manager: Node

func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	# Find the ProjectileManager for recycling
	projectile_manager = get_tree().get_root().get_node("ProjectileManager")

func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	if projectile_manager == null:
		print("Error: ProjectileManager not found!")
		return

	var num_projectiles = 12
	var angle_step = TAU / num_projectiles

	for i in range(num_projectiles):
		var angle = i * angle_step
		var direction = Vector2(cos(angle), sin(angle))

		# ✅ Use the projectile manager to spawn projectiles
		projectile_manager.spawn_projectile("bolt", player.global_position, direction, 200.0)

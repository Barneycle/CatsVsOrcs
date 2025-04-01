extends Node

@export var initial_pool_size: int = 15
@export var max_pool_size: int = 60

# Only use the bolt_scene for now
@export var bolt_scene: PackedScene

# Projectiles pool (only using bolt for now)
var pool: Dictionary = {
	"bolt": []
}

# Active projectiles
var projectiles: Array = [] 

func _ready():
	# Initialize pool for bolt projectile
	initialize_pool("bolt", bolt_scene)

func initialize_pool(type: String, scene: PackedScene):
	for i in range(initial_pool_size):
		add_projectile_to_pool(type, scene)

func add_projectile_to_pool(type: String, scene: PackedScene):
	if pool[type].size() >= max_pool_size:
		return

	var proj = scene.instantiate()
	proj.hide()
	proj.set_process(false)
	proj.set_physics_process(false)
	add_child(proj)
	pool[type].append(proj)

func spawn_projectile(type: String, position: Vector2, direction: Vector2, speed: float) -> Node:
	var proj
	
	if pool[type].size() > 0:
		proj = pool[type].pop_front()
		print("♻️ Reusing projectile of type:", type)
	else:
		var scene = get_projectile_scene(type)
		proj = scene.instantiate()
		print("✨ Spawning new projectile of type:", type)
		add_child(proj)

	# ✅ Connect signal if not already connected
	if not proj.hit_target.is_connected(_on_projectile_hit):
		proj.hit_target.connect(_on_projectile_hit)

	# Initialize projectile
	proj.initialize_projectile(position, direction, speed, type)

	# Add to active projectiles
	projectiles.append(proj)
	proj.set_process(true)
	proj.set_physics_process(true)
	proj.show()

	return proj

# 🔥 This function will be triggered when a projectile hits an enemy
func _on_projectile_hit(proj: Node):
	recycle_projectile(proj)

func get_projectile_scene(type: String) -> PackedScene:
	match type:
		"bolt": return bolt_scene
		_ : return null  # Placeholder for future projectile types

func recycle_projectile(proj: Node2D):
	var type = proj.get("projectile_type") if proj.has_method("get") else "none"
	print("♻️ Recycling projectile of type:", type)

	if type != "none":
		pool[type].append(proj)
		proj.hide()
		proj.set_process(false)
		proj.set_physics_process(false)

	projectiles.erase(proj)

extends Area2D

signal hit_target

@export var speed: float = 200.0
@export var max_distance: float = 500.0
@export var projectile_type: String = "bolt"

var direction: Vector2 = Vector2.RIGHT
var start_position: Vector2
var velocity: Vector2 = Vector2.ZERO
var manager: Node = null

func _ready():
	start_position = global_position
	z_index = 10
	manager = get_tree().get_root().get_node("ProjectileManager")

func _process(delta):
	global_position += direction * speed * delta
	if global_position.distance_to(start_position) >= max_distance:
		recycle()

# ✅ Emit signal when hitting an enemy
func _on_body_entered(body):
	if body.is_in_group("enemy"):
		emit_signal("hit_target", self)  # Notify manager
		recycle()  # Recycle immediately after hit

func recycle():
	if manager:
		manager.recycle_projectile(self)

func initialize_projectile(pos: Vector2, dir: Vector2, spd: float, type: String):
	position = pos
	direction = dir
	speed = spd
	projectile_type = type

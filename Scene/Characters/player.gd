extends CharacterBody2D

const MAX_SPEED = 150
const ACCELERATION_SMOOTHING = 25

@onready var dps = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var hp_bar = $HpBar

var num_colliding_bodies = 0

func _ready():
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	dps.timeout.connect(on_dps_timeout)
	health_component.hp_changed.connect(on_hp_changed)
	update_hp_display()

func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	var target_velocity = direction * MAX_SPEED
	
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()

func get_movement_vector(): 
	var x_movement = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_movement = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	return Vector2(x_movement, y_movement)

func check_deal_damage():
	if num_colliding_bodies == 0 || !dps.is_stopped():
		return
	health_component.damage(1)
	dps.start()

func update_hp_display():
	hp_bar.value = health_component.get_hp_percent()

func on_body_entered(other_body: Node2D):
	num_colliding_bodies += 1
	check_deal_damage()

func on_body_exited(other_body: Node2D):
	num_colliding_bodies -= 1

func on_dps_timeout():
	check_deal_damage()
	
func on_hp_changed():
	update_hp_display()

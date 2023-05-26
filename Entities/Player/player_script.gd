extends RigidBody2D
class_name Player

@export var FLAP_FORCE = -200

const MAX_ROTATION_DEGRESS = -30.0

var is_started = false
var is_alive = true
var animator

func _ready():
	animator = $AnimationPlayer

func _physics_process(delta):
	if is_started:
		if is_alive and Input.is_action_just_pressed("flap"):
			flap()
		if rotation_degrees <= MAX_ROTATION_DEGRESS:
			angular_velocity = 0
			rotation_degrees = MAX_ROTATION_DEGRESS
		
		if linear_velocity.y > 0:
			if rotation_degrees <= 90.0:
				angular_velocity = 3
			else:
				angular_velocity = 0

func flap():
	linear_velocity.y = FLAP_FORCE
	angular_velocity = -12
	$Wing.play()
		
func start():
	is_started = true
	gravity_scale = 0.5
	animator.play("flap")
	
func die():
	animator.stop()
	is_alive = false
	$Hit.play()

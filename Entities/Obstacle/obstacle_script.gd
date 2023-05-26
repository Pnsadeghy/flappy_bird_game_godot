extends Node2D

const SPEED = 200

signal hit
signal score

var is_enabled = true

func _physics_process(delta):
	if is_enabled:
		position.x += -SPEED * delta
	
	if global_position.x <= -SPEED:
		queue_free()
		
func player_hit(body):
	if is_enabled and body is Player:
		hit.emit()

func player_pass(body):
	if body is Player:
		score.emit()
		
func disabled():
	is_enabled = false

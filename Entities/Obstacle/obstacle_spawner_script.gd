extends Node2D

signal hit
signal score

var Obstacle = preload("res://Entities/Obstacle/obstacle.tscn")

func _ready():
	randomize()

func spawn_obstacle():
	var obstacle = Obstacle.instantiate()
	add_child(obstacle)
	obstacle.position.y = randi_range(150, 550)
	obstacle.connect("hit", on_hit)
	obstacle.connect("score", on_score)
	
func on_hit():
	hit.emit()
	
func on_die():
	$Timer.stop()
	get_tree().call_group("obstacles", "disabled")

func on_score():
	score.emit()
	$ScoreAudio.play()

func _on_timer_timeout():
	spawn_obstacle()
	
func start():
	$Timer.start()

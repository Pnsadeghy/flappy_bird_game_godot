extends Node2D

var is_started = false
var is_die = false
var score = 0
var high_score = 0

const SAVE_FILE_PATH = "user://savedata.save"
		
func _ready():
	load_highscore()
		
func start():
	is_started = true
	$Player.start()
	$ObstacleSpawner.start()

func _on_obstacle_spawner_score():
	score += 1
	$HUD.set_score(score)

func _on_dead_zone_body_entered(body):
	if body is Player:
		die()

func die():
	if is_die: return
	is_die = true
	$Player.die()
	$ObstacleSpawner.on_die()
	$Ground/AnimationPlayer.stop()
	
	if score > high_score:
		high_score = score
		
	save_highscore()
	
	$Menu.game_over(score, high_score)

func _on_obstacle_spawner_hit():
	die()
	
func save_highscore():
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	save_data.store_var(high_score)
	save_data.close()
	
func load_highscore():
	if !FileAccess.file_exists(SAVE_FILE_PATH): return
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	high_score = save_data.get_var()
	save_data.close()

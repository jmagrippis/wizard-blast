extends Node

@export var mob_scene: PackedScene
@export var explosion_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func game_over():
	$GameOverSFX.play()
	var explosion = explosion_scene.instantiate()
	explosion.global_position = $Player.global_position
	add_child(explosion)
	
	slow_mo(0.05, 0.3)
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	


func new_game():
	score = 0
	$Music.play()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	get_tree().call_group("mobs", "queue_free")
	

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	$HUD.hide_message()


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
	
func slow_mo(time_scale, duration):
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration).timeout
	Engine.time_scale = 1




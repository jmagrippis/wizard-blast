extends CanvasLayer

signal start_game


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func show_message(text):
	$Message.text = text
	$Message.show()
	
func hide_message():
	$Message.hide()
	
func show_game_over():
	show_message("Game Over")
	# wait for slow_mo to finish
	await get_tree().create_timer(0.3).timeout

	$Message.text = "Should have DODGED!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(0.3).timeout
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_message_timer_timeout():
	$Message.hide()


func _on_start_button_pressed():
	$StartButton.hide()
	emit_signal("start_game")

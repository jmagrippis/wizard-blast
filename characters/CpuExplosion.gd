extends CPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	one_shot = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_time_to_live_timer_timeout():
	queue_free() # Replace with function body.

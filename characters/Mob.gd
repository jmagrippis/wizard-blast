extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2d.playing = true
	var mob_types = $AnimatedSprite2d.frames.get_animation_names()
	$AnimatedSprite2d.animation = mob_types[randi() % mob_types.size()]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

extends Area2D
signal hit
@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2d.play()
	else:
		$AnimatedSprite2d.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite2d.animation = "walk"
		$AnimatedSprite2d.flip_v = false
		$AnimatedSprite2d.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2d.animation = "up"
		$AnimatedSprite2d.flip_v = velocity.y > 0
		

func _on_player_body_entered(_body):
	hide() # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2d.set_deferred("disabled", true)
	
	
func start(pos):
	position = pos
	show()
	$CollisionShape2d.disabled = false

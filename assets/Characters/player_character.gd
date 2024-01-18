extends Sprite2D

var player_speed: float = 400
var dash_speed_multiplier: float = 2.0

func _process(delta):
	# Player movement
	var player_movement = Vector2.ZERO
	var speed = player_speed

	if Input.is_action_pressed("player_move_right"):
		player_movement.x += 1
	if Input.is_action_pressed("player_move_left"):
		player_movement.x -= 1
	if Input.is_action_pressed("player_move_down"):
		player_movement.y += 1
	if Input.is_action_pressed("player_move_up"):
		player_movement.y -= 1

	# Check for dash (Shift key)
	if Input.is_key_pressed(KEY_SHIFT):
		speed *= dash_speed_multiplier

	player_movement = player_movement.normalized() * speed * delta
	position += player_movement  # Update the player's position directly

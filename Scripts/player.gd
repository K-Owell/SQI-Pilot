extends CharacterBody2D

# Define movement speed and sprint multiplier
var move_speed : float = 200.0
var sprint_multiplier : float = 2

# Define shooting slowdown percentage
var shooting_slowdown : float = 0.5

# Define reload time
var reload_time : float = 1.5

# Variable to track reload cooldown
var reloading : bool = false

# Process function
func _process(delta):
	# Check if reloading
	if reloading:
		# Wait for reload_time and then allow movement again
		reload_time -= delta
		if reload_time <= 0:
			reloading = false
			reload_time = 1.5  # Reset reload time
			# Resume normal movement

	else:
		# Get input values
		var direction = Vector2(0, 0)
		direction.x = Input.get_action_strength("player_move_right") - Input.get_action_strength("player_move_left")
		direction.y = Input.get_action_strength("player_move_down") - Input.get_action_strength("player_move_up")

		# Normalize the direction vector
		direction = direction.normalized()

		# Apply sprint multiplier
		if Input.is_action_pressed("Sprint"):
			direction *= sprint_multiplier

		# Apply shooting slowdown
		if Input.is_action_pressed("Shoot"):
			move_speed *= shooting_slowdown
			# Play shoot animation only if it's not already playing
			if not $AnimatedSprite2D.is_playing() or $AnimatedSprite2D.animation != "Shoot":
				$AnimatedSprite2D.play("Shoot")

		else:
			# Reset speed and play run or idle animation when not shooting or moving
			move_speed = 200.0
			if direction == Vector2.ZERO:
				$AnimatedSprite2D.play("Idle")
			else:
				$AnimatedSprite2D.play("Run")

				# Mirror the sprite if moving left
				$AnimatedSprite2D.flip_h = direction.x < 0

		# Move the player
		velocity = direction * move_speed
		move_and_slide()

		# Check for reload input
		if Input.is_action_just_pressed("Reload"):
			reloading = true
			# Play reload animation
			$AnimatedSprite2D.play("Reload")
			# Stop the player
			$AnimatedSprite2D.animation = "Reload"
			$AnimatedSprite2D.play()
			# Start the reload timer
			$Timer.start()

# Called when the Timer node times out
func _on_Timer_timeout():
	reloading = false
	# Resume normal movement or perform any other actions needed after the reload animation
	$AnimatedSprite2D.play("Idle")  # Assuming you have an idle animation

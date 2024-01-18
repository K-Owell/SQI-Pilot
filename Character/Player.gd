extends CharacterBody2D

# Assigning Character Values
var player_health = 100

# Assigning movement numbies
var movement_speed = 400
var dash_speed = 800
var dashing = false
var can_dash = true

# Applying movement
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# If "shift" to dash is pressed, change booleans and start timers.
	if Input.is_action_just_pressed("dash") and can_dash:
		dashing = true
		can_dash = false
		$Dash_Burst.start()
		$Dash_Cooldown.start()
	
	if dashing:
		velocity = direction * dash_speed
	else:
		velocity = direction * movement_speed
	
	move_and_slide()
	
	
# Allow dashing
func _on_dash_burst_timeout():
	dashing = false
# Dashing Cooldown timer (2 seconds)
func _on_dash_cooldown_timeout():
	can_dash = true

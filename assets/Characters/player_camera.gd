extends Camera2D

var player_target: Node
var trail_distance: float = 100
var recenter_speed: float = 5.0

func _ready():
	player_target = get_node("/root/Game/player_character")
	if player_target == null:
		print("Player character node not found!")

func _process(delta):
	if player_target:
		var target_position = player_target.global_position
		var camera_position = global_position

		# Calculate the direction from the camera to the target
		var direction = (target_position - camera_position).normalized()

		# Calculate the distance between the camera and the target
		var distance = camera_position.distance_to(target_position)

		# If the distance is greater than the trail distance, interpolate towards the target
		if distance > trail_distance:
			global_position = lerp(camera_position, target_position - direction * trail_distance, recenter_speed * delta)
		else:
			# If the distance is small, snap to the player's position
			global_position = target_position

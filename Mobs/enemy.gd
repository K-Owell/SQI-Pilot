extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 150.0
	move_and_slide()

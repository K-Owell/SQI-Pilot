extends CharacterBody2D

var enemy_health = 20

@onready var player = get_node("/root/Game/Player")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 150.0
	move_and_slide()


func _on_enemy_collision_tree_entered():
	pass # Replace with function body.

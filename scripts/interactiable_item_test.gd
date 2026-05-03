extends CharacterBody2D

var player_in_range := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	get_node("/root/Main/CharacterBody2D/InteractIcon").show()
	player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	get_node("/root/Main/CharacterBody2D/InteractIcon").hide()
	player_in_range = false

func _process(delta: float):
	if player_in_range and Input.is_action_just_pressed("interact"):
		print("Item Interacted With")
		queue_free()

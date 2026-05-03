extends CharacterBody2D

# Using Interactable item code as duplicate logic
signal bananaTime()

var player_in_range := false

func _ready():
	add_to_group("bananaTime")

func _on_area_2d_body_entered(body: Node2D) -> void:
	get_node("/root/Main/CharacterBody2D/InteractIcon").show()
	player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	get_node("/root/Main/CharacterBody2D/InteractIcon").hide()
	player_in_range = false

func _process(delta: float):	
	if player_in_range and Input.is_action_just_pressed("interact"):
		var player = get_node("/root/Main/CharacterBody2D") 
		if player.canRewind == true: 
			print("Already powered by bananas!")
		else:
			print("Banana was picked up! Time to go back!")
			bananaTime.connect(player._enable_banana_time)
			bananaTime.emit()
			queue_free()

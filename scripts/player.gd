extends CharacterBody2D

var speed : int
var last_direction : String


# temp
var screen_size : Vector2

func _ready():
	
	# temp to stop us walking off the screen
	screen_size = get_viewport_rect().size
	position = screen_size / 2
	
	# Set player speed	
	speed = 200
	
	# Set player to south facing on load
	last_direction = "s"

func get_input():
	# keyboard input
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed

func _physics_process(delta):
	# movement
	get_input()
	move_and_slide()
	
	# restrict to window size
	position = position.clamp(Vector2.ZERO, screen_size)
		
	# player animation & rotation
	if velocity.length() != 0:
		# If player is moving Right or Left
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				$AnimatedSprite2D.play("walk-e")
				last_direction = "e"
			else :
				$AnimatedSprite2D.play("walk-w")
				last_direction = "w"
		else:
			# If player is moving Down or Up
			if velocity.y > 0:
				$AnimatedSprite2D.play("walk-s")
				last_direction = "s"
			else :
				$AnimatedSprite2D.play("walk-n")
				last_direction = "n"
	# Return Player to Idle animation
	else:
		$AnimatedSprite2D.play("idle-" + last_direction)

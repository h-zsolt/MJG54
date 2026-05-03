extends CharacterBody2D

signal rewindStarted()
signal rewindStopped()
signal rewindPoolAvailable(fullness: float)

var speed : int
var last_direction : String

const REWINDMAX: int = 180
var rewinding: bool

# Added this section to make banana's 'important'
var canRewind: bool

var rewindPostition: Array[Vector2]
var rewindVelocity: Array[Vector2]
var rewindAnimation: Array[StringName]
var rewindFrame: Array[int]
var rewindFacing: Array[String]

# temp
var screen_size: Vector2

func _ready():
	# The following line is only needed when we need to check the path to something in the scene on startup.
	# Don't delete as it's strangely useful.
	# get_tree().current_scene.print_tree_pretty()
	
	# temp to stop us walking off the screen
	screen_size = get_viewport_rect().size
	position = screen_size / 2
	
	# Set player speed	
	speed = 200
	
	# Set player to south facing on load
	last_direction = "s"
	
	# Setting base variable for the game launch
	canRewind = true

func get_input():
	# keyboard input
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed
	
	if Input.is_action_just_pressed("rewind"):
		startRewind()
	if Input.is_action_just_released("rewind"):
		stopRewind()

func _physics_process(delta):
	# movement
	get_input()
	if not rewinding:
		move_and_slide()
		##Rewind recording
		if rewindPostition.size() >= REWINDMAX:
			rewindPostition.pop_front()
		rewindPostition.append(position)
		if rewindAnimation.size() >= REWINDMAX:
			rewindAnimation.pop_front()
		rewindAnimation.append($AnimatedSprite2D.animation)
		if rewindVelocity.size() >= REWINDMAX:
			rewindVelocity.pop_front()
		rewindVelocity.append(velocity)
		if rewindFrame.size() >= REWINDMAX:
			rewindFrame.pop_front()
		rewindFrame.append($AnimatedSprite2D.frame)
		if rewindFacing.size() >= REWINDMAX:
			rewindFacing.pop_front()
		rewindFacing.append(last_direction)
		rewindPoolAvailable.emit(rewindFacing.size() / 300.0) ##magic number because const is int :c
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
	else:
		if rewindPostition.size()>0:
			var lastPos = rewindPostition.pop_back()
			var lastVelocity = rewindVelocity.pop_back()
			var lastAnimation = rewindAnimation.pop_back()
			var lastFrame = rewindFrame.pop_back()
			#var lastFacing = rewindFrame.pop_back()
			var lastFacing = rewindFacing.pop_back()
			position = lastPos
			velocity = lastVelocity
			$AnimatedSprite2D.animation = lastAnimation
			$AnimatedSprite2D.frame = lastFrame
			last_direction = lastFacing
		else:
			stopRewind()
		pass

func startRewind()->void:
	if canRewind == true:
		rewinding = true
		rewindStarted.emit()
	else:
		print("You need more potassium bro!")

func stopRewind()->void:
	rewinding = false
	rewindStopped.emit()
	canRewind = false # This will stay until the player picks up a banana.

# On banana pickup, enable rewind ability and show a full rewind bar.
func _enable_banana_time():
	print("Basically, it's banana time.")
	canRewind = true
	get_node("/root/Main/Hud/TopBar/RewindTimer").play("Full")


# USE THIS AS AN ENTRY INTO PUTTING ITEMS FROM FIELD TO INVENTORY
func funkyfoo(data):
	print("Reached Player")
	print(data.foodName)
	print(data.spoilTime)
	pass

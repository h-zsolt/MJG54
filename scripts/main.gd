extends Node2D

var inventory_slot : int

# Logic for spawning banana's. I promise i'm not insane.
# If you redo/change anything, let me know how/why for future use :P
@export var banana_scene: PackedScene
var spawn_points = []
var spawn_timer : Timer
var banana_exists := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clearInventory()
	# collect all spawn points and add them to spawn_points array
	spawn_points = [
		$GardenMap/BananaSpawn_1,
		$GardenMap/BananaSpawn_2,
		$GardenMap/BananaSpawn_3,
		$GardenMap/BananaSpawn_4
	]
	# create timer for the spawning of banana time items
	spawn_timer = Timer.new()
	spawn_timer.wait_time = 3.0
	spawn_timer.one_shot = true
	add_child(spawn_timer)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)

func clearInventory():
	inventory_slot = 0
	for inventory_slot in range(4,10):
		var slot_icon = get_node("/root/Main/Hud/TopBar/Inventory_%d/Slot_Icon_%d" % [inventory_slot, inventory_slot])
		slot_icon.texture = null;
	return

func _process(delta: float) -> void:
	var bananas = get_tree().get_nodes_in_group("bananaTime")
	banana_exists = not bananas.is_empty()
	
	if not banana_exists:		
		if spawn_timer.is_stopped():
			print("Look at that tree growing a banana!")
			spawn_timer.start()

func _on_spawn_timer_timeout():
	var spawn_point = spawn_points.pick_random()
	var banana = banana_scene.instantiate()
	add_child(banana)
	
	# Grab starting position for the banana
	var start_pos = spawn_point.global_position
	banana.global_position = start_pos
	
	# bananaTime starts small so it can grow!
	banana.scale = Vector2(0.1,0.1)
	
	print("We have a banana!")
	
	# grow ya bananaTime (not like that ya perv)
	var grow_tween = create_tween()
	grow_tween.tween_property(banana, "scale", Vector2(1.5,1.5), 3.0)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		
	# Now drop it like it's hot (the bananaTime!)
	grow_tween.tween_callback(func():
		var drop_tween = create_tween()
		drop_tween.tween_property(
			banana,
			"global_position",
			start_pos + Vector2(0,75),
			0.4
		).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	)

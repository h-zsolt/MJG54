extends Node2D

var inventory_slot : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print("game running")
	
	# Clear Inventory on start
	clearInventory()
	
	print("Inventory completely reset")
	
	pass # Replace with function body.

func clearInventory():
	inventory_slot = 0
	for inventory_slot in range(4,10):
		var slot_icon = get_node("/root/Main/Hud/TopBar/Inventory_%d/Slot_Icon_%d" % [inventory_slot, inventory_slot])
		slot_icon.texture = null;
	return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func startDrainAnim()->void:
	$TopBar/RewindTimer.play("Drain")

func startRechargeAnim()->void:
	$TopBar/RewindTimer.play("Recharge")


func updateInventoryDisplay()->void:
	var player = get_node("/root/Main/CharacterBody2D")
	print("Update Display called")
	#for item in player.get_node("Inventory").get_children():
	for item in range(player.inventory.size()):
		print(player.inventory[item].getFoodData().spriteTexture)
		if item==0:
			$TopBar/Inventory_4/Slot_Icon_4.texture = player.inventory[item].getFoodData().spriteTexture
		if item==1:
			$TopBar/Inventory_5/Slot_Icon_5.texture = player.inventory[item].getFoodData().spriteTexture
		if item==2:
			$TopBar/Inventory_6/Slot_Icon_6.texture = player.inventory[item].getFoodData().spriteTexture
		if item==3:
			$TopBar/Inventory_7/Slot_Icon_7.texture = player.inventory[item].getFoodData().spriteTexture
		if item==4:
			$TopBar/Inventory_8/Slot_Icon_8.texture = player.inventory[item].getFoodData().spriteTexture
		if item==4:
			$TopBar/Inventory_9/Slot_Icon_9.texture = player.inventory[item].getFoodData().spriteTexture
	

extends Node

signal sendItemData(node: Node)
##Node based inventory for ease
var numberOfSlots: int
var slotTable: Dictionary[int,Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getItem(slot: int) -> void:
	if slotTable.has(slot):
		sendItemData.emit(slotTable[slot])
	##Don't forget to null check

func addToInventory(item: Node) -> bool:
	for i in range(numberOfSlots):
		if not slotTable.has(i):
			slotTable[i]=item
			self.add_child(item)
			##TODO: Disable Sprite2D
			##TODO: Enable UI visual
	return true

func removeFromInventory(slot: int) -> Node:
	if slotTable.has(slot):
		self.remove_child(slotTable[slot])
		##TODO: Make sure the new position is set
		##TODO: Re-enable rendering and remove UI visual
		return slotTable[slot]
	return null
	##Don't forget to null check

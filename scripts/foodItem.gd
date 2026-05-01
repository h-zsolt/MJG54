extends Node

var spoilTimer : Timer
@export var foodData: FoodItem = FoodItem.new()

var rewinding: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spoilTimer = $SpoilTimer
	spoilTimer.wait_time = foodData.spoilTime
	##self.name = foodData.foodName
	if foodData.spoiling == true:
		spoilTimer.paused = true
		spoilTimer.wait_time = 409600.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if not rewinding:
		pass
	else:
		pass
	
	spoilTimer.time_left

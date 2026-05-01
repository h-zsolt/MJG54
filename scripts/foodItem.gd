extends Node

var spoilTimer : Timer
@export var foodData: FoodItem = FoodItem.new()
@export var spoilInto: FoodItem = FoodItem.new()

const REWINDMAX: int = 300
var rewinding: bool
var rewindState: Array[FoodItem] = [FoodItem.new()]
var rewindPosition: Array[Vector2]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spoilTimer = $SpoilTimer
	spoilTimer.wait_time = foodData.spoilTime
	##self.name = foodData.foodName
	if foodData.spoiling == true:
		spoilTimer.paused = true
		spoilTimer.wait_time = 409600.0
	$Sprite2D.texture = foodData.spriteTexture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if not rewinding:
		rewindState.append(foodData)
		rewindPosition.append()
	else:
		pass
	
	spoilTimer.time_left

func startRewind()->void:
	rewinding = true;
	
func stopRewind()->void:
	rewinding = false;

extends Node2D

var spoilTimer : Timer
@export var foodData: FoodItem = FoodItem.new()
@export var spoilInto: FoodItem = FoodItem.new()
##var inStation: bool = false not sure we'll need this yet

const REWINDMAX: int = 300
var rewinding: bool
var rewindState: Array[FoodItem] = [FoodItem.new()]
var rewindPosition: Array[Vector2]
var rewindTimer: Array[float]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spoilTimer = $SpoilTimer
	spoilTimer.wait_time = foodData.spoilTime
	##self.name = foodData.foodName
	if foodData.spoiling == false:
		spoilTimer.paused = true
		spoilTimer.wait_time = 409600.0
	$Sprite2D.texture = foodData.spriteTexture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Using physics_process for fixed amount of updates per second
func _physics_process(delta: float) -> void:
		##Update Record
	if not rewinding:
		if rewindState.size()>=REWINDMAX:
			rewindState.pop_front()
		rewindState.append(foodData)
		if rewindPosition.size()>=REWINDMAX:
			rewindPosition.pop_front()
		rewindPosition.append(global_position)
		if rewindTimer.size()>=REWINDMAX:
			rewindTimer.pop_front()
		rewindTimer.append(spoilTimer.time_left)
		##Rewind Record
	else:
		var lastState = rewindState.pop_back()
		var lastPosition = rewindPosition.pop_back()
		var lastTimer = rewindTimer.pop_back()
		if lastState != foodData:
			pass ##Swap back food data
		global_position = lastPosition
		spoilTimer.wait_time = lastTimer
		
	

func pauseSpoiling() -> void:
	spoilTimer.paused = true

func resumeSpoiling()->void:
	if foodData.spoiling==true:
		spoilTimer.paused = false

func startRewind()->void:
	pauseSpoiling()
	rewinding = true;
	
func stopRewind()->void:
	resumeSpoiling()
	rewinding = false;

func getData() -> FoodItem:
	return foodData

extends Resource
class_name FoodItem

@export var spoiling: bool
@export var spoilTime: float = 10.0
@export var foodName: String
@export var usageTable: Dictionary[String,bool]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Resource
class_name FoodItem

@export var spoiling: bool
@export var spoilTime: float = 10.0
@export var foodName: String
@export var spriteTexture: Texture2D
@export var usageTable: Dictionary[String,bool] #station name -> new item
@export var productTable: Dictionary[String, FoodItem] #station name -> product
@export var undercookedTable: Dictionary[String, FoodItem]
@export var overcookedTable: Dictionary[String, FoodItem]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

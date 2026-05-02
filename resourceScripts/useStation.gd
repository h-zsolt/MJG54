extends Resource
class_name UseStation

@export var stationName:String
var inUse:bool = false
@export var autonomous:bool = false
@export var useTimeTable:Dictionary[String,Vector2]

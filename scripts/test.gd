extends Node
var lastTime:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	##Default values
	var currTime:float=0.0
	var maxTime:float=2.0
	##Generate metadata if not already present
	if self.get_meta("currTime") == null:
		self.set_meta("currTime", currTime)
		print("New meta currTime set")
	if self.get_meta("maxTime") == null:
		self.set_meta("maxTime", maxTime)
		print("New meta maxTime set")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	##Testing local variable
	lastTime=delta
	##Load Metadata
	var currTime = self.get_meta("currTime")
	var maxTime = self.get_meta("maxTime")
	##Tick timer
	currTime += delta
	##Check if timer reached the end
	if currTime > maxTime :
		##Overflow style
		currTime -= maxTime
		##Reset style
		currTime = 0.0
		print("Timer done")
	print("New timer ", currTime)
	self.set_meta("currTime", currTime)
	##$"." <-- self in case of 'Node'
	pass

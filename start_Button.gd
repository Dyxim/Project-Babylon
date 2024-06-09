extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	#button_down.connect(startthegame)#not used since the version change to 4.2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _pressed():
	startthegame()


func startthegame():
	print("game_starts")
	Events.up_level.emit()

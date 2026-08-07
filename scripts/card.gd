extends Node2D

var isCardSelected = false

func move():
	if isCardSelected == false:
		position = position + Vector2(0, -50)
		isCardSelected = true
	else:
		position = position + Vector2(0, 50)
		isCardSelected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

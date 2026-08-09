extends Node2D

var isCardSelected = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func move():
	if isCardSelected == false:
		position = position + Vector2(0, -50)
		isCardSelected = true
	else:
		position = position + Vector2(0, 50)
		isCardSelected = false

func _mouse_entered() -> void:
	emit_signal("hovered", self)

func _mouse_exited() -> void:
	emit_signal("unhovered", self)

func _deselect_all(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.is_pressed():
			if isCardSelected == true:
				position = position + Vector2(0, 50)
				isCardSelected = false

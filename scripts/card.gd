extends Node2D

var isCardSelected = false
signal hovered
signal unhovered

func move():
	if isCardSelected == false:
		position = position + Vector2(0, -50)
		isCardSelected = true
	else:
		position = position + Vector2(0, 50)
		isCardSelected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect_card_signals(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _mouse_entered() -> void:
	emit_signal("hovered", self)

func _mouse_exited() -> void:
	emit_signal("unhovered", self)

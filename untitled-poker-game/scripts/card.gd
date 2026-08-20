extends Node2D

signal hovered
signal unhovered

var is_selected = false
var is_face_up = false
var type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect_card_signals(self)

func _mouse_entered() -> void:
	emit_signal("hovered", self)

func _mouse_exited() -> void:
	emit_signal("unhovered", self)

func deactivate():
	$Area2D/CollisionShape2D.disabled = true
	$CardBackImage.visible = false
	$CardBackgroundImage.visible = false
	$CardImage.visible = false

func get_is_selected():
	return is_selected

func get_is_face_up():
	return is_face_up

func set_is_selected(boolean):
	is_selected = boolean

func set_is_face_up(boolean):
	is_face_up = boolean

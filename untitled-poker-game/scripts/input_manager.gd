extends Node2D

signal left_mouse_button_clicked

const COLLISION_MASK_CARD = 1
const COLLISION_MASK_DECK = 2

var card_manager_reference
var deck_reference

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_manager_reference = $"../CardManager"
	deck_reference = $"../Deck"
	deck_reference.draw_starting_hand()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			emit_signal("left_mouse_button_clicked")
			raycast_at_cursor()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.is_pressed():
			for _i in $"../CardManager".get_children():
				if _i.isCardSelected == true:
					_i.move()

func raycast_at_cursor():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		var result_collision_mask = result[0].collider.collision_mask
		if result_collision_mask == COLLISION_MASK_CARD:
			var card_found = result[0].collider.get_parent()
			if card_found != null:
				card_found.move()
		elif result_collision_mask == COLLISION_MASK_DECK:
			deck_reference.replace_cards()

extends Node2D

const COLLISION_MASK_CARD = 1
const COLLISION_MASK_DECK = 2

var deck_reference
var hand_manager_reference
var player_reference
var opponent_reference

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck_reference = $"../Deck"
	player_reference = $"../Dealer/HandManager/PlayerHand"
	opponent_reference = $"../Dealer/HandManager/OpponentHand"
	hand_manager_reference = $"../Dealer/HandManager"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			raycast_at_cursor()			#looks what is behind the cursor and acts accordingly
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.is_pressed():
			player_reference.deselect_all_cards()

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
			if card_found != null && card_found in player_reference.get_children():
				player_reference.switch_selection_value(card_found)
		elif result_collision_mask == COLLISION_MASK_DECK:
			player_reference.replace_cards()
			await player_reference.turn_end
			opponent_reference.opponent_turn()
			await opponent_reference.turn_end
			hand_manager_reference.decide_winner()
			#hand_manager_reference.deal_new_cards()

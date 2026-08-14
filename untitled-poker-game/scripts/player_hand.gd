extends Node2D

const CARD_WIDTH = 73
const DECK_COORD_X = 320
const DECK_COORD_Y = 100
const HAND_X_OFFSET = 420
const HAND_Y_POSITION = 300
const DEFAULT_CARD_MOVEMENT_SPEED = 0.1


var player_hand = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_card_to_hand(card, speed):
	if card not in player_hand:
		player_hand.insert(0, card)
		update_hand_positions(speed)
	else:
		animate_card_to_position(card, card.starting_position, DEFAULT_CARD_MOVEMENT_SPEED)

func remove_card_from_hand(card):
	if card in player_hand:
		var deck_position = Vector2(DECK_COORD_X, DECK_COORD_Y)
		animate_card_to_position(card, deck_position, DEFAULT_CARD_MOVEMENT_SPEED)
		player_hand.erase(card)
		update_hand_positions(DEFAULT_CARD_MOVEMENT_SPEED)

func update_hand_positions(speed):
	for i in range(player_hand.size()):
		var new_position = Vector2(calculate_card_position(i), HAND_Y_POSITION)
		var card = player_hand[i]
		animate_card_to_position(card, new_position, speed)

func calculate_card_position(index):
	var total_width = (player_hand.size() - 1) * CARD_WIDTH
	var x_offset = HAND_X_OFFSET + index * CARD_WIDTH - total_width / 2
	return x_offset

func animate_card_to_position(card, new_position, speed):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", new_position, speed)

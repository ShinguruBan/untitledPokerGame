extends Node2D

const CARD_WIDTH = 73
const HAND_X_OFFSET = 420
const HAND_Y_POSITION = 300
const DEFAULT_CARD_MOVEMENT_SPEED = 0.1
const PLAYER_HAND_SIZE = 5

var cardmanager_reference


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cardmanager_reference = $"../CardManager"
	draw_starting_hand()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func draw_starting_hand():
	for i in range(PLAYER_HAND_SIZE):
		draw_card()

func draw_card():
	cardmanager_reference.add_card_from_deck_to_hand(self) 

func replace_cards():
	cardmanager_reference.replace_cards_from_hand(self)

func add_card_to_hand(card, speed):
	if card not in get_children():
		add_child(card)
		update_hand_positions(speed)

func remove_card_from_hand(card):
	if card in get_children():
		cardmanager_reference.animate_card_to_deck_position(card, DEFAULT_CARD_MOVEMENT_SPEED)
		remove_child(card)

func update_hand_positions(speed):
	for i in range(get_children().size()):
		var new_position = Vector2(calculate_card_position(i), HAND_Y_POSITION)
		var card = get_child(i)
		cardmanager_reference.animate_card_to_position(card, new_position, speed)

func calculate_card_position(index):
	var total_width = (get_children().size() - 1) * CARD_WIDTH
	var x_offset = HAND_X_OFFSET + index * CARD_WIDTH - total_width / 2
	return x_offset

func switch_selection_value(card):
	if card.is_selected == false:
		select_card(card)
	else:
		deselect_card(card)

func select_card(card):
	card.position = card.position + Vector2(0, -10)
	card.is_selected = true

func deselect_card(card):
	card.position = card.position + Vector2(0, 10)
	card.is_selected = false

func deselect_all_cards():
	for i in self.get_children():
		if i.is_selected == true:
			deselect_card(i)

func connect_card_signals(card):
	card.connect("hovered", on_card_hovered)
	card.connect("unhovered", on_card_unhovered)

func on_card_hovered(card):
	highlight_card(card, true)
	
func on_card_unhovered(card):
	highlight_card(card, false)

func highlight_card(card, hovered):
	if hovered:
		card.scale = Vector2(1.05, 1.05)
		card.z_index = 2
	else:
		card.scale = Vector2(1, 1)
		card.z_index = 1

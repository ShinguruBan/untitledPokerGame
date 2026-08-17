extends Node2D

const CARD_WIDTH = 73
const HAND_X_OFFSET = 420
const SELECTED_CARD_COORD_Y = 180
const UNSELECTED_CARD_COORD_Y = 170
const PLAYER_HAND_SIZE = 5

var cardmanager_reference
var timer_reference

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cardmanager_reference = $"../CardManager"
	timer_reference = $"../Timer"
	timer_reference.one_shot = true
	timer_reference.wait_time = 0.5
	draw_starting_hand()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func opponent_turn():
	var card_type = ["Goblin", "Mimic", "Skeleton", "Siren", "Chimera", "Dragon"]
	var amount = [0, 0, 0, 0, 0, 0]
	for i in self.get_children():
		for j in range(card_type.size()):
			if i.type == card_type[j]:
				amount[j] = amount[j] + 1
				break
	for i in self.get_children():
		for j in range(amount.size()):
			if i.type == card_type[j] && amount[j] == 1:
				select_card(i)
				timer_reference.start()
				await timer_reference.timeout
				break
	
	replace_cards()

func draw_starting_hand():
	for i in range(PLAYER_HAND_SIZE):
		draw_card()
		await cardmanager_reference.tween.finished

func draw_card():
	cardmanager_reference.add_card_from_deck_to_hand(self) 

func replace_cards():
	cardmanager_reference.replace_cards_from_hand(self)

func add_card_to_hand(card):
	if card not in self.get_children():
		self.add_child(card)
		update_hand_positions()

func replace_card_from_hand(to_be_replaced, replacement):
	if to_be_replaced in self.get_children():
		to_be_replaced.add_sibling(replacement)
		self.remove_child(to_be_replaced)

func update_hand_positions():
	var card_position_y
	for i in range(self.get_children().size()):
		var card = self.get_child(i)
		if card.get_is_selected():
			card_position_y = SELECTED_CARD_COORD_Y
		else:
			card_position_y = UNSELECTED_CARD_COORD_Y
		
		var new_position = Vector2(calculate_card_position(i), card_position_y)
		cardmanager_reference.animate_card_to_position(card, new_position)

func calculate_card_position(index):
	var total_width = (self.get_children().size() - 1) * CARD_WIDTH
	var x_offset = HAND_X_OFFSET + index * CARD_WIDTH - total_width / 2
	return x_offset

func switch_selection_value(card):
	if card.is_selected == false:
		select_card(card)
	else:
		deselect_card(card)

func select_card(card):
	card.position = Vector2(card.position.x, SELECTED_CARD_COORD_Y)
	card.is_selected = true

func deselect_card(card):
	card.position = Vector2(card.position.x, UNSELECTED_CARD_COORD_Y)
	card.is_selected = false

func connect_card_signals(card):
	print("connected")

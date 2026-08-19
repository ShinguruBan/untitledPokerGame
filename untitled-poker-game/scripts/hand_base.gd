class_name BaseHand

extends Node2D

const CARD_WIDTH = 73
const HAND_X_OFFSET = 420
const PLAYER_HAND_SIZE = 5

signal flipped_up
signal turn_end

var id
var unselected_card_coord_y
var selected_card_ccord_y
var cardmanager_reference

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize_individual_values()
	draw_starting_hand()

func initialize_individual_values():
	pass

func draw_starting_hand():
	for i in range(PLAYER_HAND_SIZE):
		draw_card()
		await cardmanager_reference.tween.finished
	flip_all_cards_up()

func remove_entire_hand():
	for i in self.get_children():
		select_card(i)
	remove_cards()

func draw_card():
	cardmanager_reference.add_card_from_deck_to_hand(self) 

func replace_cards():
	await flip_selected_cards_down()
	cardmanager_reference.replace_cards_from_hand(self)
	await flipped_up
	emit_signal("turn_end")

func remove_cards():
	await flip_selected_cards_down()
	cardmanager_reference.return_cards_to_deck(self)

func add_card_to_hand(card):
	self.add_child(card)
	update_hand_positions()

func replace_card_from_hand(to_be_replaced, replacement):
	to_be_replaced.add_sibling(replacement)
	self.remove_child(to_be_replaced)

func remove_card_from_hand(card):
	if card in self.get_children():
		self.remove_child(card)

func update_hand_positions():
	var card
	var card_position_y
	var card_position_x
	var new_position
	var total_width = (PLAYER_HAND_SIZE - 1) * CARD_WIDTH
	for i in range(self.get_children().size()):
		card = self.get_child(i)
		
		card_position_x = HAND_X_OFFSET + (i * CARD_WIDTH - total_width / 2)
		if card.get_is_selected():
			card_position_y = selected_card_ccord_y
		else:
			card_position_y = unselected_card_coord_y
		new_position = Vector2(card_position_x, card_position_y)
		cardmanager_reference.animate_card_to_position(card, new_position)

func switch_selection_value(card):
	if card.is_selected == false:
		select_card(card)
	else:
		deselect_card(card)

func select_card(card):
	card.position = Vector2(card.position.x, selected_card_ccord_y)
	card.set_is_selected(true)

func deselect_card(card):
	card.position = Vector2(card.position.x, unselected_card_coord_y)
	card.set_is_selected(false)

func flip_all_cards_up():
	for i in self.get_children():
		if !i.get_is_face_up():
			i.get_node("AnimationPlayer").play("card_flip")
			await i.get_node("AnimationPlayer").animation_finished
			i.set_is_face_up(true)
	emit_signal("flipped_up")

func flip_selected_cards_down():
	for i in self.get_children():
		if i.get_is_face_up() && i.get_is_selected():
			i.get_node("AnimationPlayer").play_backwards("card_flip")
			await i.get_node("AnimationPlayer").animation_finished
			i.set_is_face_up(false)

func connect_card_signals(card):
	pass

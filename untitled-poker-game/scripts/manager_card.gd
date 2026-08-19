extends Node2D

var deck_reference
var tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck_reference = $"../../Deck"

func add_card_from_deck_to_hand(player):
	var drawn_card = deck_reference.get_top_card()
	deck_reference.remove_top_card()
	player.add_card_to_hand(drawn_card)

func replace_cards_from_hand(player):
	var number_of_returned_cards = 0
	var selected_cards = []
	for i in player.get_children():
		if i.is_selected == true:
			animate_card_to_deck(i)
			selected_cards.append(i)
			number_of_returned_cards = number_of_returned_cards + 1
	if selected_cards.size() > 0:
		await tween.finished
	for i in selected_cards:
		i.deactivate()
	for i in selected_cards:
		var replacement = deck_reference.get_top_card()
		deck_reference.remove_top_card()
		player.replace_card_from_hand(i, replacement)
		deck_reference.add_card_to_bottom(i.type)
		player.update_hand_positions()
		await tween.finished
	player.flip_all_cards_up()
	deck_reference.shuffle()

func return_cards_to_deck(player):
	var number_of_returned_cards = 0
	var selected_cards = []
	for i in player.get_children():
		if i.is_selected == true:
			animate_card_to_deck(i)
			selected_cards.append(i)
			number_of_returned_cards = number_of_returned_cards + 1
	await tween.finished
	for i in selected_cards:
		player.remove_card_from_hand(i)
		deck_reference.add_card_to_bottom(i.type)
	deck_reference.shuffle()

func animate_card_to_position(card, new_position):
	tween = get_tree().create_tween()
	tween.tween_property(card, "position", new_position, deck_reference.CARD_DRAW_SPEED)

func animate_card_to_deck(card):
	tween = get_tree().create_tween()
	tween.tween_property(card, "position", Vector2(deck_reference.COORD_X, deck_reference.COORD_Y), deck_reference.CARD_RETURN_SPEED)

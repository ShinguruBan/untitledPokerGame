extends Node2D

var deck_reference
var tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck_reference = $"../Deck"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_card_from_deck_to_hand(player):
	var drawn_card = deck_reference.get_top_card()
	deck_reference.remove_top_card()
	player.add_card_to_hand(drawn_card)
	await tween.finished
	drawn_card.get_node("AnimationPlayer").play("card_flip")

func replace_cards_from_hand(player):
	var number_of_returned_cards = 0
	var selected_cards = []
	for i in player.get_children():
		if i.is_selected == true:
			i.get_node("AnimationPlayer").play_backwards("card_flip")
			animate_card_to_deck_position(i)
			selected_cards.insert(selected_cards.size(), i)
			number_of_returned_cards = number_of_returned_cards + 1
	await tween.finished
	for i in selected_cards:
		i.deactivate()
	for i in selected_cards:
		replace_card_from_hand_with_top_card(i, player)
		await tween.finished
	deck_reference.shuffle()

func replace_card_from_hand_with_top_card(card, player):
	var drawn_card = deck_reference.get_top_card()
	deck_reference.remove_top_card()
	player.replace_card_from_hand(card, drawn_card)
	deck_reference.add_card_to_bottom(card.type)
	player.update_hand_positions()
	await tween.finished
	drawn_card.get_node("AnimationPlayer").play("card_flip")

func animate_card_to_position(card, new_position):
	tween = get_tree().create_tween()
	tween.tween_property(card, "position", new_position, deck_reference.CARD_DRAW_SPEED)

func animate_card_to_deck_position(card):
	tween = get_tree().create_tween()
	tween.tween_property(card, "position", Vector2(deck_reference.COORD_X, deck_reference.COORD_Y), deck_reference.CARD_RETURN_SPEED)

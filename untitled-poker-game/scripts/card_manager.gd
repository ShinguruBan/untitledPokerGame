extends Node2D

var deck_reference
var player_hand_reference


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck_reference = $"../Deck"
	player_hand_reference = $"../PlayerHand"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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

func return_cards_to_deck() -> int:
	var number_of_returned_cards = 0
	for i in self.get_children():
		if i.is_selected == true:
			player_hand_reference.remove_card_from_hand(i)		#remove card from players hand
			deck_reference.player_deck.insert(0, i.type)		#put card into deck
			remove_child(i)										#delete from card_manager
			number_of_returned_cards = number_of_returned_cards + 1
	return number_of_returned_cards

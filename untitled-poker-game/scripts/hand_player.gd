extends BaseHand

func initialize_individual_values():
	id = "player"
	cardmanager_reference = $"../../CardManager"
	unselected_card_coord_y = 310
	selected_card_ccord_y = 300

func draw_starting_hand():
	for i in range(PLAYER_HAND_SIZE):
		draw_card()
		await cardmanager_reference.tween.finished
	flip_all_cards_up()

func deselect_all_cards():
	for card in self.get_children():
		if card.is_selected == true:
			deselect_card(card)

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

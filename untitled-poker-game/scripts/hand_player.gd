extends BaseHand

func initialize_individual_values():
	id = "player"
	cardmanager_reference = $"../../CardManager"
	unselected_card_coord_y = 310
	selected_card_ccord_y = 300

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

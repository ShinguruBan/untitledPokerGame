extends BaseHand

var card_database_reference

func draw_starting_hand():
	for i in range(PLAYER_HAND_SIZE):
		draw_card()
		await cardmanager_reference.tween.finished

func initialize_individual_values():
	id = "opponent"
	cardmanager_reference = $"../../CardManager"
	card_database_reference = preload("res://scripts/database_card.gd")
	unselected_card_coord_y = 170
	selected_card_ccord_y = 180

func opponent_turn():
	var amount_of_each_card = []
	for i in range(card_database_reference.CARD_TYPES.size()):
		amount_of_each_card.append(0)
	
	for i in self.get_children():
		for j in range(amount_of_each_card.size()):
			if i.type == j:
				amount_of_each_card[j] = amount_of_each_card[j] + 1
				break
	
	for i in self.get_children():
		for j in range(amount_of_each_card.size()):
			if i.type == j && amount_of_each_card[j] == 1:
				select_card(i)
				break
	replace_cards()

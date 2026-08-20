extends BaseHand

var card_database_reference

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
	
	for card in self.get_children():
		for index_type in range(amount_of_each_card.size()):
			if card.type == index_type:
				amount_of_each_card[index_type] = amount_of_each_card[index_type] + 1
				break
	
	for card in self.get_children():
		for index_type in range(amount_of_each_card.size()):
			if card.type == index_type && amount_of_each_card[index_type] == 1:
				select_card(card)
				break
	replace_cards()

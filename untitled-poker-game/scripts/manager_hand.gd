extends Node2D

var card_database_reference
var combination_database_reference

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_database_reference = preload("res://scripts/database_card.gd")
	combination_database_reference = preload("res://scripts/database_combination.gd")

func decide_winner():
	var current_winner
	var current_highest_score = -1
	
	for player in self.get_children():
		var amount_of_each_card = []
		for i in range(card_database_reference.CARD_TYPES.size()):
			amount_of_each_card.append(0)
		
		for card in player.get_children():
			for index_type in range(amount_of_each_card.size()):
				if card.type == index_type:
					amount_of_each_card[index_type] = amount_of_each_card[index_type] + 1
					break
		
		var current_score = -1
		for amount in amount_of_each_card:
			if amount == 2:
				current_score = current_score + 1
			elif amount == 3:
				current_score = current_score + 3
			elif amount == 4:
				current_score = current_score + 5
			elif amount == 5:
				current_score = current_score + 6
		if current_score > current_highest_score:
			current_highest_score = current_score
			current_winner = player
	print(current_winner.id)
	print(combination_database_reference.POSSIBLE_COMBINATIONS[current_highest_score][combination_database_reference.INDEX_NAME])

func deal_new_cards():
	for player in self. get_children():
		await player.remove_entire_hand()
	var timer = $"../../Timer"
	timer.wait_time = 2
	timer.start()
	await timer.timeout
	for player in self. get_children():
		player.draw_starting_hand()

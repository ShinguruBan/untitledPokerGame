extends Node2D

var card_database_reference
var combination_database_reference
var storage = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_database_reference = preload("res://scripts/database_card.gd")
	combination_database_reference = preload("res://scripts/database_combination.gd")

func decide_winner():
	var winner
	var highest_score = -1
	var winner_amount_sorted = []
	var same_hand = false
	
	for player in self.get_children():
		var amount_of_each_card = []
		for i in range(card_database_reference.CARD_TYPES.size()):
			amount_of_each_card.append(Vector2(0, i))		#Vector2.x = amount, Vector2.y = type_index
		
		for card in player.get_children():
			for index_type in range(amount_of_each_card.size()):
				if card.type == index_type:
					amount_of_each_card[index_type].x = amount_of_each_card[index_type].x + 1
					break
		
		var current_score = -1
		for amount in amount_of_each_card:
			if amount.x == 2:
				current_score = current_score + 1
			elif amount.x == 3:
				current_score = current_score + 3
			elif amount.x == 4:
				current_score = current_score + 5
			elif amount.x == 5:
				current_score = current_score + 6
		
		if current_score > highest_score:
			highest_score = current_score
			amount_of_each_card.sort()
			winner_amount_sorted.assign(amount_of_each_card)
			winner = player
		if current_score == highest_score:
			same_hand = false
			amount_of_each_card.sort()
			for i in range(winner_amount_sorted.size() - 1, 0, -1):
				if amount_of_each_card[i].y > winner_amount_sorted[i].y:
					winner_amount_sorted.assign(amount_of_each_card)
					winner = player
					break
				elif amount_of_each_card[i].y < winner_amount_sorted[i].y:
					break
				if i == 0 && amount_of_each_card[i].y == winner_amount_sorted[i].y:
					same_hand = true
	if same_hand:
		print("Tie")
	else:
		print(winner.id)
	print(combination_database_reference.POSSIBLE_COMBINATIONS[highest_score][combination_database_reference.INDEX_NAME])
	print(winner_amount_sorted)

func deal_new_cards():
	for player in self. get_children():
		await player.remove_entire_hand()
	var timer = $"../../Timer"
	timer.wait_time = 2
	timer.start()
	await timer.timeout
	for player in self. get_children():
		player.draw_starting_hand()

extends Node2D

var card_database_reference
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_database_reference = preload("res://scripts/database_card.gd")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func decide_winner():
	var card_types = []
	var current_winner
	var current_highest_score = -1
	for i in range(card_database_reference.CARD_TYPES.size()):
		card_types.append(i)
	
	for i in self.get_children():
		var amount = []
		for j in range(card_database_reference.CARD_TYPES.size()):
			amount.append(0)
		
		for j in i.get_children():
			for k in range(card_types.size()):
				if j.type == card_types[k]:
					amount[k] = amount[k] + 1
					break
		
		var current_score = -1
		for k in amount:
			if k == 2:
				current_score = current_score + 1
			elif k == 3:
				current_score = current_score + 3
			elif k == 4:
				current_score = current_score + 5
			elif k == 5:
				current_score = current_score + 6
		if current_score > current_highest_score:
			current_highest_score = current_score
			current_winner = i
	print(current_winner.id)
	print(current_highest_score)

func deal_new_cards():
	for i in self. get_children():
		for j in i.get_children():
			i.select_card(j)
			i.replace_cards()

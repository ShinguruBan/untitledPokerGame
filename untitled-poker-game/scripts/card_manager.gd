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


func add_card_from_deck_to_hand(player):
	var drawn_card = deck_reference.get_top_card()
	deck_reference.remove_top_card()
	player.add_card_to_hand(drawn_card, deck_reference.CARD_DRAW_SPEED)
	
	drawn_card.get_node("AnimationPlayer").play("card_flip")
	
func replace_cards_from_hand(player):
	var number_of_returned_cards = 0
	for i in player.get_children():
		if i.is_selected == true:
			player.remove_card_from_hand(i)
			deck_reference.add_card(i.type)
			number_of_returned_cards = number_of_returned_cards + 1
	deck_reference.shuffle()
	for i in number_of_returned_cards:
		add_card_from_deck_to_hand(player)

func animate_card_to_position(card, new_position, speed):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", new_position, speed)
	await tween.finished

func animate_card_to_deck_position(card, speed):
	animate_card_to_position(card, Vector2(deck_reference.COORD_X, deck_reference.COORD_Y), speed)

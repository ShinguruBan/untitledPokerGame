extends Node2D

const PLAYER_HAND_SIZE = 5
const CARD_SCENE_PATH = "res://scenes/card.tscn"

var player_deck = ["Godot", "Godot", "Godot", "Godot", "Godot", "Godot"]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func draw_starting_hand():
	for i in range(PLAYER_HAND_SIZE):
		draw_card()

func draw_card():
	var card_drawn = player_deck[0]
	player_deck.erase(card_drawn)

	if player_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false

	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	$"../CardManager".add_child(new_card)
	new_card.name = "Card"
	$"../PlayerHand".add_card_to_hand(new_card)

func replace_cards():
	print("sdad")
	for i in $"../CardManager".get_children():
		if i.isCardSelected == true:
			i.isCardSelected = false
			player_deck.insert(0, i)
			$"../PlayerHand".remove_card_from_hand(i)
			$"../CardManager".remove_child(i)
			draw_card()

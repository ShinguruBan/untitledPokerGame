extends Node2D

const PLAYER_HAND_SIZE = 5
const CARD_SCENE_PATH = "res://scenes/card.tscn"

var player_deck = ["Godot", "Godot", "Godot", "Godot", "Godot", "Godot"]
var card_manager_reference
var player_hand_reference

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_manager_reference = $"../CardManager"
	player_hand_reference = $"../PlayerHand"
	draw_starting_hand()


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
	card_manager_reference.add_child(new_card)
	new_card.name = "Card"
	player_hand_reference.add_card_to_hand(new_card)

func replace_cards():
	for i in card_manager_reference.get_children():
		if i.isCardSelected == true:
			i.isCardSelected = false
			player_deck.insert(0, i)
			player_hand_reference.remove_card_from_hand(i)
			card_manager_reference.remove_child(i)
			draw_card()

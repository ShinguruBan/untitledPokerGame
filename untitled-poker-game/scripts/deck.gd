extends Node2D

const EACH_CARD_AMOUNT = 5
const CARD_DRAW_SPEED = 0.15
const CARD_RETURN_SPEED = 0.25
const COORD_X = 420
const COORD_Y = 50

var deck = []
var card_database_reference
var card_scene_reference

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D/CollisionShape2D.disabled = false
	$Sprite2D.visible = true
	card_database_reference = preload("res://scripts/database_card.gd")
	card_scene_reference = preload("res://scenes/card.tscn")
	for i in range(card_database_reference.CARD_TYPES.size()):
		for j in card_database_reference.CARD_TYPES[i][1]:
			add_card_to_bottom(i)
	shuffle()
	self.position = Vector2(COORD_X, COORD_Y)

func add_card_to_bottom(card_type):
	deck.append(card_type)
	check_deck_availability()

func remove_top_card():
	deck.erase(deck[0])
	check_deck_availability()

func check_deck_availability():
	if deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
	else:
		$Area2D/CollisionShape2D.disabled = false
		$Sprite2D.visible = true

func shuffle():
	deck.shuffle()

func get_top_card():
	var top_card_type = deck[0]
	
	#construct top card
	var card_image_path = str("res://assets/card_textures/" + card_database_reference.CARD_TYPES[top_card_type][0] + ".png")
	var card_scene = card_scene_reference
	var top_card = card_scene.instantiate()
	top_card.position = Vector2(COORD_X, COORD_Y)
	top_card.get_node("CardImage").texture = load(card_image_path)
	top_card.type = top_card_type
	
	return top_card

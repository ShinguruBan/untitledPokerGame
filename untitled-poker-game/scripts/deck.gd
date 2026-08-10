extends Node2D

const PLAYER_HAND_SIZE = 5
const CARD_SCENE_PATH = "res://scenes/card.tscn"

var player_deck = [	"Goblin", "Goblin", "Goblin", "Goblin", "Goblin", 
					"Mimic", "Mimic", "Mimic", "Mimic", "Mimic",
					"Skeleton", "Skeleton", "Skeleton", "Skeleton", "Skeleton",
					"Siren", "Siren", "Siren", "Siren", "Siren",
					"Chimera", "Chimera", "Chimera", "Chimera", "Chimera",
					"Dragon", "Dragon", "Dragon", "Dragon", "Dragon"]
var card_manager_reference
var player_hand_reference
var card_database_reference


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_deck.shuffle()
	card_manager_reference = $"../CardManager"
	player_hand_reference = $"../PlayerHand"
	card_database_reference = preload("res://scripts/card_database.gd")
	draw_starting_hand()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func draw_starting_hand():
	for i in range(PLAYER_HAND_SIZE):
		draw_card()

func draw_card():
	var card_drawn_type = player_deck[0]
	player_deck.erase(card_drawn_type)
	
	#hide the deck, when it is empty
	if player_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
	
	#construct the card that is about to be drawn
	var card_scene = preload(CARD_SCENE_PATH)
	var card_image_path = str("res://assets/card_textures/" + card_drawn_type + ".png")
	var new_card = card_scene.instantiate()
	new_card.get_node("CardImage").texture = load(card_image_path)
	new_card.type = card_drawn_type
	
	#add the constructed card to the players hand
	card_manager_reference.add_child(new_card)
	player_hand_reference.add_card_to_hand(new_card)

func replace_cards():
	var cards_to_draw = card_manager_reference.return_cards_to_deck()
	player_deck.shuffle()
	for i in cards_to_draw:
		draw_card()

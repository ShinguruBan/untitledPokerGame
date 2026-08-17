extends Node2D

const CARD_SCENE_PATH = "res://scenes/card.tscn"
const CARD_DRAW_SPEED = 0.15
const CARD_RETURN_SPEED = 0.25
const COORD_X = 420
const COORD_Y = 50

var deck = [	"Goblin", "Goblin", "Goblin", "Goblin", "Goblin", 
				"Mimic", "Mimic", "Mimic", "Mimic", "Mimic",
				"Skeleton", "Skeleton", "Skeleton", "Skeleton", "Skeleton",
				"Siren", "Siren", "Siren", "Siren", "Siren",
				"Chimera", "Chimera", "Chimera", "Chimera", "Chimera",
				"Dragon", "Dragon", "Dragon", "Dragon", "Dragon"]
var card_database_reference


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_database_reference = preload("res://scripts/card_database.gd")
	self.position = Vector2(COORD_X, COORD_Y)
	shuffle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
	var card_scene = preload(CARD_SCENE_PATH)
	#var card_image_path = str("res://assets/card_textures/" + top_card_type + ".png")
	var card_image_path = str("res://assets/card_textures/Dragon.png")
	var top_card = card_scene.instantiate()
	top_card.position = Vector2(COORD_X, COORD_Y)
	top_card.get_node("CardImage").texture = load(card_image_path)
	top_card.type = top_card_type
	
	return top_card

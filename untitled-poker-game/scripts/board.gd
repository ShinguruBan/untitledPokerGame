extends Node2D

const COMB_X_OFFSET = 108
const COMB_Y_OFFSET = 241
const COMB_X_DISTANCE = 40
const COMB_Y_DISTANCE = 32

var combination_database_reference
var note_scene_reference

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	combination_database_reference = preload("res://scripts/database_combination.gd")
	note_scene_reference = preload("res://scenes/note.tscn")
	create_combinations()
	create_hierarchy()
	create_interactivity()

func create_combinations():
	for combination in range(combination_database_reference.POSSIBLE_COMBINATIONS.size()):
		create_combination(combination)

func create_combination(combination):
	var randomness = [-2, -1, 0, 1, 2]
	for i in range(combination_database_reference.POSSIBLE_COMBINATIONS[combination][combination_database_reference.INDEX_VISUAL_REP].size()):
		var icon_image_path = str("res://assets/icon_textures/" + combination_database_reference.POSSIBLE_COMBINATIONS[combination][combination_database_reference.INDEX_VISUAL_REP][i] + ".png")
		var note_scene = note_scene_reference
		var note = note_scene.instantiate()
		
		var total_width = (combination_database_reference.BIGGEST_COMB_SIZE - 1) * COMB_X_DISTANCE
		var random_number = randomness[randi() % randomness.size()]
		var coord_x = (COMB_X_OFFSET) + (i * COMB_X_DISTANCE - total_width / 2) + random_number
		random_number = randomness[randi() % randomness.size()]
		var coord_y = COMB_Y_OFFSET - (combination * COMB_Y_DISTANCE) + random_number
		note.position = Vector2(coord_x, coord_y)
		
		note.get_node("IconImage").texture = load(icon_image_path)
		self.add_child(note)

func create_hierarchy():
	pass

func create_interactivity():
	pass

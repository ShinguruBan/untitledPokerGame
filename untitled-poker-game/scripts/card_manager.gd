extends Node2D

const COLLISION_MASK_CARD = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func switch_selection_value(card):
	if card.isCardSelected == false:
		select_card(card)
	else:
		deselect_card(card)

func select_card(card):
	card.position = card.position + Vector2(0, -50)
	card.isCardSelected = true

func deselect_card(card):
	card.position = card.position + Vector2(0, 50)
	card.isCardSelected = false
	
func deselect_all_cards():
	for i in self.get_children():
		if i.isCardSelected == true:
			deselect_card(i)

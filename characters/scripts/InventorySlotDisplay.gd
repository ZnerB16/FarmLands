extends CenterContainer

@onready var itemTextureRect = $ItemTextureRect

func displayItem(item):
	if item is Item:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = load("res://assets/Characters/slot.png")

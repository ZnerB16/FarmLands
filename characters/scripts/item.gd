extends Node2D

func _ready():
	if randi() % 2:
		$TextureRect.texture = load("res://assets/Objects/Egg item.png")
	else: 
		$TextureRect.texture = load("res://assets/Objects/Free_Chicken_House.png")

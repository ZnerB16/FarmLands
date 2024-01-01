extends Node2D

@onready var interactionArea = $InteractionArea
@onready var shop = $Shop

var canInteract: bool = true

func _ready():
	interactionArea.actionName = "Enter Shop"
	interactionArea.interact= Callable(self, "_shop")

func _physics_process(_delta):
	pass

func _shop():
	if(Input.is_action_pressed("interact")):
		shop.visible = true
		canInteract = true
		

func _on_interaction_area_body_entered(_body):
	pass # Replace with function body.

func _on_interaction_area_body_exited(_body):
	shop.visible = false

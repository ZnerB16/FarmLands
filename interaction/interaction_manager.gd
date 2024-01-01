extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const baseText = "Button/E to "

var activeAreas = []
var canInteract = true

func registerArea(area: InteractionArea):
	activeAreas.push_front(area)

func unregisterArea(area: InteractionArea):
	var index = activeAreas.find(area)
	if (index != -1):
		activeAreas.remove_at(index)

func _process(_delta):
	if (activeAreas.size() > 0 && canInteract):
		activeAreas.sort_custom(_sortByDistance)
		label.text = baseText + activeAreas[0].actionName
		label.global_position = activeAreas[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()

func _sortByDistance(area1, area2):
	var area1_Player = player.global_position.distance_to(area1.global_position)
	var area2_Player = player.global_position.distance_to(area2.global_position)
	return area1_Player < area2_Player

func _input(event):
	if (event.is_action_pressed("interact") && canInteract):
		if (activeAreas.size() > 0):
			canInteract = false
			label.hide()
			
			await activeAreas[0].interact.call()
			
			canInteract = true

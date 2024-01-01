extends Resource
class_name SlotData

const MAX_STACK_SIZE: int = 99

@export var itemData: ItemData
@export_range(1, MAX_STACK_SIZE) var quantity: int = 1: set = set_quantity

func set_quantity(	value: int):
	quantity = value
	if (quantity > 1 and not itemData.stackable):
		quantity = 1
		push_error("Is not stackable, quantity is now 1: " % itemData.name)

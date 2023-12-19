extends Resource
class_name Inventory

signal items_changed(indexes)

@export var items: Array[Resource]  = [
	null,
	null,
	null,
	null
]

func setItem(itemIndex, item):
	var previousItem = items[itemIndex]
	items[itemIndex] = item
	emit_signal("items_changed", [itemIndex])
	return previousItem

func swapItems(itemIndex, targetIndex):
	var targetItem = items[targetIndex]
	var item = items[itemIndex]
	items[targetIndex] = item
	items[itemIndex] = targetItem
	emit_signal("items_changed", [itemIndex, targetIndex])
	

func removeItem(itemIndex, item):
	var previousItem = items[itemIndex]
	items[itemIndex] = null
	emit_signal("items_changed", [itemIndex])
	return previousItem


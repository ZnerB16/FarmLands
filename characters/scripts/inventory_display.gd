extends GridContainer

var inventory = preload("res://characters/inventory.tres")

func _ready():
	inventory.connect("items_changed", onItemsChanged)
	updateInventoryDisplay()

func updateInventoryDisplay():
	for itemIndex in inventory.items.size():
		updateInventorySlot(itemIndex)

func updateInventorySlot(item_index):
	var inventorySlotDisplay = get_child(item_index)
	var item = inventory.items[item_index]
	inventorySlotDisplay.displayItem(item)

func onItemsChanged(indexes):
	for itemIndex in indexes:
		updateInventorySlot(itemIndex)

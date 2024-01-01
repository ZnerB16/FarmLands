extends Control

const Slot = preload("res://characters/scenes/slot.tscn")

@onready var itemGrid = $TextureRect/ItemGrid

func setInventoryData(inventoryData: InventoryData):
	populateItemGrid(inventoryData)

# Populate item grid with Slot scene
func populateItemGrid(inventoryData: InventoryData):
	for child in itemGrid.get_children():
		child.queue_free()
	
	for slots in inventoryData.slotDatas:
		var slot = Slot.instantiate()
		itemGrid.add_child(slot)
		
		slot.slotClicked.connect(inventoryData.onSlotClicked)
		
		if slots:
			slot.setSlotData(slots)


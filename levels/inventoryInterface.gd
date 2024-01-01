extends Control

@onready var inventory = $Inventory
@onready var grabbed_slot_node = $GrabbedSlot


var grabbedSlot: SlotData 

func _physics_process(_delta):
	if(grabbed_slot_node.visible):
		grabbed_slot_node.global_position = get_global_mouse_position() - Vector2(10, 10)

func setPlayerInventoryData(inventoryData: InventoryData):
	inventoryData.inventoryInteract.connect(onInventoryInteract)
	inventory.setInventoryData(inventoryData)

# On mouse left click, interact with slot
func onInventoryInteract(inventoryData: InventoryData, index: int, button: int):
	match[grabbedSlot, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbedSlot = inventoryData.grabSlotData(index)
	updateGrabbedSlot()
	
func updateGrabbedSlot():
	if(grabbedSlot):
		grabbed_slot_node.show()
		grabbed_slot_node.setSlotData(grabbedSlot)
	else:
		grabbed_slot_node.hide()

extends Resource
class_name InventoryData

signal inventoryInteract(inventoryData: InventoryData, index: int, button: int)

@export var slotDatas: Array[SlotData]

func onSlotClicked(index: int, button: int):
	inventoryInteract.emit(self, index, button)
	
func grabSlotData(index: int):
	var slotData = slotDatas[index]
	
	if (slotData):
		return slotData

	return null

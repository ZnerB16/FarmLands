extends PanelContainer

@onready var texture_rect = $MarginContainer/TextureRect
@onready var quantity_label = $QuantityLabel

signal slotClicked(index: int, button: int)

func setSlotData(slotData: SlotData):
	var itemData = slotData.itemData
	texture_rect.texture = itemData.texture
	tooltip_text = "%s\n%s" % [itemData.name, itemData.description]
	add_theme_font_size_override(tooltip_text, 7)
	
	
	if(slotData.quantity > 1):
		quantity_label.text = "x%s" % [slotData.quantity]
		quantity_label.show()
		
func putSlotData(slotData: SlotData, index: int, button: int):
	var itemData = slotData.itemData
	

func _on_gui_input(event):
	if event is InputEventMouseButton \
	and (event.button_index == MOUSE_BUTTON_LEFT \
	or event.button_index == MOUSE_BUTTON_RIGHT) \
	and event.is_pressed():
		slotClicked.emit(get_index(), event.button_index)

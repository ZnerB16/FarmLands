extends Node2D

@onready var player = $Player
@onready var menu = $PlayerMenu
@onready var axeButton = $PlayerMenu/NinePatchRect/AxeButton
@onready var hoeButton = $PlayerMenu/NinePatchRect/HoeButton
@onready var waterButton = $PlayerMenu/NinePatchRect/WaterButton
@onready var inventoryButton = $PlayerMenu/NinePatchRect/Inventory
@onready var inventory = $InventoryCanvas/InventoryInterface/Inventory
@onready var inventoryInterface = $InventoryCanvas/InventoryInterface
@onready var timer = $AnimationTimer
var axeAnimPlay: bool = false

func _ready():
	axeButton.pressed.connect(_axe_pressed)
	hoeButton.pressed.connect(_hoe_pressed)
	waterButton.pressed.connect(_water_pressed)
	inventoryButton.pressed.connect(_inventoryOpen)
	inventoryInterface.setPlayerInventoryData(player.inventoryData)

func _process(_delta):
	_timerEnded()

# Change visibility on click
func _inventoryOpen():
	if (inventory.visible):
		inventory.visible = false
	else:
		inventory.visible = true

# Swing axe 
func _axe_pressed():
	player.setSwing(true)
	timer.start()

# Swing Hoe
func _hoe_pressed():
	player.setSwingHoe(true)

# Water
func _water_pressed():
	player.setWater(true)

func _timerEnded():
	if(axeAnimPlay):
		Global.playerSwing = true
		axeAnimPlay = false
		timer.stop()

func _on_animation_timer_timeout():
	axeAnimPlay = true

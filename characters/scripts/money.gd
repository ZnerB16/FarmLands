extends CanvasLayer

@onready var moneyCount = $Background/GridContainer/MoneyCount
@onready var woodCount = $Background/GridContainer/WoodCount

func _physics_process(_delta):
	moneyCount.text = str(Global.money)
	woodCount.text = str(Global.wood)

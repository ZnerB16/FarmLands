extends CharacterBody2D

class_name Cow

enum COW_STATE { IDLE, WALK }

@export var speed: float = 15.0 
@export var idleTime: float = randf_range(2, 5)
@export var walkTime: float = randf_range(1, 3)

@onready var interactionArea = $InteractionArea
@onready var sprite = $CowSprite
@onready var animationTree = $AnimationTree
@onready var stateMachine = animationTree.get('parameters/playback')
@onready var timer = $AnimationTimer
@onready var popup = $Popup
@onready var popupMenu = $PopupMenu
@onready var label = $Label
@onready var lineEdit = $Popup/LineEdit
@onready var milk = $PopupMenu/NinePatchRect/Milk
@onready var set_name_cow = $PopupMenu/NinePatchRect/SetName

var canInteract = false
var direction: Vector2 = Vector2.ZERO
var currState: COW_STATE = COW_STATE.IDLE

func _ready():
	pickNewState()
	interactionArea.interact = Callable(self, "_changeName")
	popup.visible = false
	popupMenu.visible = false
	milk.disabled = false
	set_name_cow.disabled = false

func _physics_process(_delta):
	if(currState == COW_STATE.WALK):
		velocity = direction * speed
		move_and_slide()
	
	if(popupMenu.visible == false):
		canInteract = false
	else:
		currState = COW_STATE.IDLE
		direction = Vector2.ZERO
	
	updateAnimation(direction)

func selectNewDir():
	direction = Vector2(
		randf_range(-1, 1) + 0.1,
		randf_range(-1, 1) + 0.1
	)
	if(direction.x < 0):
		sprite.flip_h = true
	elif(direction.x > 0):
		sprite.flip_h = false

func updateAnimation(moveInput: Vector2):
	if(moveInput != Vector2.ZERO):
		animationTree.set('parameters/Walk/blend_position', moveInput)
	else:
		animationTree.set('parameters/Idle/blend_position', moveInput)
	
func pickNewState():
	if(currState == COW_STATE.IDLE):
		stateMachine.travel('Walk')
		currState = COW_STATE.WALK
		selectNewDir()
		timer.start(walkTime)
	elif(currState == COW_STATE.WALK):
		stateMachine.travel('Idle')
		currState = COW_STATE.IDLE
		timer.start(idleTime)
		
func _changeName():
	if (Input.is_action_pressed("interact")):
		popupMenu.visible = true
		canInteract = true

func _on_timer_timeout():
	pickNewState()
	idleTime = randf_range(2, 5)
	walkTime = randf_range(1, 3)

func _on_line_edit_text_submitted(new_text):
	popup.visible = false
	popupMenu.visible = false
	currState = COW_STATE.IDLE
	label.text = new_text

func _on_milk_pressed():
	pass # Replace with function body.

func _on_set_name_pressed():
	popup.visible = true

func _on_interaction_area_body_shape_exited(_body_rid, _body, _body_shape_index, _local_shape_index):
	popupMenu.visible = false
	popup.visible = false
	currState = COW_STATE.IDLE

func _on_line_edit_text_changed(new_text):
	label.text = new_text

func _on_econ_timer_timeout():
	Global.money += 10

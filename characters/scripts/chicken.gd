extends CharacterBody2D

class_name Chicken

enum CHICKEN_STATE { IDLE, WALK }

@export var speed: float = 25.0 
@export var idleTime: float = randf_range(3, 5)
@export var walkTime: float = randf_range(1, 5)

@onready var animationTree = $AnimationTree
@onready var sprite = $Sprite2D
@onready var timer = $AnimationTimer
@onready var stateMachine = animationTree.get('parameters/playback')
@onready var popup = $Popup
@onready var popupMenu = $PopupMenu
@onready var interactionArea = $InteractionArea
@onready var label = $Label
@onready var line_edit = $Popup/LineEdit
@onready var unknown = $PopupMenu/NinePatchRect/Unknown
@onready var set_name_chicken = $PopupMenu/NinePatchRect/SetName


var canInteract: bool = false
var direction: Vector2 = Vector2.ZERO
var currState: CHICKEN_STATE = CHICKEN_STATE.IDLE

func _ready():
	interactionArea.interact = Callable(self, "_changeName")
	pickNewState()
	popup.visible = false
	popupMenu.visible = false
	set_name_chicken.disabled = false
	unknown.disabled = false

func _physics_process(_delta):
	
	if(currState == CHICKEN_STATE.WALK):
		velocity = direction * speed
		move_and_slide()
	else:
		currState = CHICKEN_STATE.IDLE
		direction = Vector2.ZERO
	
	if(popupMenu.visible == false):
		canInteract = false
		
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
	
func _changeName():
	if (Input.is_action_pressed("interact")):
		popupMenu.visible = true
		canInteract = true

func pickNewState():
	if(currState == CHICKEN_STATE.IDLE):
		stateMachine.travel('Walk')
		currState = CHICKEN_STATE.WALK
		selectNewDir()
		timer.start(walkTime)
	elif(currState == CHICKEN_STATE.WALK):
		stateMachine.travel('Idle')
		currState = CHICKEN_STATE.IDLE
		timer.start(idleTime)
		
func _on_timer_timeout():
	pickNewState()
	idleTime = randf_range(3, 5)
	walkTime = randf_range(2, 5)

func _on_econ_timer_timeout():
	Global.money += 5

func _on_set_name_pressed():
	popup.visible = true

func _on_milk_pressed():
	pass

func _on_line_edit_text_changed(new_text):
	label.text = new_text

func _on_line_edit_text_submitted(new_text):
	popup.visible = false
	popupMenu.visible = false
	pickNewState()
	label.text = new_text

func _on_interaction_area_body_exited(_body):
	popupMenu.visible = false
	popup.visible = false
	pickNewState()

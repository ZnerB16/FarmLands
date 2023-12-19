extends CharacterBody2D

@export var moveSpeed: float = 75.0
@export var startingDir: Vector2 = Vector2(0, 1)

# parameters/Idle/blend_positiom
@onready var animationTree = $AnimationTree
@onready var axeButton = $Menu/NinePatchRect/AxeButton
	
var inputDirection: Vector2 = Vector2.ZERO
var swing: bool = false
var objectInRange: bool = false

func _ready():
	axeButton.pressed.connect(_on_pressed)

func _physics_process(_delta):
	# Input Direction
	inputDirection = Vector2(
		# minus right and left to cancel out if both keys are pressed, 
		# same with down and up
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if (inputDirection != Vector2.ZERO):
		setWalking(true)
		updateBlendPos()
	else:
		setWalking(false)
		
	# Update velocity
	velocity = inputDirection * moveSpeed
	
	move_and_slide()

func player():
	pass

# Swing Axe from Button
func setSwing(value = false):
	Global.playerSwing = false
	swing = value
	animationTree["parameters/conditions/swing"] = value

# check if walking
func setWalking(value):
	animationTree["parameters/conditions/isWalking"] = value
	animationTree["parameters/conditions/idle"] = !value

func updateBlendPos():
	animationTree["parameters/Idle/blend_position"] = inputDirection
	animationTree["parameters/Walk/blend_position"] = inputDirection
	animationTree["parameters/Swing/blend_position"] = inputDirection

func _on_pressed():
	setSwing(true)
	Global.playerSwing = true

func _on_player_hitbox_body_entered(body):
	if(body.has_method("object")):
		objectInRange = true

func _on_player_hitbox_body_exited(body):
	if(body.has_method("object")):
		objectInRange = false


extends CharacterBody2D
class_name Player

@export var moveSpeed: float = 50.0
@export var startingDir: Vector2 = Vector2(0, 1)
@export var inventoryData: InventoryData

# parameters/Idle/blend_positiom
@onready var anim = $AnimationPlayer
@onready var animationTree = $AnimationTree
	
var inputDirection: Vector2 = Vector2.ZERO
var swing: bool = false
var hoe: bool = false
var objectInRange: bool = false
var enemyInRange: bool = false

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

# Player object identifier
func player():
	pass

# Swing Axe from Button
func setSwing(value = false):
	Global.playerSwing = false
	animationTree["parameters/conditions/axe"] = value

# Swing Hoe from Button
func setSwingHoe(value = false):
	Global.playerHoe = false
	animationTree["parameters/conditions/hoe"] = value

# Water from Button
func setWater(value = false):
	Global.playerWater = false
	animationTree["parameters/conditions/water"] = value

# check if walking
func setWalking(value):
	animationTree["parameters/conditions/isWalking"] = value
	animationTree["parameters/conditions/idle"] = !value

func updateBlendPos():
	animationTree["parameters/Idle/blend_position"] = inputDirection
	animationTree["parameters/Walk/blend_position"] = inputDirection
	animationTree["parameters/Axe/blend_position"] = inputDirection
	animationTree["parameters/Hoe/blend_position"] = inputDirection
	animationTree["parameters/Water/blend_position"] = inputDirection
	
func _on_player_hitbox_body_entered(body):
	if(body.has_method("object")):
		objectInRange = true
	if(body.has_method("enemy")):
		enemyInRange = true

func _on_player_hitbox_body_exited(body):
	if(body.has_method("object")):
		objectInRange = false
	if(body.has_method("enemy")):
		enemyInRange = false


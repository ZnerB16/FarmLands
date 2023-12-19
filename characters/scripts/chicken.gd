extends CharacterBody2D

class_name Chicken

enum CHICKEN_STATE { IDLE, WALK }

@export var speed: float = 35.0 
@export var idleTime: float = randf_range(0, 5)
@export var walkTime: float = randf_range(0, 5)

@onready var animationTree = $AnimationTree
@onready var sprite = $Sprite2D
@onready var timer = $AnimationTimer
@onready var stateMachine = animationTree.get('parameters/playback')

var direction: Vector2 = Vector2.ZERO
var currState: CHICKEN_STATE = CHICKEN_STATE.IDLE

func _ready():
	pickNewState()

func _physics_process(_delta):
	if(currState == CHICKEN_STATE.WALK):
		velocity = direction * speed
		move_and_slide()

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

func _on_econ_timer_timeout():
	Global.money += 5

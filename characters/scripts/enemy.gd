extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
var speed: float = 75.0
var detected: bool = false
var player = null

var health: int = 2
var damage: int = 1
var dead: bool = false
var takeDamage: bool = true

@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer

@onready var detect_wall_1 = $DetectWall1
@onready var detect_wall_2 = $DetectWall2
@onready var detect_wall_3 = $DetectWall3
@onready var detect_wall_4 = $DetectWall4
@onready var detect_wall_5 = $DetectWall5
@onready var detect_wall_6 = $DetectWall6
@onready var detect_wall_7 = $DetectWall7
@onready var detect_wall_8 = $DetectWall8
@onready var detect_wall_9 = $DetectWall9
@onready var detect_wall_10 = $DetectWall10
@onready var detect_wall_11 = $DetectWall11
@onready var detect_wall_12 = $DetectWall12
@onready var detect_wall_13 = $DetectWall13
@onready var detect_wall_14 = $DetectWall14
@onready var detect_wall_15 = $DetectWall15
@onready var detect_wall_16 = $DetectWall16
@onready var detect_wall_17 = $DetectWall17
@onready var detect_wall_18 = $DetectWall18
@onready var detect_wall_19 = $DetectWall19
@onready var detect_wall_20 = $DetectWall20
@onready var detect_wall_21 = $DetectWall21
@onready var detect_wall_22 = $DetectWall22
@onready var detect_wall_23 = $DetectWall23
@onready var detect_wall_24 = $DetectWall24
@onready var detect_wall_25 = $DetectWall25
@onready var detect_wall_26 = $DetectWall26
@onready var detect_wall_27 = $DetectWall27
@onready var detect_wall_28 = $DetectWall28
@onready var detect_wall_29 = $DetectWall29
@onready var detect_wall_30 = $DetectWall30
@onready var detect_wall_31 = $DetectWall31
@onready var detect_wall_33 = $DetectWall33
@onready var detect_wall_34 = $DetectWall34
@onready var detect_wall_35 = $DetectWall35
@onready var detect_wall_36 = $DetectWall36
@onready var detect_wall_37 = $DetectWall37
@onready var detect_wall_38 = $DetectWall38
@onready var detect_wall_39 = $DetectWall39
@onready var detect_wall_40 = $DetectWall40

var playerInRange: bool = false

# Just a method for identifiying
func enemy():
	pass
	
func _ready():
	dead = false

func _physics_process(_delta):
	if(!dead):	
		dealDamage()
		# If any of the ray cast detects a player set to true
		detected = detectPlayerCast(detect_wall_1) || \
			detectPlayerCast(detect_wall_2) || \
			detectPlayerCast(detect_wall_3) || \
			detectPlayerCast(detect_wall_4) || \
			detectPlayerCast(detect_wall_5) || \
			detectPlayerCast(detect_wall_7) || \
			detectPlayerCast(detect_wall_8) || \
			detectPlayerCast(detect_wall_9) || \
			detectPlayerCast(detect_wall_10) || \
			detectPlayerCast(detect_wall_11) || \
			detectPlayerCast(detect_wall_12) || \
			detectPlayerCast(detect_wall_13) || \
			detectPlayerCast(detect_wall_14) || \
			detectPlayerCast(detect_wall_15) || \
			detectPlayerCast(detect_wall_16) || \
			detectPlayerCast(detect_wall_17) || \
			detectPlayerCast(detect_wall_18) || \
			detectPlayerCast(detect_wall_19) || \
			detectPlayerCast(detect_wall_20) || \
			detectPlayerCast(detect_wall_21) || \
			detectPlayerCast(detect_wall_22) || \
			detectPlayerCast(detect_wall_23) || \
			detectPlayerCast(detect_wall_24) || \
			detectPlayerCast(detect_wall_25) || \
			detectPlayerCast(detect_wall_26) || \
			detectPlayerCast(detect_wall_27) || \
			detectPlayerCast(detect_wall_28) || \
			detectPlayerCast(detect_wall_29) || \
			detectPlayerCast(detect_wall_30) || \
			detectPlayerCast(detect_wall_31) || \
			detectPlayerCast(detect_wall_33) || \
			detectPlayerCast(detect_wall_34) || \
			detectPlayerCast(detect_wall_35) || \
			detectPlayerCast(detect_wall_36) || \
			detectPlayerCast(detect_wall_37) || \
			detectPlayerCast(detect_wall_38) || \
			detectPlayerCast(detect_wall_39) || \
			detectPlayerCast(detect_wall_40)
		if(detected):
			move(player)
	else:
		self.queue_free()
	
func dealDamage():
	if(playerInRange and Global.playerSwing):
		if (takeDamage):
			health = health - 1
			animation_player.play("hit_flash")
			timer.start()
			takeDamage = false	
		if (health <= 0):
			animation_player.play("hit_flash")
			await animation_player.animation_finished
			dead = true
# Move to player
func move(_player):	
		position += (_player.position - position) / speed
		move_and_collide(velocity)

# Check if ray cast is colliding with player
func detectPlayerCast(raycast: RayCast2D):
	var body = raycast.get_collider()
	if(raycast.is_colliding()):
		if(body != null) && body.has_method("player"):	
			player = body
			return true
		else:
			return false

func _on_hitbox_body_entered(body):
	if(body.has_method("player")):
		playerInRange = true

func _on_hitbox_body_exited(body):
	if(body.has_method("player")):
		playerInRange = false


func _on_timer_timeout():
	takeDamage = true

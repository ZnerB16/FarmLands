extends StaticBody2D

@export var treeHealth = 3

@onready var healthBar = $HealthBar
@onready var animationPlayer = $AnimationPlayer
@onready var timer = $DamageTimer

var playerInRange: bool = false
var takeDamage: bool = true

func _physics_process(_delta):
	dealDamage()
	updateHealth()

func updateHealth():
	healthBar.value = treeHealth
	if(treeHealth >= 3):
		healthBar.visible = false
	else:
		healthBar.visible = true

func object():
	pass

func dealDamage():
	if (playerInRange and Global.playerSwing):
		if (takeDamage):
			animationPlayer.play("hit_flash")
			treeHealth = treeHealth - 1
			timer.start()
			takeDamage = false	
		if (treeHealth <= 0):
			animationPlayer.play("hit_flash")
			Global.wood += 1
			await animationPlayer.animation_finished
			self.queue_free() 
	
func _on_tree_hitbox_body_entered(body):
	if body.has_method("player"):
		playerInRange = true
		
func _on_tree_hitbox_body_exited(body):
	if body.has_method("player"):
		playerInRange = false

func _on_damage_timer_timeout():
	takeDamage = true

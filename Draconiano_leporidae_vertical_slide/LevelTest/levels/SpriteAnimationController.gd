extends KinematicBody

#onready var _animation_player: AnimationPlayer = $AnimationPlayer
onready var ppk_Crosshai = $CanvasLayer/Control/PPK/Crosshair
onready var ppk_Crosshai_Shoot = $CanvasLayer/Control/PPK/CrosshairShoot
onready var ppk_Shoot = $CanvasLayer/Control/PPK/Shoot
onready var ppk_Reload = $CanvasLayer/Control/PPK/Reload
onready var ppk_Idle = $CanvasLayer/Control/PPK/Idle
onready var animation = $AnimationPlayer

var is_crossing = false
func _ready():
		ppk_Shoot.visible = false
		ppk_Reload.visible = false
		ppk_Crosshai.visible = false
		ppk_Idle.visible = true
		animation.play("iDLE")
		

func _input(event):
	if event.is_action_pressed("click") and !is_crossing:
		ppk_Idle.visible = false
		ppk_Reload.visible = false
		ppk_Shoot.visible = true
		animation.play("shoot")
		
	elif event.is_action_pressed("reload") and !is_crossing:
		 ppk_Idle.visible = false
		 ppk_Shoot.visible = false
		 ppk_Reload.visible = true
		 
		 animation.play("Reload")

#	Crosshair
	elif event.is_action_pressed("Iron_Crosshair"):
		ppk_Idle.visible = false
		ppk_Reload.visible = false
		ppk_Shoot.visible = false
		ppk_Crosshai.visible = true
		is_crossing= true
		animation.play("Crosshair")
	elif event.is_action_released("Iron_Crosshair"):
		ppk_Idle.visible = false
		ppk_Shoot.visible = false
		ppk_Reload.visible = false
		animation.play_backwards("Crosshair")
#		_on_AnimationPlayer_animation_finished("Crosshair")
#	else:
#		ppk_Reload.visible = false
#		ppk_Shoot.visible = false
#		is_crossing= false
#		ppk_Crosshai.visible = false
#		ppk_Idle.visible = true
#		animation.play("iDLE")
	
	

func _on_AnimationPlayer_animation_finished(anim_name):
	ppk_Reload.visible = false
	ppk_Shoot.visible = false
	is_crossing= false
	ppk_Crosshai.visible = false
	ppk_Idle.visible = true
	animation.play("iDLE")

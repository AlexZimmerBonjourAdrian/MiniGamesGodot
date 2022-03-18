extends Spatial

onready var _animation_player: AnimationPlayer = $AnimationPlayer

var state_machine
var run_speed = 80
var reloads = ["reload","reload_not_ammo"]


var init_animation = 0

var _is_crosshair = false

func _ready():
	state_machine = $AnimationPlayer
	state_machine.play("idle")

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		state_machine.play("shoot")
		
	elif  event.is_action_released("click"):
	 _on_AnimationPlayer_animation_finished("shoot")
	
	elif event.is_action_pressed("reload"):
		state_machine.play("reload")
#		_animation_player.play("reload")
#		state_machine.travel("reload")
	elif event.is_action_pressed("hit"):
#		_animation_player.play("hit")
		state_machine.play("hit")
		
	elif event.is_action_pressed("Iron_Crosshair"):
		_animation_player.play("Corsshair")
		_is_crosshair = true
#	
	elif Input.is_action_just_released("Iron_Crosshair"):
	 _animation_player.play("OutCrosshair")
	 _is_crosshair = false
	
	
#	if event.is_action_pressed("click") and !_is_crosshair:
#		_animation_player.play("ShootCrosshair")
#

#func _unhandled_input(event):
#	if event.is_action_pressed("click"):
#		init_animation+= 1
#		if init_animation == 1:
#			_animation_player.play("Idle")
#			print("Idle")
#		if init_animation == 2:
#			_animation_player.play("Shoot")
#			print("Shoot")
#	#_animation_player.play("crosshair")
#		if init_animation == 3:
#			_animation_player.play("hit")
#			print("hit")
#		if init_animation == 4:
#			_animation_player.play("crosshair")
#			print("crosshair")
#		if init_animation == 5:
#			_animation_player.play("reload_not_ammo")
#		if init_animation == 6:
#			_animation_player.play("ChangeWeapon")
#		if init_animation >= 6:
#			init_animation = 0
#		if _animation_player.is_playing() == false:
#			init_animation += 1
#




func _on_AnimationPlayer_animation_finished(anim_name):
		state_machine.play("idle") 
	

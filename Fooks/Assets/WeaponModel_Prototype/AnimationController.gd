extends Spatial

onready var _animation_player: AnimationPlayer = $AnimationPlayer

var init_animation = 0

var _is_crosshair = false

func _ready():
	_animation_player.play("Idle")


func _unhandled_input(event):
	if Input.is_action_just_released("click") and _is_crosshair:
		_animation_player.play("Shoot")
		_animation_player.stop(false)
	
	if event.is_action_pressed("Reload"):
		_animation_player.play("Reload")
	
	if event.is_action_pressed("hit"):
		_animation_player.play("hit")
	
	if event.is_action_pressed("Iron_Crosshair"):
		_animation_player.play("Corsshair")
		_is_crosshair = true
	
	if Input.is_action_just_released("Iron_Crosshair"):
	 _animation_player.play("OutCrosshair")
	 _is_crosshair = false
	
	if event.is_action_pressed("click") and _is_crosshair:
		_animation_player.play("ShootCrosshair")
		
	#if event.is_action_pressed("crosshair"):
	#	_animation_player.play("")



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



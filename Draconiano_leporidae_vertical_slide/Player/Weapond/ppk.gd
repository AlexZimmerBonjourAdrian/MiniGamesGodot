extends Weapon
#onready var _animation_player: AnimationPlayer = $AnimationPlayer
onready var ppk_Crosshai = $PPK/Crosshair
onready var ppk_Crosshai_Shoot = $PPK/CrosshairShoot
onready var ppk_Shoot = $PPK/Shoot
onready var ppk_Reload = $PPK/Reload
onready var ppk_Idle = $PPK/Idle
onready var animation = $AnimationPlayer

var is_crossing 

func _ready():
		ppk_Shoot.visible = false
		ppk_Reload.visible = false
		ppk_Crosshai.visible = false
		ppk_Idle.visible = true
		is_crossing= false
		#animation_player = $AnimationPlayer
		
		animation.connect("animation_finished",self,"on_animation_finish")
		animation.play("iDLE")
func _input(event):	
#	Crosshair
	if event.is_action_pressed("Iron_Crosshair"):
		ppk_Idle.visible = false
		ppk_Reload.visible = false
		ppk_Shoot.visible = false
		ppk_Crosshai.visible = true
		setIsCrossing(true)
		animation.play("Crosshair")
		
	if event.is_action_released("Iron_Crosshair"):
#		ppk_Idle.visible = false
#		ppk_Shoot.visible = false
#		ppk_Reload.visible = false
		animation.play_backwards("Crosshair")
		if(animation.get_animation("Crosshair") and animation.is_playing()):
			setIsCrossing(false)
#		if(_on_AnimationPlayer_animation_finished("Crosshair")):
#			setIsCrossing(false)
			
	elif event.is_action_pressed("click"):
		if (is_crossing==false):
			ppk_Idle.visible = false
			ppk_Crosshai.visible = false
			ppk_Reload.visible = false
			ppk_Shoot.visible = true
			animation.play("shoot")
		
	elif event.is_action_pressed("reload"):
		if(is_crossing==false):
			 ppk_Idle.visible = false
			 ppk_Crosshai.visible = false
			 ppk_Shoot.visible = false
			 ppk_Reload.visible = true
			 animation.play("Reload")
#		if(animation.is_playing() == false):
#				setIsCrossing(false)
#				ppk_Idle.visible = true
#				animation.play("iDLE")
		
#	else:
#		ppk_Reload.visible = false
#		ppk_Shoot.visible = false
#		is_crossing= false
#		ppk_Crosshai.visible = false
#		ppk_Idle.visible = true
#		animation.play("iDLE")
#	print(is_crossing)
#	update_Print(is_crossing)

#	ppk_Reload.visible = false
#	ppk_Shoot.visible = false

#	ppk_Crosshai.visible = false

func setIsCrossing(Crossing):
	is_crossing = Crossing
	
func on_animation_finish(anim_name):
	.on_animation_finish(anim_name)
#func update_Print(testprinter):
#	$Control/Background/Print.text = String(testprinter)
func equip():
	update_ammo()
	
func unequip():
	pass

func is_equip_finished():
	return true
func is_unequip_finished():
	return true

func update_ammo(action = "Refresh"):
	
		var weapon_data = {
			"Name" : weapon_name
		}
		weapon_manager.update_hud(weapon_data)

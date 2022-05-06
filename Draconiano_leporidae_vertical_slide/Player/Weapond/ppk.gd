extends Armed
#onready var _animation_player: AnimationPlayer = $AnimationPlayer
onready var ppk_Crosshai = $PPK/Crosshair
onready var ppk_Crosshai_Shoot = $PPK/CrosshairShoot
onready var ppk_Shoot = $PPK/Shoot
onready var ppk_Reload = $PPK/Reload
onready var ppk_Idle = $PPK/Idle
onready var animation = $AnimationPlayer
#onready var RayNormal = $Camera/Normal
#onready var RayCrosshair = $Crosshair



var is_crossing 
var class_data = load("res://Player/Weapond/Weapons/Pistol/PPK/PPK.tres")

func _ready():

		is_crossing= false
		is_reloading= false
		
		#animation_player = $AnimationPlayer
		loadDataWeapon()
		
		
		animation.connect("animation_finished",self,"on_animation_finish")
		animation.play("iDLE")
		
		
		
func _input(event):	
#	Crosshair
	if event.is_action_pressed("Iron_Crosshair"):
		Hideall()
		showCrosshair()
		setIsCrossing(true)
		animation.play("Crosshair")
	_crosshair(event)
	
	if event.is_action_released("Iron_Crosshair"):
		ppk_Idle.visible = false
		ppk_Shoot.visible = false
		ppk_Reload.visible = false
		animation.play_backwards("Crosshair")
		if(animation.get_animation("Crosshair") and animation.is_playing()):
			setIsCrossing(false)
#		if(_on_AnimationPlayer_animation_finished("Crosshair")):
#			setIsCrossing(false)
				
	if event.is_action_pressed("click"):
		if (is_crossing==false && is_reloading == false):
			Hideall()
			showShoot()
			animation.play("shoot")
#			detection_enemy_shoot()
		elif event.is_action_released("click"):
			if(on_animation_finish("shoot")):
				Hideall()
				showShoot()
				
	elif event.is_action_pressed("reload"):
		if(is_crossing==false):
			 Hideall()
			 showReload()
			 is_reloading = true
			 animation.play("Reload")
	elif(event.is_action_released("reload")):
		if(on_animation_finish("Reload")):
#			is_reloading = false
			Hideall()
			showIdle()	
		
		
		
		
		
#
#func equip():
#	.equip()
#
#func unequip():	
#	.unequip()
#
		

#func _input(event):	
#	match state:
#			STATE_IDLE:
#				Hideall()
#				showIdle()
#				animation.play("iDLE")
#				if(event.is_action_pressed("click")):
#					setState(STATE_SHOOT)
#				if(event.is_action_pressed("reload")):
#					setState(STATE_RELOAD)
#				if(event.is_action_pressed("Iron_Crosshair")):
#					setState(STATE_CROSSHAIR)
#			STATE_SHOOT:
#				Hideall()
#				showShoot()
#				if (event.is_action_pressed("click")):
##					if (is_crossing==false && is_reloading == false):	
#					animation.play("shoot")
##			detection_enemy_shoot()
##				elif Input.is_action_released("click"):
#				if(_on_AnimationPlayer_animation_finished("shoot") && !animation.is_playing()):
#					print("sale del estado")
#					setState(STATE_IDLE)
#			STATE_RELOAD:
#				Hideall()
#				showReload()
#				if (Input.is_action_pressed("reload")):
##					if (is_crossing==false && is_reloading == false):	
#					animation.play("Reload")
#				if(on_animation_finish("Reload")):
#					setState(STATE_IDLE)
#			STATE_CROSSHAIR:
#				Hideall()
#				showCrosshair()
#				if event.is_action_pressed("Iron_Crosshair"):
##						setIsCrossing(true)
#						animation.play("Crosshair")
#				if event.is_action_pressed("click"):
#					Hideall()
#					showCrosshairShoot()
#					animation.play("CrosshairShoot")
#					if(on_animation_finish("Crosshair")):
#						Hideall()
#						showCrosshair()
##					_crosshair(event)
##				if event.is_action_released("Iron_Crosshair"):
##					animation.play_backwards("Crosshair")
#					if(on_animation_finish("Crosshair")):
#						setState(STATE_IDLE)
#	Crosshair

#		if(_on_AnimationPlayer_animation_finished("Crosshair")):
#			setIsCrossing(false)
				

	
	
	
#	elif(event.is_action_released("reload")):
#		if(on_animation_finish("Reload")):
#			is_reloading = false
#			ppk_Reload.visible = false
#			ppk_Idle.visible = true
	
	
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
	
					
				
				
func _crosshair(event):
	if(event.is_action_pressed("click") && is_crossing):
#		print("Entra aqui")
		ppk_Crosshai.visible = false
		ppk_Crosshai_Shoot.visible = true
		animation.play("CrosshairShoot") 
		
#	if(on_animation_finish("CrosshairShoot") and is_shoot_crosshair):
	if(animation.get_animation("CrosshairShoot") and !animation.is_playing()):
		on_animation_finish("CrosshairShoot")
#		print("Entra aqui tambien")
		Hideall()
		showCrosshair()
	
#	elif (event.is_action_released("Iron_Crosshair")):
	
func loadDataWeapon():
#	print(class_data.get_class().)
	accuarcy = class_data.accuarcy
	equip_speed = class_data.equip_speed
	unequip_speed = class_data.unequip_speed
	reload_speed = class_data.reload_speed 
	weapon_name = class_data.weapon_name
	typeWeapon = class_data.typeWeapon
	recoil = class_data.recoil
	offset = class_data.offset
	multidisparo = class_data.multidisparo
	exparsion = class_data.exparsion
	ammo_in_mag = class_data.ammo_in_mag
	extra_ammo = class_data.extra_ammo
	damage = class_data.damage
	fire_rate = class_data.fire_rate
	
func Hideall():
	ppk_Shoot.visible = false
#	ppk_Reload.visible = false
	ppk_Crosshai.visible = false
	ppk_Crosshai_Shoot.visible = false
	ppk_Idle.visible = false
	ppk_Reload.visible = false
func showCrosshair():
	ppk_Crosshai.visible = true
func showCrosshairShoot():
	ppk_Crosshai_Shoot.visible = true
func showReload():
	ppk_Reload.visible = true
func showIdle():
	ppk_Idle.visible = true

func showShoot():
	ppk_Shoot.visible = true
		
#func detection_enemy_shoot():
#	if(get_node("Normal").is_colliding()):
#		var col = get_node("Normal").get_collider()
#		if(col.is_in_group("Enemy")):
#			col.call("dead")
#
#func detection_enemy_crosshair():
#	if(get_node("Crosshair").is_colliding()):
#		var col = get_node("Shoot").get_collider()
#		if(col.is_in_group("Enemy")):
#			col.dead()
#func update_Print(testprinter):
#	$Control/Background/Print.text = String(testprinter)


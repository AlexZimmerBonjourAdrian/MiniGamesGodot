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


func _ready():
		ppk_Shoot.visible = false
		ppk_Reload.visible = false
		ppk_Crosshai.visible = false
		ppk_Crosshai_Shoot.visible = false
		ppk_Idle.visible = false
		is_crossing= false
		is_reloading= false
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
			ppk_Idle.visible = false
			ppk_Crosshai.visible = false
			ppk_Reload.visible = false
			ppk_Shoot.visible = true
			animation.play("shoot")
#			detection_enemy_shoot()
		elif event.is_action_released("click"):
			if(on_animation_finish("shoot")):
				ppk_Shoot.visible = false
				ppk_Idle.visible = true
	
	
	elif event.is_action_pressed("reload"):
		if(is_crossing==false):
			 ppk_Idle.visible = false
			 ppk_Crosshai.visible = false
			 ppk_Shoot.visible = false
			 ppk_Reload.visible = true
			 is_reloading = true
			 animation.play("Reload")
	elif(event.is_action_released("reload")):
		if(on_animation_finish("Reload")):
			is_reloading = false
			ppk_Reload.visible = false
			ppk_Idle.visible = true
	
	
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
		
	elif(event.is_action_pressed("click") and animation.get_animation("CrosshairShoot") and !animation.is_playing()):
#		print("Entra aqui tambien")
		ppk_Crosshai_Shoot.visible = false
		ppk_Crosshai.visible = true
	
#	elif (event.is_action_released("Iron_Crosshair")):
		
		
		
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

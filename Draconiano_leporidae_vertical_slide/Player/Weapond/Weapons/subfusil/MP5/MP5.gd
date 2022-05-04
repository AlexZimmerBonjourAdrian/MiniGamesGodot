extends Armed

var class_data = load("res://Player/Weapond/Weapons/subfusil/MP5/MP5k.tres")


onready var MP5K_Crosshair = $MP5/Crosshair
onready var MP5K_Crosshair_Shoot = $MP5/CrosshairShoot
onready var MP5K_Shoot = $MP5/Shoot
onready var MP5K_Reload = $MP5/Reload
onready var MP5K_Idle = $MP5/Idle
onready var animationplayer = $AnimationPlayer
var is_crossing 

func _ready():
	
	is_crossing= false
	is_reloading= false
	loadDataWeapon()

func _input(event):
	if event.is_action_pressed("Iron_Crosshair"):
		Hideall()
		showCrosshair()
		print("Entra en Crosshair")
	_crosshair(event)
	if event.is_action_released("Iron_Crosshair"):
		print("sale del crosshair")
	
	if event.is_action_pressed("click"):
		while(event.is_action_pressed("click")):
			print("shoot")
	elif event.is_action_released("click"):
		print("deja de disparar")
	
	elif event.is_action_pressed("reload"):
		print("Reload")
		
	elif(event.is_action_released("reload")):
		print("deja de recargar")
	
	
func setIsCrossing(Crossing):
	is_crossing = Crossing
		
func loadDataWeapon():
	accuarcy=class_data.accuarcy
	equip_speed=class_data.equip_speed
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

func _crosshair(event):
	if(event.is_action_pressed("click") && is_crossing):
		MP5K_Crosshair.visible = false
		MP5K_Crosshair_Shoot.visible = true
#		animation.play("CrosshairShoot") 

func Hideall():
	MP5K_Shoot.visible = false
#	ppk_Reload.visible = false
	MP5K_Crosshair.visible = false
	MP5K_Crosshair_Shoot.visible = false
	MP5K_Idle.visible = false
	MP5K_Reload.visible = false
func showCrosshair():
	MP5K_Crosshair.visible = true
	
func showCrosshairShoot():
	MP5K_Crosshair_Shoot.visible = true
	
func showReload():
	MP5K_Reload.visible = true
	
func showIdle():
	MP5K_Idle.visible = true
	
func showShoot():
	MP5K_Shoot.visible = true

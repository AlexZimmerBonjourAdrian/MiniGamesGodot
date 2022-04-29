extends KinematicBody

#onready var _animation_player: AnimationPlayer = $AnimationPlayer
onready var ppk_Crosshai = $CanvasLayer/Control/PPK/Crosshair
onready var ppk_Crosshai_Shoot = $CanvasLayer/Control/PPK/CrosshairShoot
onready var ppk_Shoot = $CanvasLayer/Control/PPK/Shoot
onready var ppk_Reload = $CanvasLayer/Control/PPK/Reload
onready var ppk_Idle = $CanvasLayer/Control/PPK/Idle
onready var animation = $AnimationPlayer

var is_crossing 

func _ready():
		ppk_Shoot.visible = false
		ppk_Reload.visible = false
		ppk_Crosshai.visible = false
		ppk_Idle.visible = true
		is_crossing= false
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

func update_Print(testprinter):
	$Control/Background/Print.text = String(testprinter)

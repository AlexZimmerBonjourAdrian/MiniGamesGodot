extends Weapon

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
		var aleatorio = rand_range(0,1)
		match aleatorio:
			0:
				state_machine.play("shoot")
			1:	
				state_machine.play("shoot_alt")
	elif (event.is_action_pressed("click") and _is_crosshair):
		var aleatorio = rand_range(0,1)
		match aleatorio:
			0:
				state_machine.play("Shoot_Crosshair")
			1:	
				state_machine.play("Shoot_Crosshair2")
		
	elif  event.is_action_released("click"):
	 _on_AnimationPlayer_animation_finished("Shoot")
	
	elif event.is_action_pressed("reload"):
		state_machine.play("Reload")
#		_animation_player.play("reload")
#		state_machine.travel("reload")
#	elif event.is_action_pressed("hit"):
##		_animation_player.play("hit")
#		state_machine.play("hit")
		
	
	elif event.is_action_pressed("Iron_Crosshair"):
		_animation_player.play("Crosshair")
		_is_crosshair = true
#	
	elif Input.is_action_just_released("Iron_Crosshair"):
	 _animation_player.play("OutCrosshair")
	 _is_crosshair = false

func setisCrosshair(cross):
	_is_crosshair = cross
func _on_AnimationPlayer_animation_finished(anim_name):
		state_machine.play("idle") 

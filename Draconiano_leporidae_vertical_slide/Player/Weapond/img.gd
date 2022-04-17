
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
#extends Weapon
#
#func _ready():
#
#	animation_player = $AnimationPlayer
##	animation_player.connect("animation_finished",self, "on_animation_finish")
#
#func _unhandled_input(event):
#	if event.is_action_pressed("click"):
#		state_machine.play("shoot")
#
#
#
#
#func on_animation_finish(anim_name):
#	on_animation_finish(anim_name)


func _on_AnimationPlayer_animation_finished(anim_name):
		state_machine.play("idle") 
	

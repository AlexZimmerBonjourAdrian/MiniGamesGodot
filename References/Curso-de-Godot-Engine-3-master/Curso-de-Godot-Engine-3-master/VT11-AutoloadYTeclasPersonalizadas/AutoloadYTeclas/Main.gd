extends Node

func _ready():
	print(MyScriptGlobal.RES_X)
	MyScriptGlobal.hola()
	
func _process(delta):
	if Input.is_action_just_pressed("propia_tecla"):
		print("hola mundo")


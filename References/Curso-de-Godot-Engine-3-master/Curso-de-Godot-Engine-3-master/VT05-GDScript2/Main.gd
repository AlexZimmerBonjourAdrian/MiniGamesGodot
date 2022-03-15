extends Node

func _ready():
	some_method()
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

func some_method():
	print("hola furiosos")
	
	if 11 == 10:
		print("ohh es 10")
	elif 5 == 5:
		print("ohh es 5")
	else:
		print("no es ninguno")
		
	for i in range(5):
		print(i)
		
	var i = 0
	
	while i < 6:
		print(i)
		i += 1
		
	var mi_variable = "hola"
		
	match mi_variable:
		"chao": print("Es chao")
		"hola": print("Es hola")
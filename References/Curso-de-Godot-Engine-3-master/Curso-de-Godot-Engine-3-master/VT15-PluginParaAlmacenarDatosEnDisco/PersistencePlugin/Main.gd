extends Node

func _ready():
	Persistence.load_data("Juanito")
	var data = Persistence.get_data("Juanito")
	
	data["NuevoDato"] = 123
	
	Persistence.save_data("Juanito")
	
	print(data["NuevoDato"])
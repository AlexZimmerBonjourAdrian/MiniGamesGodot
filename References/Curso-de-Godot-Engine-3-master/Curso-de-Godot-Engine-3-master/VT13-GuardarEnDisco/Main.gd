extends Node

func _ready():
	$Label.text = str(Persistence.data["Puntaje"])
	
func _on_Button_pressed():
	Persistence.data["Puntaje"] += 1
	$Label.text = str(Persistence.data["Puntaje"])
	
	Persistence.save_data()
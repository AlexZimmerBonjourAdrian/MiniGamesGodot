extends Node

func _ready():
	$GameJoltAPI.open_session()

func _on_GameJoltAPI_api_session_opened(success):
	var data = {
		Hola = "chao",
		true : false
	}
	
#	$GameJoltAPI.add_score("1000 jumps", 1000, "FuryGamesStudio", "MyToken")
	$GameJoltAPI.set_data("myData", "Hola")
	
func _on_GameJoltAPI_api_scores_added(success):
	print("Fue añadido")

func _on_GameJoltAPI_api_data_set(success):
	print(success)

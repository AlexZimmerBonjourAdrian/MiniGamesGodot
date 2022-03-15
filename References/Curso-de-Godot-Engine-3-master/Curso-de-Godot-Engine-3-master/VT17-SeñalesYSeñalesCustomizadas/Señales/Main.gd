extends Node

func _ready():
	$ProgressBar.connect("completed", self, "_on_completed", ["Hola Mundo"])
	
func _on_completed(saluda):
	print("Se a emitido la señal: ", saluda)

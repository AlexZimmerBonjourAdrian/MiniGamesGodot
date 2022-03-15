extends Node

const PATH = "user://data.dat"
const PATH_JSON = "user://data_json.dat"
const PASS = "abc123"

var is_loaded = false

var data = {
	"Puntaje" : 0,
	"AlgoMas" : true
}

var data_json = {
	"Puntaje" : 0,
	AlgoMas = {
		"Hola1" : true,
		"Hola2" : false
	}
}

func _ready():
	var file = File.new()
	
	if file.file_exists(PATH):
		load_data()
	else:
		save_data()
		load_data()
	
func save_data():
	var file = File.new()
	
	file.open_encrypted_with_pass(PATH, File.WRITE, PASS)
	file.store_var(data)
	file.close()
	
	is_loaded = false
	
func save_data_json():
	var file = File.new()
	
	file.open(PATH_JSON, File.WRITE)
	file.store_line(to_json(data_json))
	file.close()
	
	is_loaded = false

func load_data():
	if is_loaded:
		return
	
	var file = File.new()
	
	file.open_encrypted_with_pass(PATH, File.READ, PASS)
	data = file.get_var()
	file.close()
	
	is_loaded = true

func load_data_json():
	if is_loaded:
		return
	
	var file = File.new()
	
	file.open(PATH, File.READ)
	data = parse_json(file.get_line())
	print(data)
	file.close()
	
	is_loaded = true

# + Los datos se almacenan como una pila donde el primero en entrar
# es el primero en salir.
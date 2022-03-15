extends Node

# class member variables go here, for example:
var a = 2.2
var arr = ["hola", 2, 3.14]
var dict = {"hola" : "chao", 1 : 2, true : false}

const RES_X = 1280
const RES_Y = 720

enum {UP=5, RIGHT, DOWN, LEFT}
enum CategoriaItem {DANADO, NORMAL, EPICO}

func _ready():
	a = "hola"
	
	print(CategoriaItem.DANADO)
	print(get_path())

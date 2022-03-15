tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("ZyppyNodo", "Node", preload("res://addons/ZyppyNodo/ZyppyNodo.gd"), preload("res://addons/ZyppyNodo/zyppy.png"))
	
func _exit_tree():
	remove_custom_type("ZyppyNodo")

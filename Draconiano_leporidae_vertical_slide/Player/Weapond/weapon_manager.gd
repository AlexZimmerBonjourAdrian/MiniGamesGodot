extends Node2D


var all_weapons = {}

var weapons = {}

var hud 

var current_weapon  # Referencia a el arma que se esta usando el jugador en ese momento
var current_weapon_slot = "Primary" # The current weapon slot 



var changing_weapon = false 
var unequipped_weapon = false

var weapon_index = 0 # For switching weapons through mouse wheel

func _ready():
	
	get_tree().call_group("RayManager","set_WeaponManager",self)
	 # Adds exception of player to the shooting raycast
	hud = owner.get_node("HUD")
#	Raycast.add_exception(owner)
	 # Agrega una esepcion de detecion para que no detecte al jugador 
	#ejemplo de enum en godot
	all_weapons = {
#		"Unarmed" : preload("res://Player/weapond/unarmed.tscn"),
		"Ppk" : preload("res://Player/Weapond/ppk.tscn")
	}
	weapons = {
#		"Empty" : $Unarmed,
		"Primary": $Ppk
#		"Secundary": $Weapon_B
	}
	# inicializacion de las referencias usando un for each de las armas 
	for w in weapons:
		if weapons[w] != null:
			weapons[w].weapon_manager = self
			weapons[w].player = owner
#			weapons[w].ray = get_parent().get_node("Camera/Reach")
			weapons[w].visible = false
	
	#Set current weapon to unarmed
	current_weapon = weapons["Primary"]
	change_weapon("Primary")
	
	set_process(false)
	
	#process mientras se llama el cambio de armas
func _process(delta):
	
	if unequipped_weapon == false:
		if current_weapon.is_unequip_finished() == false:
			return	
			
		unequipped_weapon = true
		
		current_weapon = weapons[current_weapon_slot]
		current_weapon.equip()
		
	if current_weapon.is_equip_finished() == false:
		return
		
	changing_weapon = false
	set_process(false)
			
func change_weapon(new_weapon_slot):
	if new_weapon_slot == current_weapon_slot:
		current_weapon.update_ammo() # Refresh
		return
		
	if weapons[new_weapon_slot] == null:
		return
		
	current_weapon_slot = new_weapon_slot
	changing_weapon = true
	
	weapons[current_weapon_slot].update_ammo() # actualiza la cantidad de municion que pose el arma que se esta usando en el momento
	update_weapon_index()
	# Change Weapons
	if current_weapon != null:
		unequipped_weapon = false
		current_weapon.unequip()
		
	set_process(true)


# Scroll weapon change
func update_weapon_index():
	match current_weapon_slot:
#		"Empty":
#			weapon_index = 0
		"Primary":
			weapon_index = 0
#		"Secondary":
#			weapon_index = 2


func next_weapon():
	weapon_index += 1
	
	if weapon_index >= weapons.size():
		weapon_index = 0
	
	change_weapon(weapons.keys()[weapon_index])

func previous_weapon():
	weapon_index -= 1
	
	if weapon_index < 0:
		weapon_index = weapons.size() - 1
	
	change_weapon(weapons.keys()[weapon_index])

# update HUB
func update_hud(weapon_data):
	var weapon_slot = "1"
	
	match current_weapon_slot:
#		"Empty":
#			weapon_slot = "1"
		"Primary":
			weapon_slot = "1"
#		"secundary":
#			weapon_slot = "3"		
	hud.update_weapon_ui(weapon_data, weapon_slot)

# Firing and Reloading
func fire():
	if not changing_weapon:
#		if current_weapon_slot != "Empty":
				current_weapon.fire()
				current_weapon.fireCrosshair()
		
#func fire_stop():
#	current_weapon.fire_stop()
	
func reload():
 if not changing_weapon:
		current_weapon.reload()
		
func getCurrentWeapon():
	return current_weapon
	


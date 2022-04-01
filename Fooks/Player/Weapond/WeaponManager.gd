extends Node


var all_weapons = {}

var weapons = {}

var hud

var current_weapon # Referencia a el arma que se esta usando el jugador en ese momento
var current_weapon_slot = "Empty" # The current weapon slot 

var changing_weapon = false 
var unequipped_weapon = false

func _ready():
	
	hud = owner.get_node("HUD")
	#ejemplo de enum en godot
	all_weapons = {
		"MachineGun" : preload("res://Assets/WeaponModel_Prototype/img.tscn"),
		"mousling" : preload ("res://Assets/WeaponModel_Prototype/Mousling.tscn")	
	}
	
	weapons = {
		"Empty" : $Unaread,
		"Primary": $Weapon_A,
		"Secundary": $Weapon_B
		
	}
	# inicializacion de las referencias usando un for each de las armas 
	for w in weapons:
		if weapons[w] != null:
			weapons[w].weapon.manager = self
			weapons[w].player = owner
			weapons[w].visible = false
	
	current_weapon = weapons["Empty"]
	change_weapon("Empty")
	
	set_process(false)
	
	#process mientras se llama el cambio de armas
func _Process(delta):
	
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
	
	# Change Weapons
	if current_weapon != null:
		unequipped_weapon = false
		current_weapon.unequip()
		
	set_process(true)

# update HUB
func update_hud(weapon_data):
	var weapon_slot = "1"
	
	match current_weapon_slot:
		"Empty":
			weapon_slot = "1"
		"Primary":
			weapon_slot = "2"
		"secundary":
			weapon_slot = "3"
	hud.update_weapon_ui(weapon_data, weapon_slot)

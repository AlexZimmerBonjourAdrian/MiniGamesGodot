extends Node2D
class_name Weapon

# References
var weapon_manager = null
var player = null
var ray = null
var isEmpty = false
# Weapon States
var is_equipped = false

# Weapon Parameters
export var weapon_name = "Weapon"
#export(Texture) var weapon_image = null


#Equip/Unequip Cycle
# Equip/Unequip Cycle
func equip():
	pass

func unequip():
	pass

func is_equip_finished():
	return true

func is_unequip_finished():
	return true

# Update Ammo
func update_ammo():
	var weapon_data = {
		"Name" : weapon_name,
#		"Image" : weapon_image
	}
	if(weapon_manager != null):
		weapon_manager.update_hud(weapon_data)


extends Control

func update_weapon_ui(weapon_data,weapon_slot):
	$Backround/WeaponUI.text = weapon_data["Name"] + ":" + "0/0"
	$Backround/Display/WeaponSlot.text = weapon_slot 

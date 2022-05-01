extends Armed

var class_data = load("res://Player/Weapond/Weapons/RifleAsalto/XM8/XM8.tres")


func loadDataWeapon():
	accuarcy=class_data.accuarcy
	equip_speed=class_data.equip_speed
	unequip_speed = class_data.unequip_speed
	reload_speed = class_data.reload_speed 
	weapon_name = class_data.weapon_name
	typeWeapon = class_data.typeWeapon
	recoil = class_data.recoil
	offset = class_data.offset
	multidisparo = class_data.multidisparo
	exparsion = class_data.exparsion
	ammo_in_mag = class_data.ammo_in_mag
	extra_ammo = class_data.extra_ammo
	damage = class_data.damage
	fire_rate = class_data.fire_rate

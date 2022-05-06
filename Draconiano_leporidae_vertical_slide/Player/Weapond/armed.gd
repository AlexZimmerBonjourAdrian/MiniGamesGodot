extends Weapon
class_name Armed

# References
var animation_player

# Weapon States
var is_firing = false
var is_reloading = false
# Weapon Parameters

#rigidbody Version
export(PackedScene) var weapon_pickup

# Effects
export(PackedScene) var impact_effect
export(NodePath) var muzzle_flash_path
#onready var muzzle_flash = get_node(muzzle_flash_path)

# Optional
export var equip_speed = 1.0
export var unequip_speed = 1.0
export var reload_speed = 1.0
export var accuarcy = 1.0
export var typeWeapon = "Weapon"
export var recoil = 1.0
export var offset = 1.0
export var multidisparo = false
export var exparsion=1.0
export var ammo_in_mag = 15
export var extra_ammo = 30
onready var mag_size = ammo_in_mag
export var damage = 10
export var fire_rate = 1.0

export var is_shoot = false
export var is_crosshair = false
export var is_shoot_crosshair = false
# Fire Cycle
func fire():
	if not is_reloading:
		if ammo_in_mag > 0:
			
			if not is_firing:
				is_firing = true
#				animation_player.get_animation("shoot").loop = true
#				animation_player.play("shoot", -1.0, fire_rate)
			return
		
		elif is_firing:
			fire_stop()

func fire_stop():
	is_firing = false
#	is_shoot_crosshair = false
#	animation_player.get_animation("shoot").loop = false
	
func fireCrosshair():
	if not is_reloading:
		
		if ammo_in_mag > 0:
			if not is_shoot_crosshair:
#				print("Entra")
				fire_bullet()
				is_shoot_crosshair = true
				
			return
#		elif is_shoot_crosshair:
#			fire_stop()
	

func fire_bullet():    # Will be called from the animation track
	update_ammo("consume")
###	muzzle_flash.emitting = true
#		update_ammo(fire)
		
#
#	ray.force_raycast_update()
	
#	if ray.is_colliding():
#		var impact = Global.instantiate_node(impact_effect, ray.get_collision_point())
#		impact.emitting = true

# Reload
func reload():
	if ammo_in_mag < mag_size and extra_ammo > 0:
		is_firing = false
		
#		animation_player.play("reload", -1.0, reload_speed)
		update_ammo("reload")
		is_reloading = true

## Equip/Unequip Cycle
func equip():
	show_weapon()
#	animation_player.play("Equip", -1.0, equip_speed)
	is_reloading = false

func unequip():
#	animation_player.play("Unequip", -1.0, unequip_speed)
	hide_weapon()
#


func is_equip_finished():
	if is_equipped:
		return true
	else:
		return false

func is_unequip_finished():
	if is_equipped:
		return false
	else:
		return true


# Show/Hide Weapon
func show_weapon():
	visible = true

func hide_weapon():
	visible = false

# Animation Finished
func on_animation_finish(anim_name):
	match anim_name:
		"Unequip":
			is_equipped = false
		"Equip":
			is_equipped = true
		"Reload":
			is_reloading = false
		"shoot":
			is_shoot = false
		"Crosshair":
			is_crosshair = false	
		"CrosshairShoot":
			is_shoot_crosshair = false
		

func update_ammo(action = "Refresh", additional_ammo = 0):
	
	match action:
		"consume":
			ammo_in_mag -= 1
		
		"reload":
			var ammo_needed = mag_size - ammo_in_mag
			
			if extra_ammo > ammo_needed:
				ammo_in_mag = mag_size
				extra_ammo -= ammo_needed
			else:
				ammo_in_mag += extra_ammo
				extra_ammo = 0
		
		"add":
			extra_ammo += additional_ammo
	
	var weapon_data = {
		"Name" : weapon_name,
#		"Image" : weapon_image,
		"Ammo" : str(ammo_in_mag),
		"ExtraAmmo" : str(extra_ammo),
		"Accuarcy" : accuarcy,
# 		"typeWeapon": typeWeapon,
		"Recoil"	: recoil,
		"Offset"    : offset,
		"Multidisparo": multidisparo,
		"Exparsion" : exparsion,
		"typeWeapon" : typeWeapon
		}
	if(weapon_manager != null):
		weapon_manager.update_hud(weapon_data)
	
func getName():
	return weapon_name
func getAmmo():
	return ammo_in_mag
func getExtraWeapon():
	return extra_ammo
func getAccuarcy():
	return accuarcy
func getRecoil():
	return recoil
func getOffset():
	return offset
func getMultidisparo():
	return multidisparo
func getExparsion():
	return exparsion
func getReturn():
	return typeWeapon
func getTypeWeapon():
	return typeWeapon		

func drop_weapon():
	var pickup = Global.instantiate_node(weapon_pickup, global_transform.origin - player.global_transform.basis.z.normalized())
	pickup.ammo_in_mag = ammo_in_mag
	pickup.extra_ammo = extra_ammo
	pickup.mag_size = mag_size	

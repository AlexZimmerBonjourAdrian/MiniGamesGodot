extends Spatial

# var weapon_manager = null
#var weapon_manager
#var weapon_manager = null
var weapon_manager = null
func _ready():
	pass

func _physics_process(delta):
#	if weapon_manager.isUnarmed():
		if Input.is_action_just_pressed("click"):
			var isunarmed = weapon_manager.isUnarmed()
			if(isunarmed == false):
				var direct_state = get_world().direct_space_state
				var collision = direct_state.intersect_ray(transform.origin, Vector3(0,0,-100))
				tipoWeapon()
#		if(collision):
#			print(collision.position)
#func checkTipeWeapon():
#		var tipeWeapon = 
#		match

#weapon_manager.update_hud(weapon_data)
func tipoWeapon():
	var weapon = weapon_manager.getCurrentWeapon().getTypeWeapon()
	var direct_state = get_world().direct_space_state
	match weapon:
		"Pistol":
			var bullet = direct_state.intersect_ray(transform.origin, Vector3(0,0,-100))
			if(bullet):
				if(bullet.is_in_group("Enemy")):
					bullet.call("dead")
		"Shootgun":
			var bullet1 = direct_state.intersect_ray(transform.origin, Vector3(0,0,-100))
			var bullet2 = direct_state.intersect_ray(transform.origin, Vector3(0,0,-100))
			var bullet3 = direct_state.intersect_ray(transform.origin, Vector3(0,0,-100))
			var bullet4 = direct_state.intersect_ray(transform.origin, Vector3(0,0,-100))
			var bullet5 = direct_state.intersect_ray(transform.origin, Vector3(0,0,-100))
			var bullet6 = direct_state.intersect_ray(transform.origin, Vector3(0,0,-100))
			
			if(bullet1.is_in_group("Enemy")):
				bullet1.call("dead")
			if(bullet2.is_in_group("Enemy")):
				bullet2.call("dead")
			if(bullet3.is_in_group("Enemy")):
				bullet3.call("dead")
			if(bullet4.is_in_group("Enemy")):
				bullet4.call("dead")
			if(bullet5.is_in_group("Enemy")):
				bullet5.call("dead")
			if(bullet6.is_in_group("Enemy")):
				bullet6.call("dead")
			
		"rifledeassalto":
			while(Input.is_action_just_pressed("click")):
				var bullet = direct_state.intersect_ray(transform.origin, Vector3(0,0,-100))
				if(bullet.is_in_group("Enemy")):
					bullet.call("dead")
		"rifledetirador":
			var bullet = direct_state.intersect_ray(transform.origin, Vector3(0,0,-1000))
			if(bullet.is_in_group("Enemy")):
				bullet.call("dead")
		"subfusil":
			while(Input.is_action_just_pressed("click")):
				var bullet = direct_state.intersect_ray(transform.origin, Vector3(0,0,-500))
				if(bullet.is_in_group("Enemy")):
					bullet.call("dead")
		"carabina":
			var bullet1 = direct_state.intersect_ray(transform.origin, Vector3(0,0,-100))
			var bullet2 = direct_state.intersect_ray(transform.origin, Vector3(0,0,-100))
			var bullet3 = direct_state.intersect_ray(transform.origin, Vector3(0,0,-100))
			if(bullet1.is_in_group("Enemy")):
				bullet1.call("dead")
			if(bullet2.is_in_group("Enemy")):
				bullet2.call("dead")
			if(bullet3.is_in_group("Enemy")):
				bullet3.call("dead")
		"microfusil":
			while(Input.is_action_just_pressed("click")):
				var bullet = direct_state.intersect_ray(transform.origin, Vector3(0,0,-500))
				if(bullet.is_in_group("Enemy")):
					bullet.call("dead")
func set_WeaponManager(weapon_m):
	weapon_manager = weapon_m

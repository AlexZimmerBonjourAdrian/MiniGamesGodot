extends Spatial

#Documentation
#Raycast info 1  https://www.youtube.com/watch?v=am-fb2fFNzM
#R
onready var weapon_manager = null
#var weapon = null
func _ready():
	pass
	
func _physics_process(delta):
	if Input.is_action_just_pressed("click"):
#		var direct_state = get_world().direct_space_state
#		var collision = direct_state.intersect_ray(transform.origin,Vector3(0,0,-100))
			CheckTipeWeapon()
		

func CheckTipeWeapon():
	var WeaponTypeCurrent = weapon_manager.current_weapon().getTipoWeapon()
	match WeaponTypeCurrent:
			"Pistol":
				var direct_state = get_world().direct_space_state
				var collision_bullet = direct_state.intersect_ray(transform.origin,Vector3(0,0,-100))
			"Carabina":
				var direct_state = get_world().direct_space_state
				var collision_bullet_1 = direct_state.intersect_ray(transform.origin,Vector3(0,0,-100))
				var collision_bullet_2 = direct_state.intersect_ray(transform.origin,Vector3(0,0,-100))
				var collision_bullet_3 = direct_state.intersect_ray(transform.origin,Vector3(0,0,-100))
				if(collision_bullet_1.is_in_group("Enemy")):
					collision_bullet_1.call("dead")
				
				elif (collision_bullet_2.is_in_group("Enemy")):
					collision_bullet_2.call("dead")
				
				elif (collision_bullet_3.is_in_group("Enemy")):
					collision_bullet_3.call("dead")
				
			"Rifle":
				var direct_state = get_world().direct_space_state
				var collision_bullet = direct_state.intersect_ray(transform.origin,Vector3(0,0,-1000))
				if(collision_bullet.is_in_group("Enemy")):
					collision_bullet.call("dead")
				
				
			"Escopeta":
				var direct_state = get_world().direct_space_state
				var collision_bullet_perdigon_1 = direct_state.intersect_ray(transform.origin,Vector3(0,rand_range(-10,10),-100))
				var collision_bullet_perdigon_2 = direct_state.intersect_ray(transform.origin,Vector3(0,rand_range(-10,10),-60))
				var collision_bullet_perdigon_3 = direct_state.intersect_ray(transform.origin,Vector3(0,rand_range(-10,10),-200))
				var collision_bullet_perdigon_4 = direct_state.intersect_ray(transform.origin,Vector3(0,rand_range(-10,10),-100))
				var collision_bullet_perdigon_5 = direct_state.intersect_ray(transform.origin,Vector3(0,rand_range(-10,10),-100))
				var collision_bullet_perdigon_6 = direct_state.intersect_ray(transform.origin,Vector3(0,rand_range(-10,10),-100))
				if(collision_bullet_perdigon_1.is_in_group("Enemy")):
					collision_bullet_perdigon_1.call("dead")
				if(collision_bullet_perdigon_2.is_in_group("Enemy")):
					collision_bullet_perdigon_2.call("dead")
				if(collision_bullet_perdigon_3.is_in_group("Enemy")):
					collision_bullet_perdigon_3.call("dead")
				if(collision_bullet_perdigon_4.is_in_group("Enemy")):
					collision_bullet_perdigon_4.call("dead")
				if(collision_bullet_perdigon_5.is_in_group("Enemy")):
					collision_bullet_perdigon_5.call("dead")
				if(collision_bullet_perdigon_6.is_in_group("Enemy")):
					collision_bullet_perdigon_6.call("dead")
				
			"Subfusil":
				var direct_state = get_world().direct_space_state
				while(Input.is_action_just_released("click")):
					var collision_bullet = direct_state.intersect_ray(transform.origin,Vector3(0,0,-80))
					if(collision_bullet.is_in_group("Enemy")):
						collision_bullet.call("dead")		
			"Rifledeasalto":
				var direct_state = get_world().direct_space_state
				while(Input.is_action_just_released("click")):
					var collision_bullet = direct_state.intersect_ray(transform.origin,Vector3(0,0,-300))
			"microfusil":
				var direct_state = get_world().direct_space_state
				while(Input.is_action_just_released("click")):
					var collision_bullet = direct_state.intersect_ray(transform.origin,Vector3(0,0,-50))

			
		

#func offsetRaycasting():


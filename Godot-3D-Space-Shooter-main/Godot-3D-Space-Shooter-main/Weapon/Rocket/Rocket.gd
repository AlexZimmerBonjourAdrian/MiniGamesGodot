extends KinematicBody

var velo = Vector3()
var KillParticles = load("res://KillParticles.tscn")
var enemy = null
onready var main = get_tree().current_scene
#onready var explodeSound = $EnemyExplode

#func _ready():
#	get_tree().call_group("Enemys", "set_Enemy",self)
func _physics_process(delta):
#	move_and_slide(velo)
	# velo = enemy.translation - translation
#	vel_to_enemy = vel_to_enemy.normalized()
	move_and_slide(velo)

func _on_Area_body_entered(body):
	if body.is_in_group("Enemies"):
		var particles = KillParticles.instance()
		main.add_child(particles)
		particles.transform.origin = transform.origin
		body.queue_free()
#		explodeSound.play()
		visible = false
		$Area/CollisionShape.disabled = true

#func _on_LightTimer_timeout():
#	$OmniLight.visible = false
#

func _on_Timer_timeout():
	queue_free() 
	
func set_enemy(e):
	enemy = e

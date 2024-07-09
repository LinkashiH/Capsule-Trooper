extends CharacterBody3D

@export var SPEED : float
@onready var nav_agent = %NavigationAgent3D

var health = 100


func _process(delta):
	if health <= 0:
		queue_free()

func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() *SPEED
	
	nav_agent.set_velocity_forced(new_velocity)
	
	
	
	velocity = new_velocity
	move_and_slide()


func update_target_location(target_location):
	nav_agent.set_target_position(target_location)
	look_at(Vector3(target_location.x,global_position.y,target_location.z),Vector3.UP)


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()


func _on_detection_area_body_entered(body):
	if body.is_in_group("Trooper"):
		nav_agent.navigation_layers = 1
	else:
		nav_agent.navigation_layers = 2

extends CharacterBody3D

class_name Enemy
@export var healthbar : ProgressBar

var health = 100


func _process(delta):
	Global.debug.add_property("Enemy Health",health,2)
	if health <= 0:
		queue_free()

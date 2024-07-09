extends Node3D

const  ads_lerp = 20

@export var camera : Camera3D

@export var defaut_position : Vector3
@export var ADS_position : Vector3
var fview = {"Default": 75, "ADS": 40}


func _process(delta):
	if Input.is_action_pressed("aim"):
		transform.origin = transform.origin.lerp(ADS_position, ads_lerp * delta)
		camera.fov = lerpf(camera.fov, fview["ADS"],ads_lerp * delta)
	else:
		transform.origin = transform.origin.lerp(defaut_position, ads_lerp * delta)
		camera.fov = lerpf(camera.fov, fview["Default"],ads_lerp * delta)
		

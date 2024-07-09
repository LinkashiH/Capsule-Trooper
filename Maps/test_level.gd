extends Node3D


@onready var player = $"CanvasLayer/Armor Select Screen".player

func _physics_process(delta):
	get_tree().call_group("Enemy","update_target_location", player.global_transform.origin)

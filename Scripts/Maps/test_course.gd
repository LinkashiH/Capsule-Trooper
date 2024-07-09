extends Node3D

@export var spawn_trigger : Area3D
@export var enemy_scene : PackedScene 
@export var enemy_spawns: Array[Node3D] = []
var enemy
var enemy2
var enemy3

func _ready():
	pass


func _on_spawn_trigger_body_entered(body):
	enemy = enemy_scene.instantiate() as Enemy
	enemy2 = enemy_scene.instantiate() as Enemy
	enemy3 = enemy_scene.instantiate() as Enemy
	enemy_spawns[0].add_child(enemy)
	enemy_spawns[1].add_child(enemy2)
	enemy_spawns[2].add_child(enemy3)

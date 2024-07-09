extends Control

@export var spawn : Node3D
@export var player_scene : PackedScene
@export var A_weapon_scene : PackedScene
@export var H_weapon_scene : PackedScene
@export var R_weapon_scene : PackedScene
@export var S_weapon_scene : PackedScene
var player
var level

@export var H_button : Button
@export var R_button : Button
@export var S_button : Button


func _ready():
	player = player_scene.instantiate() as Player
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED


func _process(delta):
	level = player.level
	if level == 1:
		H_button.visible = false
		R_button.visible = false
		S_button.visible = false

func _on_assault_trooper_pressed():
	spawn_player("Assault")


func _on_heavy_trooper_pressed():
	spawn_player("Heavy")


func _on_raider_trooper_pressed():
	spawn_player("Raider")


func _on_support_trooper_pressed():
	spawn_player("Support")

func spawn_player(armor_type : String) -> void:
	var armor := load("res://Assets/Resources/Armor/%s Trooper.tres" % armor_type) as PowerArmor
	var weapon_logic
	var weapon
	if armor_type == "Assault":
		weapon_logic = load("res://Assets/Resources/Weapons/MK-4 Bullpup AR.tres") as Weapon
		weapon = A_weapon_scene.instantiate() as MeshInstance3D
	elif armor_type == "Heavy":
		weapon_logic = load("res://Assets/Resources/Weapons/MK-6 Heavy Machine Gun.tres") as Weapon
		weapon = H_weapon_scene.instantiate() as MeshInstance3D
	elif armor_type == "Raider":
		weapon_logic = load("res://Assets/Resources/Weapons/MK-16 Full Auto Shotgun.tres") as Weapon
		weapon = R_weapon_scene.instantiate() as MeshInstance3D
	elif armor_type == "Support":
		weapon_logic = load("res://Assets/Resources/Weapons/Mk-3 Support Rifle.tres") as Weapon
		weapon = S_weapon_scene.instantiate() as MeshInstance3D
	
	
	player.load_armor(armor)
	player.load_gun(weapon_logic)
	player.hand.add_child(weapon)
	spawn.add_child(player)
	queue_free()

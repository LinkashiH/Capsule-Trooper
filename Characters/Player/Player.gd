class_name Player
extends CharacterBody3D

signal Update_Ammo




@export var first_name : String
@export var last_name : String
@export var level : int
@export var camera_controller : Node3D
@export var camera : Camera3D
@export var crosshairs : TextureRect
@export var label : Label
@export var name_tape : Label
@export var rangecast : RayCast3D
@export var animation_player : AnimationPlayer 
@export var gun_anim_player : AnimationPlayer
@export var acceleration : float = 0.1
@export var deceleration : float = 0.25 

@export var power_armor : PowerArmor = null
@export var weapon : Weapon = null

var SPEED
var default_SPEED = 5
var thrust_SPEED = 10
var JUMP_VELOCITY = 5
var aimrange = -10
var armor_name : String
var rank : String
var full_name : String


var camera_rotation = Vector2(0,0)
var mouse_sensitivity = .005
var base_fov = 75.0
var fov_change = 1.5


@export var hand : Node3D
enum {NULL, HITSCAN, PROJECTILE}
var damage = 10


var is_thrusting : bool = false
var can_thrust : bool = true

var gravity = 9.8

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.player = self
	level2rank()
	full_name = rank + " " + first_name + " " + last_name
	emit_signal("Update_Ammo",[weapon.current_ammo, weapon.reserve_ammo])
	damage *= power_armor.damage


func _input(event):
	if event is InputEventMouseMotion:
		var mouse_event = event.relative * mouse_sensitivity
		cameralook(mouse_event)
	if event.is_action_pressed("fire_main"):
		shoot()
	if event.is_action_pressed("reload"):
		reload()

func _process(delta):
	pass


func cameralook(Movement: Vector2):
	camera_rotation += Movement
	
	camera_rotation.y = clamp(camera_rotation.y, -1.5,1.2)
	
	transform.basis = Basis()
	camera_controller.transform.basis = Basis()
	
	
	rotate_object_local(Vector3(0,1,0), -camera_rotation.x)
	camera_controller.rotate_object_local(Vector3(1,0,0), -camera_rotation.y)

func _physics_process(delta):
	Global.debug.add_property("Ray Colliding", rangecast.is_colliding(), 1)
	aimrange -= power_armor.range
	rangecast.target_position.z = aimrange
	if power_armor == null:
		armor_name = "None"
	else:
		armor_name = power_armor.armor_name
	label.text = armor_name
	name_tape.text = full_name
	

func update_gravity(delta) -> void:
	velocity.y -= gravity * delta

func update_input(speed: float, acceleration: float, deceleration: float, delta) -> void:
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = lerp(velocity.x,direction.x * speed,acceleration)
			velocity.z = lerp(velocity.z,direction.z * speed,acceleration)
		else:
			velocity.x = move_toward(velocity.x, 0, deceleration)
			velocity.z = move_toward(velocity.z, 0, deceleration)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta* 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta* 3.0)

func update_velocity() -> void:
	move_and_slide()

func load_armor(armor: PowerArmor) -> void:
	power_armor = armor
func load_gun(gun: Weapon) -> void:
	weapon = gun
func level2rank():
	if level == 0:
		rank = "REC"
	elif level == 1:
		rank = "PVT"
	elif level == 2:
		rank = "PFC"
	elif level == 3:
		rank = "CPL"
	else:
		pass

func shoot():
	if weapon.current_ammo != 0:
		if !gun_anim_player.is_playing():
			if Input.is_action_pressed("aim"):
				gun_anim_player.play(weapon.aim_shoot_anim)
			else:
				gun_anim_player.play(weapon.shoot_anim)
			weapon.current_ammo -= 1
			emit_signal("Update_Ammo",[weapon.current_ammo, weapon.reserve_ammo])
			match weapon.type:
				NULL:
					print("None")
				HITSCAN:
					if rangecast.is_colliding():
						var target = rangecast.get_collider()
						if target.is_in_group("Enemy"):
							target.health -= damage
				PROJECTILE:
					pass
	else:
		reload()

func reload():
	if weapon.current_ammo == weapon.magazine:
		return
	elif !gun_anim_player.is_playing():
		if weapon.reserve_ammo != 0:
			gun_anim_player.play(weapon.reload_anim)
			var reload_amount = min(weapon.magazine-weapon.current_ammo,weapon.magazine,weapon.reserve_ammo)
			
			weapon.current_ammo += reload_amount
			weapon.reserve_ammo -= reload_amount
			
			emit_signal("Update_Ammo",[weapon.current_ammo, weapon.reserve_ammo])
		else:
			gun_anim_player.play(weapon.ammo_out_anim)


func _on_gun_animation_player_animation_finished(anim_name):
	if anim_name == weapon.shoot_anim or anim_name == weapon.aim_shoot_anim:
		if weapon.auto_fire == true:
			if Input.is_action_pressed("fire_main"):
				shoot()


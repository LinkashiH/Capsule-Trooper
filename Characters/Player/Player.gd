class_name Player
extends CharacterBody3D
@export var first_name : String
@export var last_name : String
@export var level : int
@export var camera_controller : Node3D
@export var camera : Camera3D
@export var power_armor : PowerArmor = null
@export var label : Label
@export var name_tape : Label
@export var rangecast : RayCast3D
@export var animation_player : AnimationPlayer 
@export var acceleration : float = 0.1
@export var deceleration : float = 0.25 



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




var is_thrusting : bool = false
var can_thrust : bool = true

var gravity = 9.8

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.player = self
	level2rank()
	full_name = rank + " " + first_name + " " + last_name


func _input(event):
	if event is InputEventMouseMotion:
		var mouse_event = event.relative * mouse_sensitivity
		cameralook(mouse_event)

func cameralook(Movement: Vector2):
	camera_rotation += Movement
	
	camera_rotation.y = clamp(camera_rotation.y, -1.5,1.2)
	
	transform.basis = Basis()
	camera_controller.transform.basis = Basis()
	
	
	rotate_object_local(Vector3(0,1,0), -camera_rotation.x)
	camera_controller.rotate_object_local(Vector3(1,0,0), -camera_rotation.y)

func _physics_process(delta):
	Global.debug.add_property("Can Thrust", can_thrust, 1)
	Global.debug.add_property("Thrusting", is_thrusting, 2)
	rangecast.target_position.z = aimrange 
	if power_armor == null:
		armor_name = "None"
	else:
		armor_name = power_armor.armor_name
	label.text = armor_name
	name_tape.text = full_name


	var velocity_clamped = clamp(velocity.length(), 0.5, thrust_SPEED * 2)
	var target_fov = base_fov + fov_change * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)

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

func load_armor(armor : PowerArmor):
	armor = power_armor
	
func level2rank():
	if level == 1:
		rank = "PVT"
	elif level == 2:
		rank = "PFC"
	elif level == 3:
		rank = "CPL"
	else:
		pass

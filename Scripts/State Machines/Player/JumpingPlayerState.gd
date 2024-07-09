class_name JumpingPlayerState
extends PlayerMovementState

@export var speed : float = 5
@export var acceleration : float = 0.1
@export var deceleration : float = 0.25
@export var JUMP_VELOCITY : float
@export_range(0.5,1.0,0.01) var input_multiplyer : float = 0.85


func enter() -> void:
	JUMP_VELOCITY = player.JUMP_VELOCITY
	if player.power_armor != null:
		JUMP_VELOCITY += player.power_armor.mobility
	player.velocity.y += JUMP_VELOCITY
	animation.pause()

func exit() -> void:
	player.is_thrusting = false

func update(delta):
	player.update_gravity(delta)
	player.update_input(speed * input_multiplyer,acceleration,deceleration,delta)
	player.update_velocity()
	
	if Input.is_action_just_pressed("jump") and player.velocity.y > 0 and player.can_thrust:
		player.is_thrusting = true
		transition.emit("HoverPlayerState")
	
	if player.is_on_floor():
		transition.emit("IdlePlayerState")
	if player.velocity.y < -3.0 and player.is_on_floor() == false:
		transition.emit("FallingPlayerState")

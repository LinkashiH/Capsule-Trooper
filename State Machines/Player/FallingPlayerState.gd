class_name FallingPlayerState
extends PlayerMovementState

@export var speed : float = 8
@export var acceleration : float = 0.1
@export var deceleration : float = 0.25
@export var fall_gravity : float = 12


func enter() -> void:
	animation.pause()
	player.gravity = fall_gravity

func update(delta):
	
	player.update_gravity(delta)
	player.update_input(speed,acceleration,deceleration,delta)
	player.update_velocity()
	
	if Input.is_action_just_pressed("jump") and player.can_thrust:
		transition.emit("HoverPlayerState")
	
	if player.is_on_floor():
		transition.emit("IdlePlayerState")

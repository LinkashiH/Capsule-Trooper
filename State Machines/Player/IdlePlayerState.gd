class_name IdlePlayerState
extends PlayerMovementState

@export var speed : float = 6
@export var acceleration : float = 0.1
@export var deceleration : float = 0.25 

func enter() -> void:
	animation.pause()
	

func update(delta):
	player.update_gravity(delta)
	player.update_input(speed,acceleration,deceleration,delta)
	player.update_velocity()
	
	if Input.is_action_just_pressed("crouch") and player.is_on_floor():
		transition.emit("CrouchingPlayerState")
	
	if player.velocity.length() > 0.0 and player.is_on_floor():
		transition.emit("RunningPlayerState")
	
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		transition.emit("JumpingPlayerState")
		
	if player.velocity.y < -3.0 and player.is_on_floor() == false:
		transition.emit("FallingPlayerState")

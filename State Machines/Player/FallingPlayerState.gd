class_name FallingPlayerState
extends PlayerMovementState

@export var speed : float = 8
@export var acceleration : float = 0.1
@export var deceleration : float = 0.25
#@export var JUMP_VELOCITY : float
#@export_range(0.5,1.0,0.01) var input_multiplyer : float = 0.85


func enter() -> void:
	#JUMP_VELOCITY = player.JUMP_VELOCITY
	#if player.power_armor != null:
		#JUMP_VELOCITY += player.power_armor.mobility
	#player.velocity.y += JUMP_VELOCITY
	animation.pause()

func update(delta):
	player.update_gravity(delta)
	player.update_input(speed,acceleration,deceleration,delta)
	player.update_velocity()
	
	if Input.is_action_just_pressed("jump") and player.can_thrust:
		transition.emit("HoverPlayerState")
	
	if player.is_on_floor():
		transition.emit("IdlePlayerState")

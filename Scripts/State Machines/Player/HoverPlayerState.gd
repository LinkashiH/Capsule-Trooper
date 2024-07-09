class_name  HoverPlayerState
extends PlayerMovementState

@export var speed : float = 6
@export var acceleration : float = 0.1
@export var deceleration : float = 0.25 
@export var thrust_time : Timer
@export var hover_gravity : float = -1.0
@export var hover_terminal_velocity : float = -2.0

func enter() -> void:
	thrust_time.start()
	if player.power_armor != null:
		speed += player.power_armor.mobility


func update(delta):
	
	player.update_gravity(delta)
	player.update_input(speed,acceleration,deceleration,delta)
	player.update_velocity()
	
	player.velocity.y = max(player.velocity.y + hover_gravity * delta, hover_terminal_velocity)
	
	if Input.is_action_just_released("jump") or thrust_time.is_stopped():
		player.is_thrusting = false
		transition.emit("IdlePlayerState")


class_name RunningPlayerState
extends PlayerMovementState

@export var speed : float
@export var acceleration : float = 0.1
@export var deceleration : float = 0.25 
@export var top_anim_speed : float = 2.2

func enter() -> void:
	animation.play("Running", -1.0,1.0)
	speed = player.default_SPEED
	if player.power_armor != null:
		speed += player.power_armor.mobility
func exit() -> void:
	animation.speed_scale = 1.0

func update(delta):
	player.update_gravity(delta)
	player.update_input(speed,acceleration,deceleration,delta)
	player.update_velocity()
	set_animation_speed(player.velocity.length())
	if player.velocity.length() == 0.0:
		transition.emit("IdlePlayerState")
	
	if Input.is_action_just_pressed("crouch") and player.is_on_floor():
		transition.emit("CrouchingPlayerState")
	
	if Input.is_action_pressed("thrust") and player.velocity.length() > 0.0 and player.can_thrust:
		player.is_thrusting = true
		transition.emit("ThrustingPlayerState")
	
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		transition.emit("JumpingPlayerState")
	if player.velocity.y < -3.0 and player.is_on_floor() == false:
		transition.emit("FallingPlayerState")

func set_animation_speed(spd):
	var alpha = remap(spd,0.0,speed,0.0,1.0)
	animation.speed_scale = lerp(0.0, top_anim_speed, alpha)


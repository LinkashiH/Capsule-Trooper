class_name CrouchingPlayerState
extends PlayerMovementState

@export var speed : float = 5
@export var acceleration : float = 0.1
@export var deceleration : float = 0.25
@export_range(1,6,0.1) var crouch_speed : float = 4.0
@export var shapecast : ShapeCast3D

func enter() -> void:
	animation.play("Crouch", -1.0,crouch_speed)
	

func update(delta):
	player.update_gravity(delta)
	player.update_input(speed,acceleration,deceleration,delta)
	player.update_velocity()
		
	if Input.is_action_just_released("crouch"):
		uncrouch()
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		transition.emit("JumpingPlayerState")

func uncrouch():
	if shapecast.is_colliding() == false and Input.is_action_pressed("crouch") == false:
		animation.play("Crouch", -1.0, -crouch_speed* 1.5, true)
		if animation.is_playing():
			await animation.animation_finished
		transition.emit("IdlePlayerState")
	elif shapecast.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch()

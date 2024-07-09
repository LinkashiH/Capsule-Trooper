class_name SlidingPlayerState
extends PlayerMovementState

@export var speed : float
@export var acceleration : float = 0.1
@export var deceleration : float = 0.25
@export_range(1,6,0.1) var slide_speed : float = 4.0
@export var shapecast : ShapeCast3D
@export var slide_time : Timer

func enter() -> void:
	slide_time.start()
	animation.play("Slide", -1.0,slide_speed)
	speed = player.thrust_SPEED
	if player.power_armor != null:
		speed += player.power_armor.mobility

func update(delta):
	player.update_gravity(delta)
	player.update_velocity()
	
	if Input.is_action_just_released("crouch"):
		uncrouch()

func uncrouch():
	if shapecast.is_colliding() == false and Input.is_action_pressed("crouch") == false:
		player.is_thrusting = false
		animation.play("Slide", -1.0, slide_speed* 1.5, true)
		if animation.is_playing():
			await animation.animation_finished
		transition.emit("CrouchingPlayerState")
	elif shapecast.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch()


func _on_slide_timer_timeout():
	animation.play("Slide", -1.0, -slide_speed* 1.5, true)
	if animation.is_playing():
			await animation.animation_finished
	transition.emit("IdlePlayerState")

class_name ThrustBar
extends ProgressBar

@export var thrust_time : Timer
@export var armor : PowerArmor
@export var cool_label : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	thrust_time.wait_time = armor.thrust_fuel
	max_value = armor.thrust_fuel
	thrust_time.paused = false
	cool_label.visible = false

func _process(delta):
	if Global.player.is_thrusting:
		value = thrust_time.time_left
	if thrust_time.paused == true or thrust_time.is_stopped():
		cooldown(delta)
	if thrust_time.is_stopped() and Global.player.can_thrust == false:
		cool_label.visible = true
	else:
		cool_label.visible =false
		
	if Input.is_action_pressed("thrust") and Global.player.can_thrust and value == max_value and Global.player.velocity.length() > 0.0 :
		start_thrust()
	elif Input.is_action_pressed("thrust") and Global.player.can_thrust:
		thrust_time.paused = false
	elif Input.is_action_just_released("thrust"):
		thrust_time.paused = true
	if Input.is_action_pressed("jump") and Global.player.velocity.y > 0 and Global.player.can_thrust:
		start_thrust()
	elif Input.is_action_pressed("jump") and Global.player.can_thrust and Global.player.is_thrusting == false:
		start_thrust()
	elif Input.is_action_pressed("jump") and Global.player.can_thrust:
		thrust_time.paused = false
	elif Input.is_action_just_released("jump"):
		thrust_time.paused = true



func _on_thrust_timer_timeout():
	Global.player.is_thrusting = false
	Global.player.can_thrust = false
	

func cooldown(delta):
	value += 1.5 * delta
	if value == max_value:
		Global.player.can_thrust = true
	
func start_thrust():
	thrust_time.paused = false
	Global.player.is_thrusting = true
	thrust_time.start()

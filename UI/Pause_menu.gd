extends Control

@onready var anim = %AnimationPlayer

func _ready():
	visible = false
	anim.play("RESET")

func resume():
	visible = false
	get_tree().paused = false
	anim.play_backwards("blur")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func pause():
	visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	anim.play("blur")

func ESCmenue():
	if Input.is_action_just_pressed("pause") and not get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()

func _on_resume_pressed():
	resume()


func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	ESCmenue()

extends Control

func tutorial():
	get_tree().change_scene_to_file("res://Scenes/Levels/test_course.tscn")


func _on_tutorial_pressed():
	tutorial()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/test_level.tscn")
 

func _on_quit_pressed():
	get_tree().quit()

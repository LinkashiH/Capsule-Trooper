extends VBoxContainer

@export var current_ammo_label : Label

func _on_player_update_ammo(ammo):
	current_ammo_label.set_text(str(ammo[0])+ " / " + str(ammo[1]))

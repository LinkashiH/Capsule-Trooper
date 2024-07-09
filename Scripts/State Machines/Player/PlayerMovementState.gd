class_name PlayerMovementState
extends State

var player : Player
var animation : AnimationPlayer


func _ready() -> void:
	await  owner.ready
	player = owner as Player
	animation = player.animation_player

func _process(delta: float) -> void:
	pass

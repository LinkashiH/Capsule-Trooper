extends Label

@export var animation : AnimationPlayer

func  _process(delta):
	if visible:
		animation.play("blink")

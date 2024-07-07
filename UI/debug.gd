extends PanelContainer

#var property
var fps : String
@export var property_container : VBoxContainer

func _ready():
	visible = false
	Global.debug = self


func _input(event):
	if event.is_action_pressed("debug"):
		visible = !visible

#func add_debug_property(title : String, value):
	#property = Label.new()
	#property_container.add_child(property)
	#property.name = title
	#property.text = property.name + value 

func add_property(title : String, value,order):
	var target
	target = property_container.find_child(title,true,false)
	if !target:
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible:
		target.text = title + ": " + str(value)
		property_container.move_child(target,order)
	

func _process(delta):
	if visible:
		fps = "%.2f" % (1.0/delta)
		#property.text = property.name + ": " + fps

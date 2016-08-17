extends Node2D

var _label = null

var _name = 'Not Set'
var _number = 0

func _ready():
	_label = get_node("InfoLabel")
	update_label()

func render_label_text():
	return "Name = " + _name + "\nnumber = " + str(_number)

func update_label():
	_label.set_text(render_label_text())
